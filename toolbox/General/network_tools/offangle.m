function [theta]=offangle(node0,node1,node2,node3)
global datas
[x0,y0,z0]=ind2sub(datas,node0);
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);
[x3,y3,z3]=ind2sub(datas,node3);

v1=[x1-x0,y1-y0,z1-z0];v2=[x2-x0,y2-y0,z2-z0];v3=[x3-x0,y3-y0,z3-z0];
a=cross(v1/norm(v1),v2/norm(v2));
theta=acos(sum(a.*v3)/norm(v3));
theta=theta*180/pi-90;
end