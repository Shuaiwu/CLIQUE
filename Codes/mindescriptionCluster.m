function [growthCellSet,growthCellLabel] = mindescriptionCluster(cells,clusterLabel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can generate a minimal descriptions of a cluster (greedy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  cells: dense cell in the same cluster (numCells-by-dimen)
%  clusterLabel: the label of the cluster (1-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% growthCell: a set of cells for the minimal cluster description
%            (numGrowthCell * dimen * 2)
% growthCellLabel: the labels of each dense cell (numGrowthCell-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : July 14 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[numCells,~] = size(cells);

%% Greedily cover the cluster by aa number of maximal rectangle
global isVisted ;
isVisted = false(numCells,1);
index = randperm(numCells);
growthCellSet = [];
numGrowthCell = 0;
for i = index
    if ~isVisted(i)
        isVisted(i) = true;
        numGrowthCell = numGrowthCell +1;
        growthCell(1,:,1) = cells(i,:);
        growthCell(1,:,2) = cells(i,:);
        growthCellSet = [growthCellSet;growth(growthCell,cells)];
    end
end

%% Calculate the volume of cells
volumeCells = zeros(numGrowthCell,1);
discardCells = false(numGrowthCell,1);
for i = 1:numGrowthCell
    volumeCells(i) = prod((growthCellSet(i,:,2)-growthCellSet(i,:,1))+1);
end
[~,indexVolume] = sort(volumeCells);

%% Discard the redundant rectangles to generate a minimal cover
for i = 1:numGrowthCell
    discardCells(i) = canDiscard(growthCellSet,discardCells,indexVolume(i));
end
growthCellSet(discardCells,:,:) = [];

growthCellLabel = repmat(clusterLabel,size(growthCellSet,1),1);
end

function growthCell = growth(growthCell,cells)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can grow growthCell as much as possible.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% growthCell: the  cell which needs to growth (1 * dimen * 2)
% cells: dense cell in the same cluster (numCells-by-dimen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% growthCell: the cell after growth (1 * dimen * 2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : July 14 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global isVisted ;

[N,dimen] = size(cells);
%% Randomly select the order of dimension 
dimenGrowthO = randperm(dimen);

%% Grow cell in each dimension
for i = dimenGrowthO
    Condition1 = true(N,1);
    for j = 1:dimen
        if j ~= i
            Condition1 = Condition1 &(cells(:,j)>=growthCell(1,j,1))&(cells(:,j)<=growthCell(1,j,2));
        end
    end
    tempGrowthCell = zeros(2,dimen);
    if dimen >1
        tempGrowthCell(1,:) = growthCell(1,:,1);
        tempGrowthCell(2,:) = growthCell(1,:,2);
        tempGrowthCell(:,i) = [];
        Area = prod((tempGrowthCell(2,:)-tempGrowthCell(1,:))+1);
    else
        Area = 1;
    end
    
    %% Grow in two directions( right and left)
    for k = 1:2
        while 1
            neighborExam = cells(:,i)==growthCell(1,i,k)-1+2*(k>1);
            index = Condition1 & neighborExam;
            if sum(index) == Area
                isVisted(index,1) = true;
                growthCell(1,i,k) = growthCell(1,i,k)-1+2*(k>1);
            else 
                break;
            end
        end
    end
end
end
