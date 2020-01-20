% =========================================================================
%
% Sub-Function inside the main function for inter branch angle analysis
%
% =========================================================================
%% interbranch angle analysis 
fprintf('Start calculating all interbranch angles.\n')
nc = node;
cc = connect;
bc = bran;
clear angle_c
for i = 1:size(nc,1)
    % Find the node index that is connected to the current node from the second column
    temp = cc(cc(:,1)==nc(i,1),2); 
    % Find the node index that is connected to the current node from the first column
    temp = [temp;cc(cc(:,2)==nc(i,1),1)];
    for j = 1:length(temp)
        % The angle between the i-th node and all nodes connected to this
        % node. Node is stored in degree.
        angle_c(i,j) = interangle(nc(i,1),temp(j),temp(mod(j,length(temp))+1),datas)*180/pi;
    end
end

%% 3-N node angle distribution
fprintf('Start analyzing interbranch angle distribution of all 3-N nodes...\n')
% all angle 
figure
clear temp hlc
edge = [20:10:180]-2.5;
% find interbranch angles of all 3-N nodes
angle3N = abs(angle_c((angle_c(:,4)==0)&(angle_c(:,3)~=0),1:3));
% mean interbranch angles
temp = mean(angle3N,2);
hlcm = histcounts(real(temp),edge);
% smallest angle;
temp = min(angle3N,[],2); 
hlcs = histcounts(real(temp),edge);
% middle angle 
temp = sort(angle3N,2);
temp = temp(:,2); 
hlcmi = histcounts(real(temp),edge);
% largest angle; 
temp = max(angle3N,[],2); 
hlcl = histcounts(real(temp),edge);
x = edge(1:end-1)+2.5;
plot(x,hlcm,x,hlcs,x,hlcmi,x,hlcl,'LineWidth',0.75);
legend('\gamma','\gamma_1','\gamma_2','\gamma_3')
xlabel('Interbranch angles (degrees)');ylabel('Counts')
set(gca,'FontSize',16);
set(0,'DefaultTextFontName','Ariel')
set(gcf,'color','white')
% saveas(gcf,'3-node interbranch angle','epsc')
% saveas(gcf,'3-node interbranch angle','png')
% saveas(gcf,'3-node interbranch angle','pdf')
meanAngle = mean(angle3N,2);
fprintf('Mean angle of all 3-N nodes is %f.\n', mean(angle3N(:))) 
fprintf('Standard variation of all 3-N nodes is %f.\n', std(meanAngle)) 

%% 4-N node angle distribution
fprintf('Start analyzing interbranch angle distribution of all 4-N nodes...\n')
figure
clear temp hlc hle
edge = [20:10:180]-5;
% find interbranch angles of all 4-N nodes
angle4N = abs(angle_c((angle_c(:,4)~=0)&(angle_c(:,5)==0),1:4));
% mean interbranch angles
temp = mean(angle4N,2);
hlcm = histcounts(temp,edge);
% largest angle; 
temp = max(angle4N,[],2); 
hlcl = histcounts(real(temp),edge);
% Smallest angle; 
temp = min(angle4N,[],2); 
hlcs = histcounts(real(temp),edge);
x = edge(1:end-1)+5;

plot(x,hlcm,x,hlcs,x,hlcl,'LineWidth',0.75);
legend('\gamma','\gamma_{min}','\gamma_{max}')
xlabel('Interbranch angles (degrees)');ylabel('Counts')
set(gcf,'color','white')
set(gca,'FontSize',7);
set(0,'DefaultTextFontName','Ariel')
xticks([20,60,100,140,180])
yticks([0:200:1400])
ylim([0 1400])
% saveas(gcf,'4-node interbranch angle','epsc')
% saveas(gcf,'4-node interbranch angle','png')
% saveas(gcf,'4-node interbranch angle','pdf')
%%
meanAngle = mean(angle4N,2);
fprintf('Mean angle of all 3-N nodes is %f.\n', mean(angle4N(:))) 
fprintf('Standard variation of all 3-N nodes is %f.\n', std(meanAngle)) 



%% the equal distance orientation
% It takes some time. 
tic
clear oric
clear plane
n3c = find(nc(:,2)==3);
clear temp
for i = 1:size(n3c,1)
    temp = cc(cc(:,1)==nc(n3c(i),1),2);
    temp = [temp;cc(cc(:,2)==nc(n3c(i)),1)];
    [oric(i,:),plane(i,:)] = ori3(nc(n3c(i),1),temp(1),temp(2),temp(3),datas);
end
toc
% load oric
figure
clear temp
temp(:,2) = atand(sqrt(oric(:,3).^2+oric(:,2).^2)./abs(oric(:,1)));% phi
% temp(:,2)=acosd(sqrt(oric(:,3).^2+oric(:,2).^2));% phi
 for i =1:size(oric,1)
    % temp(:,1)=atan(oric(:,2)./oric(:,3)); 
    theta= abs(atan(abs(oric(i,2))/abs(oric(i,3))))*180/pi;
    if oric(i,1)>0
        temp(i,2) = temp(i,2);
        y = oric(i,2);
        z = oric(i,3);
    else
        temp(i,2) = 180-temp(i,2);
        y = oric(i,2);
        z = oric(i,3);
    end
    if (y>0)&&(z>0)
        theta = 360-theta;
    elseif (y>0)&&(z<0)
        theta = 180+theta;
    elseif (y<0)&&(z<0)
        theta = 180-theta;
    else
        theta = theta;
    end
    temp(i,1) = theta;
 end
p=polarplot(deg2rad(temp(:,1)),temp(:,2),'o','MarkerSize',6,'LineWidth',0.5);
rticks([0:30:180])
 set(gcf,'color','white')
% saveas(gcf,'Center node orientation','epsc')
% saveas(gcf,'Center node orientation','pdf')
% saveas(gcf,'Center node orientation','png')
%%
figure
nbins = -0.009:0.05:1;
hlc = histofrequency(abs(cos(deg2rad(plane))),nbins);
plot(hlc(:,1),hlc(:,2),'LineWidth',1)
x=hlc(:,1);
% bar(x,hlc(:,2))
colormap jet
set(gcf,'color','white')
xlabel('Planarity angles');ylabel('Frequency')
xticks([0:0.2:1])
% yticks([0,0.05,0.1,0.15,0.2])
xlim([0,1])
% histogram(plane,nbins)
ylim([0,0.5])
% yticks([0:0.1:0.4])
set(gcf,'color','white')
%  saveas(gcf,'Planarity','epsc')
% saveas(gcf,'Planarity','pdf')
% saveas(gcf,'Planarity','png')
%% Finish interbranch angle analysis
fprintf('Interbranch angle analysis completed!\n')
open 02_main_dataAnalysis