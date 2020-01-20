function output = histofrequency(da,nbin)
if nargin<2    
[N,edges] = histcounts(da);
else
    [N,edges] = histcounts(da,nbin);
end
    

Num = sum(N);
output = zeros(length(N),2);
for i = 1:length(N)
    output(i,1) = (edges(i)+edges(i+1))/2;
    output(i,2) = N(i)/Num;
end