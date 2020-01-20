% https://www.mathworks.com/matlabcentral/answers/297854-best-fitting-a-plane-ax-by-cz-0-where-c-could-be-0
% Important reference!!!
function [Fit,errors] = planeFitting_v2(test,datas) % For testing the orientation distribution oly
[xt,yt,zt] = ind2sub(datas,test); % x,y,z instead of y,x,z here

X = [xt,yt,zt];
p = mean(X,1);
R = bsxfun(@minus,X,p);
[~,~,V] = svds(R,1,'smallest'); 
% svd finds the eigenvectors and eigenvalues for R'*R, so no need to use
% R'*R as input
n = V;

dd = -dot(p,n);
% [V,~] = eigs(R'*R,1,'SM');
% n = V;
% [V,~] = eig(R'*R);

% n = V(:,1);
% V = V(:,2:end);

Fit = n;
Fit(4) = dd;
errors = -X*n-dd;