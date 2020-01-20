function [theta,phi,z]=myangle(node1,node2,datas)
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);
if z1 == z2
    theta = 0 ;
else
theta = abs(atan(abs(y1-y2)/abs(z1-z2)))*180/pi;
if x1<x2
    y = y2-y1;
    z = z2-z1;
else
    y = y1-y2;
    z = z1-z2;
end
if (y>=0)&&(z>0)
    theta = 360-theta;
elseif (y>=0)&&(z<=0)
    theta = 180+theta;
elseif (y<0)&&(z<=0)
    theta = 180-theta;
else
    theta = theta;
end
end
if x1 == x2
    phi = 0 ;
else
phi = atand(sqrt((z1-z2)^2+(y1-y2)^2)/abs(x2-x1));
end
z = z1-z2;
end