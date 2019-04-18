function Tree = selectDenseGrid(dataGrid,Tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can output the  dense grids of each subspace of data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dataGrid: a matrix which dataGrid(i,j) indicate which grid  the NO.j 
%           dimension of the NO.i point belongs  to.
% Tau:  the density threshold (positive fraction)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tree: a tree which included the information about dense cells and each
%       element of the tree is a set of subspace which share the dimensionality
% Tree(1,i): subspaceSet

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialise
% the dimensionality of subspace
subspaceSet.dimensionality = [];
% the dense cells in this subspace
subspaceSet.subspace = [];
% the coverage of each subspapce in the set
subspaceSet.coverage = [];
subspace.cells = [];
subspace.dimenInfor = [];
[N,dimen] = size(dataGrid);
threshold = N*Tau;
Tree = [];

%% Determining 1-D dense units by making a pass over the data.
dimensionality = 1;
for i = 1:dimen
    cells = [];
    subspaceCoverage = 0;
    subspace.cells = [];
    subspace.dimenInfor = [];
    diffCell = unique(dataGrid(:,i));
    
    %% Count points in cell and obatin dense cells
    for j = 1:size(diffCell,1)
        numPoints = sum(dataGrid(:,i)==diffCell(j));
        if numPoints > threshold
           cells = [cells; diffCell(j)];
           subspaceCoverage = subspaceCoverage + numPoints;
        end
    end
    
    if ~isempty(cells)
        %% Store the dense cells
        subspace.cells = cells;
        subspace.dimenInfor = i;
        if isempty(subspaceSet.subspace)
            subspaceSet.subspace = {subspace};
            subspaceSet.dimensionality = dimensionality;
            subspaceSet.coverage =  subspaceCoverage;
        else
            subspaceSet.subspace = {subspaceSet.subspace{1,:},subspace};
            subspaceSet.coverage = [subspaceSet.coverage(1,:),subspaceCoverage];
        end
    end
end

% If all 1-dimension cell are not dense, return 
if isempty(subspaceSet.subspace)
    return;
end
Tree = {subspaceSet};
if dimen < 2
    return
end

%% Determining other dense units in higher dimension
for i = 2:dimen
   %% MDL-based pruning (Making the bottom-up algorithm faster)
    indexSavedSubspace = MDLbasedPruning(Tree{1,i-1}.coverage);
    
    numSavedSubspace = size(indexSavedSubspace,2);
    if numSavedSubspace < 2
        return;
    end
   
   %% Generate the set of candidate units and find dense units
   dimensionality = i;
   C = [];
   subspaceSet.dimensionality = [];
   subspaceSet.subspace = [];
   subspaceSet.coverage = [];
   subspace.cells = [];
   subspace.dimenInfor = [];
   
   dimenJoin =  zeros(2,i-1);
   for j = 1:numSavedSubspace-1
       dimenJoin(1,:) = Tree{1,i-1}.subspace{1,indexSavedSubspace(1,j)}.dimenInfor;
       for m = j+1:numSavedSubspace
         dimenJoin(2,:) = Tree{1,i-1}.subspace{1,indexSavedSubspace(1,m)}.dimenInfor;
         
         %% the join condition
         % The join condition being that units share the first k-2
         % dimensions
         canJoin = 0;
         if i == 2
             canJoin = 1;
         end
         if isequal(dimenJoin(1,1:end-1),dimenJoin(2,1:end-1))
             canJoin = 1;
         end
         
         %% Join
         if canJoin == 1
             C = cellJoin(Tree{1,i-1}.subspace{1,indexSavedSubspace(1,j)},...
                 Tree{1,i-1}.subspace{1,indexSavedSubspace(1,m)});
             
             %% Select the dense cells from candidates
             [subspaceCoverage,subspace]= DetermineRealDenseCell(C,dataGrid,threshold);
             
             if subspaceCoverage ~= 0
                 %% Store the dense cells
                 if isempty(subspaceSet.subspace)
                     subspaceSet.subspace = {subspace};
                     subspaceSet.dimensionality = dimensionality;
                     subspaceSet.coverage =  subspaceCoverage;
                 else
                     subspaceSet.subspace = {subspaceSet.subspace{1,:},subspace};
                     subspaceSet.coverage = [subspaceSet.coverage(1,:),subspaceCoverage];
                 end
             end
         end
       end
   end
   if ~isempty(subspaceSet.dimensionality)
       Tree = [Tree,subspaceSet];
   else
       return
   end
  
end

end
