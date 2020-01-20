function n = neighbor(cor,s)

% this function found the linear index of the 27 neighbors of the linear
% indexed voxel cor, with size give by s. The out-of-boundary neighbors are
% removed. 

[x1,y1,z1] = ind2sub(s,cor);

xsize=s(1);ysize=s(2);zsize=s(3);

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
m = [x(:),y(:),z(:)];
for i=1:size(m,1)
n(i)=sub2ind(s,m(i,1),m(i,2),m(i,3));
end
end
