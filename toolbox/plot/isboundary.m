function b=isboundary(p, threshold,datas)

[x,y,z]=ind2sub(datas,p);

if nargin<2
    threshold=5;
end

b=(min(x)<threshold)|((datas(1)-max(x))<threshold);
b=b|(min(y)<threshold)|((datas(2)-max(y))<threshold);
b=b|(min(z)<threshold)|((datas(3)-max(z))<threshold);
end