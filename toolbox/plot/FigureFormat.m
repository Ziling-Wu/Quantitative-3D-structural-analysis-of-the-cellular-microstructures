function []=FigureFormat(angle,height)
if nargin<1
    angle=120;height=20;
elseif nargin<2
    height=20;
end

a=gca;
box on 
axis image
a.BoxStyle = 'full';
a.FontSize=16;
a.LineWidth=1.5;
xticks({})
yticks({})
zticks({})
xticklabels({})
yticklabels({})
zticklabels({})
view(angle,height)
set(gcf,'color','white')
% xlim([1 datas(3)])
% ylim([1 datas(1)])
% zlim([1 datas(2)])


end