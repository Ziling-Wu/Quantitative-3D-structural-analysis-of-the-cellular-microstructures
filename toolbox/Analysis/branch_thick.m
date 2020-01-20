function thickness = branch_thick(newbran,middlebran,direction,img)
xsize = size(img,1);ysize = size(img,2);zsize = size(img,3);
numbran = length(newbran);
imgcor = find(img);
[imgcorx,imgcory,imgcorz] = ind2sub([xsize ysize zsize],imgcor); 
imgxyz = [imgcorx,imgcory,imgcorz];
thickindex = 1;
for i = 1:numbran
    index = 1;
    clear orthogonal
    x0 = middlebran(i,1);y0 = middlebran(i,2);z0 = middlebran(i,3);
    if x0>5 && x0<xsize-5 &&y0>5 && y0<ysize-5 &&z0>5 && z0<zsize-5
        dis = 10;
        loc = chooseregion(imgxyz,middlebran(i,:),dis);
        n = direction(i,:);
        for j = 1:length(loc)
            t = [imgcorx(loc(j)) - x0,imgcory(loc(j)) - y0,imgcorz(loc(j)) - z0];
            stand = norm(t);
            proj = abs(dot(t,n)*n);%acos(abs(dot(t,n))/stand)*180/pi;
            if proj(1)<0.5 && proj(2)<0.5 && proj(3)<0.5&& norm(proj)<0.5
                orthogonal(index,1:3) = [imgcorx(loc(j)),imgcory(loc(j)),imgcorz(loc(j))];
                index = index+1;
            end
        end
        thickness(thickindex,1) = i;%ID
        thickness(thickindex,2) = x0;%thickness
        thickness(thickindex,3) = y0;%thickness
        thickness(thickindex,4) = z0;%thickness
        thickness(thickindex,5) = size(orthogonal,1);%thickness
        thickindex = thickindex+1;
    end
        
end
%% show figure
% clf
% areacor = find(BW);
% [a,b,v] = find(BW);
% [areacorx,areacory,areacorz] = ind2sub([xsize ysize zsize],areacor); 
% scatter3(imgcory,imgcorx,imgcorz,10,'b','filled');
% hold on;
% plot3([startbran(i,2),startbran(i,5)],[startbran(i,1),startbran(i,4)],[startbran(i,3),startbran(i,6)],'LineWidth',20);
% hold on;
% scatter3(y0,x0,z0,150,'g','filled');
% hold on;
% scatter3(orthogonal(:,2),orthogonal(:,1),orthogonal(:,3),100,'r');
