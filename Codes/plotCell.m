function plotCell(cell,xmax,xmin,ymax,ymin,Xi,clusters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function plot 2-D cells which are got from CLIQUE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cell: the set of cells (numCell * dimen * 2)
% xmax: the max value of x (1-by-1)
% xmin: the min value of x (1-by-1)
% Xi: the number of grids for each dimension  (integer)
% clusters: the label of each cell (numCell-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xgap =(xmax-xmin)/Xi;
ygap = (ymax-ymin)/Xi;
figure
hold on
colorbox = colormap;
numCell = size(cell,1);
for i = 1:numCell
    x1 = xmin + (cell(i,1,1)-1)*xgap;
    x2 = xmin + cell(i,1,2)*xgap;
    y1 = ymin + (cell(i,2,1)-1)*ygap;
    y2 = ymin + cell(i,2,2)*ygap;
    fill([x1,x2,x2,x1],[y1,y1,y2,y2],colorbox(mod(5*clusters(i),61)+1,:));
end
hold off
end