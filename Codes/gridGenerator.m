function dataGrid = gridGenerator(Data,Xi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can assign points of dataset into grids.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-dimen)
% Xi: the number of grids for each dimension  (intergal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dataGrid: a matrix which dataGrid(i,j) indicate which grid  the NO.j 
%           dimension of the NO.i point belongs  to.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,dimen] = size(Data);
dataGrid = zeros(N,dimen);
datamax = max(Data,[],1);
datamin = min(Data,[],1);
interval = (datamax-datamin)/Xi;
for i = 1 : dimen
    temp = Data(:,i);
    for j = Xi : -1 : 1
        index = (temp<=(datamax(i)-interval(i)*(Xi-j)));
        dataGrid(index,i) = j;
    end
end
end
