clear
close all
clc


%% Load the data set
%dataName = 'TOX-171.mat';
dataName = 't48k.mat';
load(dataName);


%% Clustering
% the number of intervals
Xi = 30;
% density threshold
Tau = 1.55e-3;

[clustersTree,dataGrid] = CLIQUE(X,Xi,Tau);
clusterResult = obtainLabelByCLIQUE(clustersTree,dataGrid);


%% Plot the result of clustering (only for 2-D subspace)
if size(clustersTree,2)>1
    dimenInfor = clustersTree{1,2}.subspace{1,1}.dimenInfor;
    cells = clustersTree{1,2}.subspace{1,1}.cells;
    cellLabels = clustersTree{1,2}.subspace{1,1}.labels;
    data = X(:,dimenInfor);
    xmax = max(data(:,1),[],1);
    xmin = min(data(:,1),[],1);
    ymax = max(data(:,2),[],1);
    ymin = min(data(:,2),[],1);
    plotCell(cells,xmax,xmin,ymax,ymin,Xi,cellLabels);
end
   