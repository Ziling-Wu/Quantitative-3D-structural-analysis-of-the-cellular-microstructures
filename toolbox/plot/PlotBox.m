function []=PlotBox(v1,trans)
if nargin<2
    trans=1;
end
[x,y,z]=meshgrid(1:size(v1,2),1:size(v1,1),1:size(v1,3));
h=slice(x,y,z,v1,max(x(:)),max(y(:)),max(z(:)));
for i=1:3
h(i).FaceColor = 'interp';
h(i).EdgeColor = 'none';
h(i).DiffuseStrength = 0;
h(i).FaceLighting='gouraud';
h(i).FaceAlpha=trans;
end

colormap gray
a=gca;
box on
axis equal
 a.BoxStyle = 'full';
 a.LineWidth=3;
 xticks({})
yticks({})
zticks({})
xticklabels({})
yticklabels({})
zticklabels({})
view(120,30)
 set(gcf,'color','white')

end