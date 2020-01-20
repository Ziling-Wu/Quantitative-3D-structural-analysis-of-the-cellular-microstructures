function [p]=PlotSurf(v1,trans,rescale)

if nargin<2
    trans=0.5;rescale=1;
elseif nargin<3
    rescale=1;
end

[x,y,z]=meshgrid(1:rescale:rescale*size(v1,2),1:rescale:rescale*size(v1,1),1:rescale:rescale*size(v1,3));
fv = isosurface(x,y,z,v1,0.5);
p = patch(fv);

p.FaceColor = [0.9,0.9,0.9];
p.EdgeColor = 'none';
p.FaceLighting='gouraud';
p.FaceAlpha=trans;

camlight
%camlight(-0,-10)
camlight(90,10)

lighting gouraud
material shiny

colormap gray
a=gca;
box off
axis off
axis equal
 %a.BoxStyle = 'full';
 a.LineWidth=3;
 xticks({})
yticks({})
zticks({})
xticklabels({})
yticklabels({})
zticklabels({})
view(80,40)
 set(gcf,'color','white')
