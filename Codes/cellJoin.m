function C = cellJoin(subspaceA,subspaceB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can generate cells ( (k+1)-D ) from subspaceA (k-D) and
% subspaceB(k-D).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subspaceA : the subpace (struct)
%    subspaceA.dimenInfor : the dimension information about the subpace
%    subspaceA.cells : the cells of the subspace 
% subspaceB : same as subspaceA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C : the subpace (struct)
%    C.dimenInfor : the dimension information about the subpace
%    C.cells : the cells of the subspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : Aug 10 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C.cells = [];
C.dimenInfor = [];
if max(subspaceA.dimenInfor(1,end),subspaceB.dimenInfor(1,end))~=subspaceB.dimenInfor(1,end)
    temp = subspaceA;
    subspaceA = subspaceB;
    subspaceB = temp;
end
C.dimenInfor = [subspaceA.dimenInfor,subspaceB.dimenInfor(1,end)];
[numCellsA,dimen] = size(subspaceA.cells);
numCellsB = size(subspaceB.cells,1);
num = numCellsB;
index = true(numCellsB,1);

%% Join 
for i = 1:numCellsA
    if dimen>1
        index = sum(subspaceB.cells(:,1:end-1)==...
            repmat(subspaceA.cells(i,1:end-1),numCellsB,1),2)==dimen-1;
        num = sum(index);
    end
    if num~=0
        cells = [repmat(subspaceA.cells(i,:),num,1),subspaceB.cells(index,end)];
        C.cells  = [C.cells ;cells];
    end
end

end