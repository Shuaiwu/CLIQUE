function [coverage,subspace]= DetermineRealDenseCell(C,dataGrid,threshold)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can output the dense cells in C.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C: the subpace (struct)
%    C.dimenInfor: the dimension information about the subpace
%    C.cells: the cells of the subspace
% dataGrid: a matrix which dataGrid(i,j) indicate which grid  the NO.j 
%           dimension of the NO.i point belongs  to.
% threshold: the number of points that dense cell must be greater
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% coverage: the coverage of the subspace
% subspace: the subpace (struct)
%    subspace.dimenInfor: the dimension information about the subpace
%    subspace.cells: the cells of the subspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : June 16 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     dimenInfor = C.dimenInfor;
     subspace.dimenInfor = dimenInfor;
     subspace.cells = [];
     [numOfCell,dimen] = size(C.cells);
     discard = true(numOfCell,1);
     numOfDataCell = size(dataGrid,1);
     coverage = 0;
     for i = 1:numOfCell
         isInCell = true(numOfDataCell,1);
         for j = 1:dimen
             isInCell = isInCell&(dataGrid(:,dimenInfor(1,j))==C.cells(i,j));
         end
         numPoints = sum(isInCell);
         if numPoints >= threshold
             discard(i,1) = false;
             coverage = coverage + numPoints;
         end
     end
     subspace.cells = C.cells(~discard,:);

end