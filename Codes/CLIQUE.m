function  [clustersTree,dataGrid] = CLIQUE(Data, Xi, Tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is an implementation of CLIQUE (Clustering In QUEst).
% Rakesh Agrawal, Johannes Gehrke, Dimitrios Gunopulos, and Prabhakar Raghavan.
% Automatic subspace clustering of high dimensional data.Data Mining and 
% Knowledge Discovery, 11(1):5иC33, Jul 2005.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-dimen)
% Xi: the number of intervals for each dimension (integer)
% Tau: the density threshold (positive fraction)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clustersTree: the result of clustering (tree)
%      clustersTree{1, i}.dimensionality:the dimensionality of the subspace 
%                                         set(positive integer)
%      clustersTree{1, i}.coverage: the coverage of each subspace in the 
%                                   set(1-by-~)
%      clustersTree{1, i}.subspace: the subspace set ги1-by-~)
%                                   (each element of the set can represent
%                                    a subspace.)
%      
% dataGrid : a matrix which shows the grid that each point belongs to.
%             The NO.j dimension of NO.i point belongs to NO.dataGrid (i,j)
%             grid of this dimension (N-by-dimen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clustersTree = cell(1);


%% Assign  data points into grids
dataGrid = gridGenerator(Data,Xi); 


%% Select the dense grids
Tree = selectDenseGrid(dataGrid,Tau); 


if isempty(Tree) 
    return
end


clustersTree = Tree;
for i = 1:size(Tree,2)
    for j = 1 :size(Tree{1,i}.subspace,2)
        
        %% Identification of clusters
        clusters = findClusters(Tree{1,i}.subspace{1,j}.cells);
        
        %% Generate minimal cluster description
        clusters = mindescription(clusters);
        
        %% Store the cluster
        clustersTree{1,i}.subspace{1,j}.cells = clusters.cells;
        clustersTree{1,i}.subspace{1,j}.labels = clusters.labels;
    end
end

end
