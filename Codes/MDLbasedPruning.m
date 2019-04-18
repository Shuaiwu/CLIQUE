function D = MDLbasedPruning(Coverage)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script help users to prune same subspace based on minimal description
% length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coverage: the coverage of subspace set 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D: the index of subspace set  after pruning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : June 30 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numOfSpace = size(Coverage,2);

%% Sort the subspace in the decending order of their coverage
[Coverage,index] = sort(Coverage,'descend');
CL = zeros(1,numOfSpace);

%% If there are only two subspace left, we don't employ MDL to discard 
%% subspace
if numOfSpace <=2
    D = index;
    return 
end

%% Compute the length of code
for i = 1:numOfSpace-1
    mui = mean(Coverage(1,1:i));
    mup = mean(Coverage(1,i+1:end));
    CL(i) = mlog2(mui)+mlog2(mup)+...
        sum(mlog2(abs(Coverage(1,1:i)-mui)),2)+...
        sum(mlog2(abs(Coverage(1,i+1:end)-mup)),2);
end
mui = mean(Coverage);
CL(numOfSpace) = mlog2(mui)+sum(mlog2(abs(Coverage-mui)));

%% Minimize the length of code to determine the optimal cut point i
[~,cut] = min(CL);
D = index(1,1:cut);
end
function y = mlog2(x)
x(x==0) = 1;
y = log2(x);
end
