function [fit,errors] = planeFitting(test)
global datas
[x,y,z] = ind2sub(datas,test);
b = -z;
A = [x,y,ones(size(x))];
fit = ((transpose(A) * A))\(transpose(A) * b);

errors = -b + A * fit;
