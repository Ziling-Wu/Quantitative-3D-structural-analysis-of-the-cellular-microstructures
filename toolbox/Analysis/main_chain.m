% =========================================================================
% Sub-Function inside the main function for chain analysis
% =========================================================================
% phi is the angle rotated from x direction;
phi = branOrien(:,2);
%% Chain detection
node = unique(connect);
% startnode
[x,y,z] =  ind2sub(datas,node(:,1));
startnode = [];
for i = 1:length(x)
    if (x(i)<60)&&(x(i)>10)
        startnode = [startnode;node(i,1)];
    end
end
%
allchain = cell(length(startnode),1);
for i = 1:size(startnode,1)
    chainnode = [];
    chainnode = chain(startnode(i),connect,chainnode,phi,datas);
    allchain{i} = chainnode;
end
%  cut
for j = 1:size(allchain,1)
    chainnode = allchain{j,1};
    loc = find(chainnode==0);
    loc = [0;loc];
    longline = cell(length(loc)-1,1);
    for i = 1: length(loc)-1
        longline{i} = chainnode(loc(i)+1:loc(i+1)-1);
    end
    allchain{j,2} = longline;
end
% stitich
for j = 1:size(allchain,1)
    longline = allchain{j,2};
    for i = 2:length(longline)
        firstline = longline{i-1};
        temp = longline{i};
        cut = find(firstline == temp(1));
        stitch = [firstline(1:cut);temp(2:end)];
        longline{i} = stitch;
    end
    allchain{j,2} = longline;
end
% longest chain
for j = 1:size(allchain,1)
    longline = allchain{j,2};
    len = [];
    for i = 1:size(longline,1)
        len(i) = length(longline{i});
    end
    loc_line = find(len == max(len));
    len_line = max(len);
    allchain{j,3} = loc_line;
    allchain{j,4} = len_line;
end
%% Find long chain with more than 'longChainLim' branches
longChainLim = 4; % threshold to select long chains
len_line = [];
for i = 1:size(allchain,1)
    len_line = [len_line,allchain{i,4}];
end
loc_line = find(len_line >=longChainLim);
%% Plot: chains
clf
% tmpbran = [];
% for i =1:length(bran)
%     tmpbran = [tmpbran;bran{i}];
% end
PlotScatter_datas(trimskel,5,[1,1,1]-0.3,datas);
hold on 
tmpbran = [];
for k = 1:length(loc_line)
    branNumber = [];
    loc_chain = allchain{loc_line(k),3};
    temp = allchain{loc_line(k),2};
    for i = 1:length(loc_chain)
        chaindots = temp{loc_chain(i)};
        for j = 1:size(chaindots,1)-1
            c = findbran(chaindots(j),chaindots(j+1),connect);
            t = bran{c};
            tmpbran = [tmpbran;t];
        end
        index = index+1;
        PlotScatter_datas(temp{loc_chain(i)},50,'r',datas)
        hold on
    end
end
PlotScatter_datas(tmpbran,10,'b',datas)
axis on
FigureFormat(120,20)
% saveas(gcf,'chain','epsc');
% saveas(gcf,'chain','pdf');
% saveas(gcf,'chain','png');
%% Chain parameters: chain direction and offanle
clear offangle
clear chaindirec
chainleng = zeros(length(loc_line),1);
ind = 1;
chaindirec = cell(1);
for k = 1:length(loc_line)
    loc_chain = allchain{loc_line(k),3};
    temp = allchain{loc_line(k),2};
    len = allchain{loc_line(k),4};
    for i = 1:length(loc_chain)
        chaindots = temp{loc_chain(i)};
        for j = 1:size(chaindots,1)-1
            c = findbran(chaindots(j),chaindots(j+1),connect);
            t = bran{c};
            dis = 0;
            for kk =1:length(t)-1
                dis = vecdist(t(kk),t(kk+1),datas)+dis;
            end
            startDis = [vecdist(chaindots(j),t(1),datas),vecdist(chaindots(j),t(end),datas)];
            EndDis = [vecdist(chaindots(j+1),t(1),datas),vecdist(chaindots(j+1),t(end),datas)];
% [xs, ~] = sort(startDis);
            sDis = min(startDis);
            eDis = min(EndDis);
            branlen_cur = dis+sDis+eDis;
            [cx1,cy1,cz1] = ind2sub(datas,t(1));
            [cx2,cy2,cz2] = ind2sub(datas,t(end));
            chainleng(ind,j) = branlen_cur;
            cur_dir =  [cx2-cx1,cy2-cy1,cz2-cz1];
            chaindirec{ind,j} = cur_dir./norm(cur_dir);
            offangle(ind,j) = phi(c);
        end
    end
    ind = ind+1;
end

stas = nonzeros(chainleng*pixelSize);

fprintf(['There are %d chains detected. The mean chain length is %4f and ',... 
        'standard variation is %4f \n'],length(chainleng),mean(stas),std(stas)) 
%% Chain length distribution
fprintf('Chain length distribution\n')
figure
histogram(stas);
xlim([1600,2600])
ylim([0,50])
yticks([0:10:50])
% yticks([0:20:160])
set(gcf,'color','white')
saveas(gcf,'chainleng','epsc');
saveas(gcf,'chainleng','pdf');
saveas(gcf,'chainleng','png');
%% Calculate chain direction
chainAngle = zeros(length(loc_line),1);
ind = 1;
for i = 1:size(chaindirec,1)
    for j = 1:size(chaindirec,2)-1
        x1 = cell2mat(chaindirec(i,j));
        x2 = cell2mat(chaindirec(i,j+1));
        if ~isempty(x2)
            temp = acosd(dot(x1,x2)/(norm(x1)*norm(x2)));
            if temp >= 90
                chainAngle(i,j) = temp;
            else
                chainAngle(i,j) = 180-temp;
            end
        else
            continue
        end
    end
end
%% Chain direction distribution 
figure
nbins = 173:0.5:180;
stas = nonzeros(chainAngle);
histogram(stas,nbins)
xlim([170,180])
ylim([0,40])
set(gcf,'color','white')
% xticks([170:0.5:180])
% yticks([0:50:300])
saveas(gcf,'InterchainAngle','epsc');
saveas(gcf,'InterchainAngle','pdf');
saveas(gcf,'InterchainAngle','png');
fprintf(['The mean interbranch angle in chains is %4f, and the standard'... 
    ' variation is %4f \n'],mean(stas),std(stas))
%% off-L direction direction
figure
nbins = 0:0.5:10;
histogram(offangle(:),nbins)
ylim([0,60])
set(gcf,'color','white')
% xticks([0:10:50])
% yticks([0:50:300])
saveas(gcf,'offangle','epsc');
saveas(gcf,'offangle','pdf');
saveas(gcf,'offangle','png');
fprintf(['The mean off angle  along one particle direction in chains is %4f, '...
    'and the standard variation is %4f \n'],mean(offangle(:)),std(offangle(:)))

%% branch thickness
tic
% load cont
chainThick = cell(length(loc_line),1);
index = 1;
for k = 1:length(loc_line)
    loc_chain = allchain{loc_line(k),3};
    tempCell = allchain{loc_line(k),2};
    for i = 1:length(loc_chain)
        chaindots = tempCell{loc_chain(i)};
        for j = 1:size(chaindots,1)-1
            c = findbran(chaindots(j),chaindots(j+1),connect);
            branID = find(branthicknessid == c);
            if ~isempty(branID)
                chainThick{index,j} = branthickness(branID);
            end
%             tmpbran = bran{c};
%             % find general thickness
%             [x0,y0,z0] = ind2sub(datas,tmpbran(1));
%             w = 1;temp = 0;
%             while temp <5
%                 w = w+1;
%                 region = cont(x0-w:x0+w,y0-w:y0+w,z0-w:z0+w);
%                 temp = length(find(region == 1));
%             end  
%             % find thickness
%             [x,y,z]=meshgrid(1:datas(1),1:datas(2),1:datas(3));
%             [x1,y1,z1] = ind2sub(datas,tmpbran(1));
%             [x2,y2,z2] = ind2sub(datas,tmpbran(end));
%             r1 = [x2-x1,y2-y1,z2-z1];
%             l = length(tmpbran);
%             if l<5
%                 continue
%             else
%                 ind = 1;
%                 thick = [];
%                 for jj = 2:1:length(tmpbran)-1
%                     [x0,y0,z0] = ind2sub(datas,tmpbran(jj));
%                     tempsphere = cont.*(((x-y0).^2+(y-x0).^2+(z-z0).^2)<=20^2);
%                     cor = find(tempsphere);
%                     if isempty(cor)
%                         continue
%                     else
%                         [xr,yr,zr] = ind2sub(datas,cor);
%                         c = [xr-x0,yr-y0,zr-z0];
%                         clear angle1
%                         angle1 = abs(acos(c*r1'/norm(r1)./vecnorm(c,2,2))*180/pi)-90;
%                         loc1 = find(abs(angle1)<2);% == min(abs(angle)));
%                         loc = loc1;
%                         if isempty(loc)
%                             fprintf('here!\n');
%                             continue;
%                         end
%                         dis = sqrt((x0-xr(loc)).^2+(y0-yr(loc)).^2+(z0-zr(loc)).^2);
%                         if sum(dis<w+11) == 0
%                             thick(ind) = mean(dis);
%                         else
%                             thick(ind) = mean(dis((dis<w+11)));
%                         end
%                         ind = ind+1;
%                     end
%                 end
                
%             end
        end
    end
    index = index+1;
end
toc
%%
save('chainThick.mat','chainThick')
%%
chainMinthickness = zeros(size(chainThick));
for i = 1:size(chainThick,1)
    for j = 1:size(chainThick,2)
        tempRow = chainThick{i,j};
        if ~isempty(tempRow)
            chainMinthickness(i,j) = min(tempRow)*pixelSize;
        end
    end
end
figure
allChainthickness = chainMinthickness(chainMinthickness~=0);
mean(allChainthickness)
std(allChainthickness)
% nbins = [1.5:1:10.5];
histogram(allChainthickness);
xlim([350,450])
ylim([0,70])
% xticks([3:2:10])
% yticks([0:20:150])
saveas(gcf,'chainthick','epsc');
saveas(gcf,'chainthick','pdf');
saveas(gcf,'chainthick','png');
%%

allChainlength = chainleng(chainMinthickness~=0)*0.65;
mean(allChainlength)
std(allChainlength)
scatter(allChainlength,allChainthickness)
xlim([0,40])
% ylim([0,280])
xticks([0:10:50])
yticks([0:2:10])
xlabel('Branch length')
ylabel('Branch thickness')
% saveas(gcf,'chainThickLength','epsc');
% saveas(gcf,'chainThickLength','pdf');
% saveas(gcf,'chainThickLength','png');
%%
save('allChainlength.mat','allChainlength');
save('allChainthickness.mat','allChainthickness');
save('chainThick.mat','chainThick');
%% Finish chain analysis
fprintf('Chain analysis completed! \n')
open 02_main_dataAnalysis