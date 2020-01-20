function [theta]=interangle(node0,node1,node2,datas)
[x0,y0,z0]=ind2sub(datas,node0);
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);

v1=[x1-x0,y1-y0,z1-z0];v2=[x2-x0,y2-y0,z2-z0];

theta = acos(sum(v1.*v2)/norm(v1)/norm(v2));
end