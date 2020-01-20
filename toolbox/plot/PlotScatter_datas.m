function []=PlotScatter_datas(skel,dotsize,dotcolor,datas)


if nargin<2
    dotsize=40;dotcolor=[0.5,0.5,0.5];datas = size(skel);
elseif nargin<3
    dotcolor=[0.5,0.5,0.5];datas = size(skel);
elseif nargin<4
    datas = size(skel);
end
if size(skel,3)>1
    xsize = size(skel,1);ysize = size(skel,2);zsize = size(skel,3);
    skelcor = find(skel);
    [skelcorx,skelcory,skelcorz] = ind2sub([xsize ysize zsize],skelcor);
elseif size(skel,2)==3
    skelcorx=skel(:,1);skelcory=skel(:,2);skelcorz=skel(:,3);
elseif size(skel,2)==1
    [skelcorx,skelcory,skelcorz]=ind2sub(datas,skel);
end
    
scatter3(skelcory,skelcorx,skelcorz,dotsize,dotcolor,'filled');



% aixs([100 200 100 150 100 150])

end 