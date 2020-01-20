% =========================================================================
% Sub-Function inside the main function for ring plotting
% =========================================================================


cont = edge3(orig,'approxcanny',0.6);% branch contour
%% 4-Edge rings
fprintf('Start 4-Edge ring plotting ... It will take some time.\n') 
figure
ring4 = ring{1};
% ring4 = [];
if ~isempty(ring4)
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc4,1)
    j = loc4(k,1);
    i = loc4(k,2);
    tempRingDots = ring4{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0, 0.9, 0.9],datas)%[0.8500, 0.3250, 0.0980]
hold on
PlotScatter_datas(tempRing(:),30,'r',datas)
hold on
PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],datas)
FigureFormat
end
% saveas(gcf,'ring5lessthan8','epsc');
% saveas(gcf,'ring5lessthan8','pdf');
% saveas(gcf,'ring5lessthan8','png');

% Ring 5
hold on 
ring5 = ring{2};
if ~isempty(ring5)

tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc5,1)
    j = loc5(k,1);
    i = loc5(k,2);
    tempRingDots = ring5{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0.8500, 0.3250, 0.0980],0)%[0.8500, 0.3250, 0.0980]
hold on
PlotScatter_datas(tempRing(:),30,'r',0)
hold on     
% PlotScatter_datas(tempNode(:),50,'k',0)
%    hold on
PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
end
% saveas(gcf,'ring5lessthan8','epsc');
% saveas(gcf,'ring5lessthan8','pdf');
% saveas(gcf,'ring5lessthan8','png');
% Ring 6
% clf
hold on
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc6,1)
    j = loc6(k,1);
    i = loc6(k,2);
    tempRingDots = ring6{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0,0.5,0],0)%[0,0.5,0]
hold on
PlotScatter_datas(tempRing(:),30,'r',0)
%     hold on
    
% PlotScatter_datas(tempNode(:),50,'k',0)
%    hold on
PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
% saveas(gcf,'ring6lessthan8','epsc');
% saveas(gcf,'ring6lessthan8','pdf');
% saveas(gcf,'ring6lessthan8','png');

% Ring 7
% clf
if ~isempty(ring7)
hold on
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc7,1)
    j = loc7(k,1);
    i = loc7(k,2);
    tempRingDots = ring7{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
end
PlotScatter_datas(tempBran,8,'b',0)%'b'[0.5,0.5,0.5]
hold on 
PlotScatter_datas(tempRing(:),30,'r',0)
% hold on
% PlotScatter_datas(tempNode(:),50,'k',0)
hold on
PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
end
saveas(gcf,'ring_all','epsc');
saveas(gcf,'ring_all','pdf');
saveas(gcf,'ring_all','png');
%% crop one 4-E ring
clf
ring4 = ring{1};
tempBran = [];
tempRing = [];
tempNode = [];
for k = 117%size(loc5,1)
    j = loc4(k,1);
    i = loc4(k,2);
    tempRingDots = ring4{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0.8500, 0.3250, 0.0980],0)%

    hold on

    PlotScatter_datas(tempRing(:),30,'r',0)
    hold on
%     
PlotScatter_datas(cont,1,[0.4,0.4,0.4],0)
   hold on
   PlotScatter_datas(trimskel,2,[0.6,0.6,0.6],0)
FigureFormat
view(105,13)
[z1,y1,x1] = ind2sub(datas,tempRing(1));
[z2,y2,x2] = ind2sub(datas,tempRing(2));
[z3,y3,x3] = ind2sub(datas,tempRing(3));
[z4,y4,x4] = ind2sub(datas,tempRing(4));
xmin = min([x1,x2,x3,x4]);
xmax = max([x1,x2,x3,x4]);
ymin = min([y1,y2,y3,y4]);
ymax = max([y1,y2,y3,y4]);
zmin = min([z1,z2,z3,z4]);
zmax = max([z1,z2,z3,z4]);
axis([xmin-20 xmax+20 ymin-20 ymax+20 zmin-20 zmax+20])
% saveas(gcf,'ring5lessthan8','epsc');
saveas(gcf,'ring4Example','pdf');
% saveas(gcf,'ring5lessthan8','png');


%%
figure
temp4 = cont;
temp4(tempRing) = 10;
temp4(tempBran) = 10;
% [x,y,z] = ind2sub(datas,tempRing(4));
img = temp4(xmin-20:xmax+20,ymin-20:ymax+20,zmin-20:zmax+20);
% PlotScatter_datas_datas(img,2,[0.6,0.6,0.6],0,size(img))
% view(105,13)
FigureFormat
for i =1:size(img,3)
    im = img(:,:,i);
    imwrite(im,[num2str(i),'.tif']);
end

%% crop one 5-E ring
clf
ring5 = ring{1};
tempBran = [];
tempRing = [];
tempNode = [];
for k = 200%size(loc5,1)
    j = loc5(k,1);
    i = loc5(k,2);
    tempRingDots = ring5{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0.8500, 0.3250, 0.0980],0)%

    hold on

    PlotScatter_datas(tempRing(:),30,'r',0)
    hold on
%     
PlotScatter_datas(cont,1,[0.4,0.4,0.4],0)
   hold on
   PlotScatter_datas(trimskel,2,[0.6,0.6,0.6],0)
FigureFormat
view(105,13)
[z,y,x] = ind2sub(datas,tempRing(4));
disx = 26;disy = 30;disz = 50;
axis([x-30 x+30 y-60 y+25 z-30 z+50])
% saveas(gcf,'ring5lessthan8','epsc');
% saveas(gcf,'ring5lessthan8','pdf');
% saveas(gcf,'ring5lessthan8','png');


%%
figure
temp5 = cont;
temp5(tempRing) = 2;
temp5(tempBran) = 2;
[x,y,z] = ind2sub(datas,tempRing(4));
img = temp5(x-30:x+50,y-60:y+25,z-30:z+30);
PlotScatter_datas_datas(img,2,[0.6,0.6,0.6],0,size(img))
view(105,13)
for i =1:size(img,3)
    im = img(:,:,i);
    imwrite(im,[num2str(i),'.tif']);
end

%% crop one 6-E ring
% Ring 6
% clf
clf
tempBran = [];
tempRing = [];
tempNode = [];
for k = 12%size(loc6,1)
    j = loc6(k,1);
    i = loc6(k,2);
    tempRingDots = ring6{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[0,0.5,0],0)%[0,0.5,0]
    hold on

    PlotScatter_datas(tempRing(:),30,'r',0)
    hold on
%     
PlotScatter_datas(cont,1,[0.4,0.4,0.4],0)
   hold on

   PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
[z,y,x] = ind2sub(datas,tempRing(3));
disx = 30;disy = 60;disz = 50;
axis([x-40 x+15 y-30 y+60 z-10 z+60])
view(108,7)
saveas(gcf,'ring6lessthan8','epsc');
saveas(gcf,'ring6lessthan8','pdf');
saveas(gcf,'ring6lessthan8','png');
%%
figure
temp6 = cont;
temp6(tempRing) = 2;
temp6(tempBran) = 2;
[x,y,z] = ind2sub(datas,tempRing(3));
img = temp5(x-10:x+60,y-30:y+60,z-40:z+15);
PlotScatter_datas_datas(img,2,[0.6,0.6,0.6],0,size(img))
view(108,7)
for i =1:size(img,3)
    im = img(:,:,i);
    imwrite(im,[num2str(i),'.tif']);
end
%% crop one 7-E ring
clf
tempBran = [];
tempRing = [];
tempNode = [];
for k = 5%size(loc6,1)
    j = loc7(k,1);
    i = loc7(k,2);
    tempRingDots = ring7{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
PlotScatter_datas(tempBran,8,[59,84,164]/255,0)%[0,0.5,0]
    hold on

    PlotScatter_datas(tempRing(:),30,'r',0)
    hold on
%     
PlotScatter_datas(cont,1,[0.4,0.4,0.4],0)
   hold on

   PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
[z,y,x] = ind2sub(datas,tempRing(3));
disx = 50;disy = 60;disz = 50;
axis([x-60 x+23 y-60 y+20 z-60 z+30])
view(54,12)
saveas(gcf,'ring7lessthan8','epsc');
saveas(gcf,'ring7lessthan8','pdf');
saveas(gcf,'ring7lessthan8','png');
%%
figure
temp7 = cont;
temp7(tempRing) = 2;
temp7(tempBran) = 2;
[x,y,z] = ind2sub(datas,tempRing(3));
img = temp5(x-60:x+30,y-60:y+20,z-55:z+23);
PlotScatter_datas_datas(img,2,[0.6,0.6,0.6],0,size(img))
view(54,12)
axis image
for i =1:size(img,3)
    im = img(:,:,i);
    imwrite(im,[num2str(i),'.tif']);
end
%%  Ring size
% ring4
clf
mean(2*sqrt(allRingSize4/pi)*pixelSize)
std(2*sqrt(allRingSize4/pi)*pixelSize)
% nbins = [28:4:60]*pixelSize;
histogram(2*sqrt(allRingSize4/pi)*pixelSize,'FaceColor',[0, 0.9, 0.9],'facealpha',.5)
% ylim([0,350])
% xlim([15,50])
% yticks([0:50:400])
% xticks([15:5:50])
 saveas(gcf,'ring4Size','pdf')
%%
% ring5
clf
mean(2*sqrt(allRingSize5/pi)*pixelSize)
std(2*sqrt(allRingSize5/pi)*pixelSize)
nbins = [28:4:60]*pixelSize;
histogram(2*sqrt(allRingSize5/pi)*pixelSize,nbins,'FaceColor',[0.8500, 0.3250, 0.0980],'facealpha',.5)
ylim([0,350])
xlim([15,50])
yticks([0:50:400])
xticks([15:5:50])
 saveas(gcf,'ring5Size','pdf')
%% ring6
clf
mean(2*sqrt(allRingSize6/pi)*pixelSize)
std(2*sqrt(allRingSize6/pi)*pixelSize)
nbins = [30:4:70]*pixelSize;
histogram(2*sqrt(allRingSize6/pi)*pixelSize,nbins,'FaceColor',[0, 0.5, 0],'facealpha',.5)
ylim([0,350])
xlim([15,50])
yticks([0:50:400])
xticks([15:5:50])
% xlim([500,3000])
% yticks([0:50:150])
% xticks([500:500:3000])
 saveas(gcf,'ring6Size','pdf')
%% ring7
clf
mean(2*sqrt(allRingSize7/pi)*pixelSize)
std(2*sqrt(allRingSize7/pi)*pixelSize)
nbins = [35:3:70]*pixelSize;
histogram(2*sqrt(allRingSize7/pi)*pixelSize,nbins,'FaceColor','b','facealpha',.5)
ylim([0,350])
xlim([15,50])
yticks([0:50:400])
xticks([15:5:50])
% xlim([500,5000])
% yticks([0:50:200])
% xticks([500:500:3000])
saveas(gcf,'ring7Size','pdf')
%%
allRingSize = [allRingSize4;allRingSize5;allRingSize6;allRingSize7];
mean(2*sqrt(allRingSize/pi)*pixelSize)
std(2*sqrt(allRingSize/pi)*pixelSize)
clf
nbins = [25:3:80]*pixelSize;
histogram(2*sqrt(allRingSize/pi)*pixelSize,nbins,'FaceColor','b','facealpha',.5)
ylim([0,350])
xlim([15,50])
yticks([0:50:400])
xticks([15:5:50])
saveas(gcf,'ringSize','pdf')
%%  Ring angle
% ring4
figure
polarplot(deg2rad(allAngle4(:,1)),allAngle4(:,2),'o','MarkerSize',6,'LineWidth',0.5,'Color',[0, 0.9, 0.9]);
%  saveas(gcf,'ring5Anglelessthan8','pdf')
%
% ring5
hold on
polarplot(deg2rad(allAngle5(:,1)),allAngle5(:,2),'o','MarkerSize',6,'LineWidth',0.5,'Color',[0.8500, 0.3250, 0.0980]);
%  saveas(gcf,'ring5Anglelessthan8','pdf')
% ring6
%
hold on
polarplot(deg2rad(allAngle6(:,1)),allAngle6(:,2),'o','MarkerSize',6,'LineWidth',0.5,'Color',[0, 0.5, 0]);
%  saveas(gcf,'ring6Anglelessthan8','pdf')
% ring7
hold on
polarplot(deg2rad(allAngle7(:,1)),allAngle7(:,2),'o','MarkerSize',6,'LineWidth',0.5,'Color','b');
% saveas(gcf,'ring7Anglelessthan8','pdf')
saveas(gcf,'ringAngle','pdf')
%% number of rings 
tempNumber5 = [];
tempNodetype5 = [];
for i = 1:size(ring5,1)
    tempRingDots = ring5{i,1};
    if ~isempty(tempRingDots)
        tempNumber5 = [tempNumber5;ring5{i,6}];
    else
        tempNumber5 = [tempNumber5;0];
    end
        tempNodetype5 = [tempNodetype5;ne(i,2)];
end
%%
tempNumber6 = [];
tempNodetype6 = [];
for i = 1:size(ring6,1)
    tempRingDots = ring6{i,1};
    if ~isempty(tempRingDots)
        tempNumber6 = [tempNumber6;ring6{i,6}];
    else
        tempNumber6 = [tempNumber6;0];
    end
    tempNodetype6 = [tempNodetype6;ne(i,2)];
end
%%
tempNumber7 = [];
tempNodetype7 = [];
for i = 1:size(ring7,1)
    tempRingDots = ring7{i,1};
    if ~isempty(tempRingDots)
        tempNumber7 = [tempNumber7;ring7{i,6}];
    else
        tempNumber7 = [tempNumber7;0];
    end
        tempNodetype7 = [tempNodetype7;ne(i,2)];
%     end
end
%%
clear tempNumber
tempNumber = tempNumber5+tempNumber6+tempNumber7;
%%
% for i =1:length(tempNodetype5)
%     sum
    for j = 3:6
        numberRing(j-2) = sum(tempNumber(find(tempNodetype5 ==j)));
        numberNode(j-2) = length((find(tempNodetype5 ==j)));
    end
    plot(numberNode,numberRing)
% end
% n = hist3([tempNodetype5, tempNumber5],'Nbins',[4 4]);
% scatter(tempNodetype,tempNumber,'r.')
% hold on
% pcolor(n)
% colorbar
% scatter(tempNodetype,tempNumber,'o');
%%
figure
load cont
np = 8;
[lp5,lp6,lp7,nb1]=findloop(connect,node(np,1));
for i =1%size(lp6,1)
    lp = lp5(i,:);
   temp=[];
   for j=1:length(lp)-1
   
    temp=[temp;bran{findbran(lp(j),lp(j+1),connect)}];
   end
    temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];

    PlotScatter_datas(temp,30,'b')
    hold on

    PlotScatter_datas(lp',100,'r')
    hold on
end
hold on
PlotScatter_datas(node(np,1),200,'k')
hold on
tmpbran1 = node(np,1);
[x,y,z]=meshgrid(1:datas(1),1:datas(2),1:datas(3));
 [x0,y0,z0] = ind2sub(datas,tmpbran1);
 tempsphere = cont.*(((x-y0).^2+(y-x0).^2+(z-z0).^2)<=50^2);
%  PlotScatter_datas(tempsphere,10,[1,1,1]-0.3)
%  hold on
% PlotScatter_datas(trimskel,10,[1,1,1]-0.3,0)
% FigureFormat

%% Ring 5
clf
ring5 = ring{1};
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc5,1)
    j = loc5(k,1);
    i = loc5(k,2);
    tempRingDots = ring5{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
 hold on
end
% PlotScatter_datas(tempBran,10,[0.8500, 0.3250, 0.0980],0)

%     hold on

%     PlotScatter_datas(tempRing(:),30,'r',0)
%     hold on
    
PlotScatter_datas(tempNode(:),150,[0.8500, 0.3250, 0.0980],0)
%    hold on
%    PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
% FigureFormat
% saveas(gcf,'ring5lessthan8','epsc');
% saveas(gcf,'ring5lessthan8','pdf');
% saveas(gcf,'ring5lessthan8','png');
% Ring 6
% clf
hold on
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc6,1)
    j = loc6(k,1);
    i = loc6(k,2);
    tempRingDots = ring6{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];

end
% PlotScatter_datas(tempBran,10,[0, 0.5, 0],0)
%     hold on
% 
%     PlotScatter_datas(tempRing(:),30,'r',0)
%     hold on
    
PlotScatter_datas(tempNode(:),90,[0, 0.5, 0],0)
%    hold on

%    PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
% FigureFormat
% saveas(gcf,'ring6lessthan8','epsc');
% saveas(gcf,'ring6lessthan8','pdf');
% saveas(gcf,'ring6lessthan8','png');

% Ring 7
% clf
hold on
tempBran = [];
tempRing = [];
tempNode = [];
for k = 1:size(loc7,1)
    j = loc7(k,1);
    i = loc7(k,2);
    tempRingDots = ring7{j,1};
    lp = tempRingDots(i,:);
    temp=[];
    for m=1:length(lp)-1
        temp=[temp;bran{findbran(lp(m),lp(m+1),connect)}];
     end
     temp=[temp;bran{findbran(lp(1),lp(length(lp)),connect)}];
     tempBran = [tempBran;temp];
     tempRing = [tempRing;lp];
     
    tempNode = [tempNode;ne(j,1)];
end
% PlotScatter_datas(tempBran,10,'b',0)
% hold on 
% PlotScatter_datas(tempRing(:),30,'r',0)
hold on
PlotScatter_datas(tempNode(:),50,'b',0)
hold on
PlotScatter_datas(trimskel,1,[0.6,0.6,0.6],0)
FigureFormat
% saveas(gcf,'ringlessthan8','epsc');
% saveas(gcf,'ringlessthan8','pdf');
% saveas(gcf,'ringlessthan8','png');
%%
NumerCount = [4,5,6,7;length(allRingSize4),length(allRingSize5),length(allRingSize6),length(allRingSize7)];
bar(NumerCount(1,:),NumerCount(2,:),1)
saveas(gcf,'Count','pdf');


%% Finish ring plotting
fprintf('Ring plotting completed!\n')
open main_dataAnalysis