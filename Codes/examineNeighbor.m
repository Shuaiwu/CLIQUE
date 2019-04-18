function Nighbor = examineNeighbor(indexOfCell,denseGrid,searchDimen,direction)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function examine whlether the neighbor of a cell is dense.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indexOfCell: the index of examined cell 
% denseGrid: the set of dense cells
% searchDimen: the examined dimension
% direction: the direction of examination( 1 for right and -1 for left)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nighbor: the index of dense neigbor if the examined neighbor is dense,
%   otherwise, Nighbor is set to 0.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp = denseGrid;
Nighbor = 0;
[N,dimen] = size(denseGrid);

%% Compare the other dimensions
index = true(N,1);
if dimen ~= 1
    temp(:,searchDimen) = [];
    index = sum(temp == repmat(temp(indexOfCell,:),N,1),2)==dimen-1;
end

%% Compare the searched dimensions
flag = denseGrid(:,searchDimen)==(denseGrid(indexOfCell,...
          searchDimen)+direction);
      
exam = flag&index;
if sum(exam)~=0
    Nighbor = find(exam==1);
end
end