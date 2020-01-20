function d=mydistance(node1,node2)
global datas
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);
d=sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
end