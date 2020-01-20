function [theta,phi]=myanglez(node1,node2,x)
% this function finds the orientation of the line between node1 and node2
% in the coodinate system of z and xy (x==1), x zy (x==2) and y xz (x==3) 
global datas
[x1,y1,z1]=ind2sub(datas,node1);
[x2,y2,z2]=ind2sub(datas,node2);

if nargin<3
    x=1;
end

if x==1

phi=atan(sqrt((x1-x2)^2+(y1-y2)^2)/abs(z2-z1));
theta=atan((y1-y2)/(x1-x2));

elseif x==2
        
phi=atan(sqrt((z1-z2)^2+(y1-y2)^2)/abs(x2-x1));
theta=atan((y1-y2)/(z1-z2));

elseif x==3
    
phi=atan(sqrt((z1-z2)^2+(x1-x2)^2)/abs(y2-y1));
theta=atan((x1-x2)/(z1-z2));
end
        
end