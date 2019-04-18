function discard = canDiscard(cells,discardCells,index)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can determinne whether a hyper-rectangle can be deleted
% from a cluster to get a minimal description of cluster.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cells: the set of cells of the cluster (numCells * dimen * 2)
% discardCells: If No.i cell of the cells set has been deleted,
%               discardCells(i) = true  (numCells-by-1)
% index: the index of cell needing to be examed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% discard: true for the case that the cell can be deleted (Boolean)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : Aug 10 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
discard  = false;
cellsMax = cells(~discardCells,:,2);
cellsMin = cells(~discardCells,:,1);
examCellMax = cells(index,:,2);
examCellMin = cells(index,:,1);
numCell = size(cellsMax,1);

%% Calculate the number of units the cell contains
num = prod((cells(index,:,2)-cells(index,:,1))+1);
dimen = size(cells,2);
unit = ones(1,dimen);
cellInterval = examCellMax-examCellMin+1;
codeC = (num+1)*ones(1,dimen);
temp = 1;
for i = dimen:-1:1
    if cellInterval(i)~=1
       codeC(i) = temp;
       temp = prod(cellInterval(i:end));
    end
end

%% Determine whelther each units of the examCell is still in the cluster.
%% If yes, the examCell can be deleted
for i = 1:num
    temp = i-1;
    for j = 1:dimen
        unit(j) = floor(temp/codeC(j));
        temp = mod(temp,codeC(j));
    end
    unit = unit + examCellMin;
    inCellAfterD = sum(sum((cellsMax>=repmat(unit,numCell,1))&(cellsMin<=repmat(unit,numCell,1)),2)==dimen);
    if inCellAfterD == 0
        return;
    end
end

end