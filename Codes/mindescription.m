function MDCluster = mindescription(clusters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can generate a minimal descriptions of a set of clusters (greedy)
% (non-redundant covering of the cluster with maximal regions)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cluster: struct
%  cluster.cells: dense cell (numCells-by-dimen)
%  cluster.labels: the labels of each dense cell (numDenseGrid-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MDCluster: struct
%  MDCluster.cells: dense cell (numCells * dimen * 2)
%  MDCluster.labels: the labels of each dense cell (numDenseGrid-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : July 14 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cells = clusters.cells;
labels = clusters.labels;
clusterLabel = unique(labels);
numCluster = size(clusterLabel,1);
MDCluster.cells = [];
MDCluster.labels = [];
for i = 1:numCluster
    
    %% Find cells in the same cluster
    index = labels == clusterLabel(i);
    
    %% Get minimal description of the cluster
    [growthCell,growthCellLabel] = mindescriptionCluster(cells(index,:),clusterLabel(i));
    
    %% Store the minimal description of the cluster
    MDCluster.cells = [MDCluster.cells; growthCell];
    MDCluster.labels = [MDCluster.labels;growthCellLabel];
end
end

