function cluster = findClusters(denseGrid)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can cluster the same k-dimension dense grid into different
% clusters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% denseGrid: dense units matrix (numDenseGrid-by-dimen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cluster: struct
%  cluster.cells: dense cell (numDenseGrid-by-dimen)
%  cluster.labels: the labels of each dense cell (numDenseGrid-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize
numDenseGrid = size(denseGrid,1);
global clusters;
clusters = zeros(numDenseGrid,1);
numCluster = 0;

%% Label
for i = 1:numDenseGrid
    if clusters(i,1) == 0
       numCluster = numCluster + 1;
       
       %% Use a depth-first search algorithm to find the cluster
       deepFirstSearch(i,denseGrid,numCluster);
    end
end

cluster.cells = denseGrid;
cluster.labels = clusters;

end

function deepFirstSearch(indexOfCell,denseGrid,indexOfCluster) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function find all dense cell which is conneccted with the initial
% cell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indexOfCell: the index of initial cell
% denseGrid: the set of dense cells 
% indexOfCluster: the index of cluster of initial cell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global clusters;

%% Label the initial cell
clusters(indexOfCell) = indexOfCluster;

%% Search connected dense cells
dimen = size(denseGrid,2);
for i = 1:dimen
    %% Examine the right neighbor of the cell in i-D
    rNighbor = examineNeighbor(indexOfCell,denseGrid,i,+1);
    if rNighbor
        if clusters(rNighbor)==0
            deepFirstSearch(rNighbor,denseGrid,indexOfCluster)
        end
    end
    
    %% Examine the left neighbor of the cell in i-D
    LNighbor =examineNeighbor(indexOfCell,denseGrid,i,-1);
    if LNighbor
        if clusters(LNighbor)==0
            deepFirstSearch(LNighbor,denseGrid,indexOfCluster)
        end
    end
end
end

