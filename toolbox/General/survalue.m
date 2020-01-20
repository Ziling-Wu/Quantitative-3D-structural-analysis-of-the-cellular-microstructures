function [val,s] = survalue(cor,img)
global datas
xsize = datas(1);
ysize = datas(2);
zsize = datas(3);
%[x1,y1,z1] = ind2sub(datas,cor);
x1 = cor(1);y1 = cor(2);z1 = cor(3);
if x1<=1
    xs =1;
else
    xs= x1-1;
end
if x1>=xsize
    xe = xsize;
else
    xe=x1+1;
end
if y1<=1
    ys =1;
else
    ys=y1-1;
end
if y1>=ysize
    ye = ysize;
else
    ye=y1+1;
end
if z1 <= 1
    zs = 1;
else
    zs = z1-1;
end
if z1>=zsize
    ze = zsize;
else
    ze=z1+1;
end
x = xs:xe; y = ys:ye; z = zs:ze;
[x,y,z] = meshgrid(x,y,z);
s = [x(:),y(:),z(:)];
val = zeros(size(s,1),1);
for i = 1:size(s,1)
    val(i,1) = img(s(i,1),s(i,2),s(i,3));
end