% =========================================================================
% Sub-Function inside the main function for branch thickness and profile 
% analysis
% =========================================================================
%% 
c3 = connect;
b3 = bran;
cont = edge3(orig,'approxcanny',0.6);% branch contour
%% Calculate branch thickness roughly
fprintf('Start rough branch thickness calculation ... \n')
index =1;
clear thickness
for i = 1: length(bran)
    tmpbran = bran{i};
    [x0,y0,z0] = ind2sub(datas,tmpbran(1));
    width = 15;
    w = 1;
    temp = 0;
    while temp <5
        w = w+1;
        region = cont(x0-w:x0+w,y0-w:y0+w,z0-w:z0+w);
        temp = length(find(region == 1));
    end
    newbran_thickness{index} = i;
    newconnect_thickness(index,:) = connect(i,:);
    thickness(index,1) = tmpbran(1);
    thickness(index,2) = w;%pi*radius^2;
    index = index+1;
end
fprintf('Rough branch thickness calculation completed! \n')
%% Calculate branch thickness by sphere fitting with previous intital guess
fprintf('Start calculating all branch thickness ... \n')
fprintf('This step will take some time. Please grab a cup of coffee.  \n')
tic
[x,y,z] = meshgrid(1:datas(2),1:datas(1),1:datas(3));
allthickness = cell(1);
index = 1;
for i = 1:size(c3,1)
    tmpbran = b3{i};
    [x1,y1,z1] = ind2sub(datas,tmpbran(1));
    [x2,y2,z2] = ind2sub(datas,tmpbran(end));
    r1 = [x2-x1,y2-y1,z2-z1];
    width = 10;
    len = length(tmpbran);
    if len<10 % skip too short branches
        continue
    else
%         if (ratio(i)>=1)&&(ratio(i)<=1.4)%not too curve branch
        [xx,yy,zz]= ind2sub(datas,tmpbran);
        ind = 1;
        thick=[];
        for j = 2:1:length(tmpbran)-1
            [x0,y0,z0] = ind2sub(datas,tmpbran(j));
            tempsphere = cont.*(((x-y0).^2+(y-x0).^2+(z-z0).^2)<=20^2);
            cor = find(tempsphere);
            if isempty(cor) % sphere not touch the branches
                continue
            else
                [xr,yr,zr] = ind2sub(datas,cor);
                c = [xr-x0,yr-y0,zr-z0];
                clear angle1
                angle1 = abs(acos(c*r1'/norm(r1)./vecnorm(c,2,2))*180/pi)-90;
%               angle2 = abs(acos(c*r2'/norm(r2)./vecnorm(c,2,2))*180/pi)-90;
                loc1 = find(abs(angle1)<2);% == min(abs(angle)));
                loc = loc1;
%               loc2 = find(abs(angle2)<0.1);% == min(abs(angle)));
%               loc = [loc1;loc2];
                if isempty(loc)% do I need to skip this point?Yes
%                   loc = find(abs(angle)== min(abs(angle)));
%                   fprintf('here!\n');
                	continue;
                end
                dis = sqrt((x0-xr(loc)).^2+(y0-yr(loc)).^2+(z0-zr(loc)).^2);
                thick(ind,1) = tmpbran(j);
                if sum(dis<thickness(i,2)+11) == 0
                    thick(ind,2) = mean(dis);
                else
                    thick(ind,2) = mean(dis((dis<thickness(i,2)+11)));
                end
                thick(ind,3) = j;
                thick(ind,4)=i;
                ind = ind+1;
            end
        end
        if ~isempty(thick)
            allthickness{index} = thick;
            index = index+1;
        end
    end
end
time = toc;
fprintf('All branch thickness calculation completed within %f seconds!\n', time)
%% Save all thickness info
save('allthickness.mat','allthickness')
%% bran thickness
fprintf('Central branch thickess info \n')
clear branthickness
clear branthicknessid
for i = 1:length(allthickness)
    thick = allthickness{i}; 
    branthicknessid(i,1) = thick(1,4);
    branthickness(i,1) = min(thick(:,2))*pixelSize;
end
fprintf('Central branch thickness range: [%5d, %5d] \n',min(branthickness),max(branthickness))
%% Plot: the branches based on the central thickness
color1=jet(11); % set stable colormap
%% Plot
figure
cor = [];
bran_dotsize = 5; % dot size of branch points 
node_dotsize = 10; % dot size of node points 
node_dotcolor = 'r';% dot color of node points
nbins = linspace(300,500,12);% generates 12 points between 1 and 10;
for i = 1:length(nbins)-1
    group = (nbins(i)<branthickness).*(branthickness<nbins(i+1));
    group = find(group);
    temp = [];
    if ~isempty(group)
        for j = 1:size(group,1)
            temp = [temp;bran{branthicknessid(group(j))}];
            cor = [cor;branthicknessid(group(j))];
        end
        if ~isempty(temp)
            bran_dotcolor = color(i,:);% dot color of branch points 
            PlotScatter_datas(temp,bran_dotsize,bran_dotcolor,datas)
            hold on
        end
    end
end

PlotScatter_datas(connect(cor(:),1),node_dotsize,node_dotcolor,datas)
hold on
PlotScatter_datas(connect(cor(:),2),node_dotsize,node_dotcolor,datas)
cmap = colormap(color1) ;
cbh = colorbar ; %Create Colorbar
% cbh.TickLabels = num2cell(linspace(1,10,6));

FigureFormat
axis on
% xlim([1 datas(1)])
% ylim([1 datas(2)])
% zlim([1 datas(3)])
saveas(gcf,'branch thickness_thick','epsc');
saveas(gcf,'branch thickness_thick','pdf');
saveas(gcf,'branch thickness_thick','png');

%% Branch thickness histogram
figure
nbins = 300:50:500;
hlc= histofrequency(branthickness,nbins);
x = hlc(:,1)-0.5;
bar(x,hlc(:,2))
colormap jet
set(gcf,'color','white')
xlabel('Branch thickness');ylabel('Frequency')
ylim([0,0.9])% adjust this start number and end number depending on your limit
% xlim([0,10])% adjust this start number and end number depending on your limit
saveas(gcf,'Histogram thickness','epsc')
 saveas(gcf,'Histogram thickness','pdf')
 saveas(gcf,'Histogram thickness','png')

%% 
fprintf('Finish branch thickness analysis! \n')
open 02_main_dataAnalysis