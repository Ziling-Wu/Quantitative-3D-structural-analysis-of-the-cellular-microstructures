function [normal,outTheta] =ori3(node0,node1,node2,node3,datas)

[x0,y0,z0]=ind2sub(datas,node0);
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);
[x3,y3,z3]=ind2sub(datas,node3);

v1=[x2-x1,y2-y1,z2-z1];v2=[x3-x1,y3-y1,z3-z1];
v1 = v1./norm(v1);
v2= v2./norm(v2);
normal=cross(v2, v1);
normal = normal./norm(normal);

vt1 = [x1-x0,y1-y0,z1-z0];
vt1 = vt1./norm(vt1);
vt2 = [x2-x0,y2-y0,z2-z0];
vt2 = vt2./norm(vt2);
vt3 = [x3-x0,y3-y0,z3-z0];
vt3 = vt3./norm(vt3);
theta = [acosd(dot(vt1,normal)),acosd(dot(vt2,normal)),acosd(dot(vt3,normal))];
if mean(theta)>90
    normal = -normal;
    outTheta = 180-max(theta);
else
    normal = normal;
    outTheta = max(theta);
end


end