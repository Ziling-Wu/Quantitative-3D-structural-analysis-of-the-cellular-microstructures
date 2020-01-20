% =========================================================================
% Sub-Function inside the main function for correlation analysis
% =========================================================================
%% Correlation: branch orientation vs branch length analysis_center
clf
color1 = jet(30);
record = [];
nbins = linspace(0,60,10);
for i=1:9
    group=(nbins(i)<branlen).*(branlen<nbins(i+1));
    group=find(group);
    temp=[];
    if ~isempty(group)
        for j=1:length(group)    
            [theta,phi] = myangle(connect(group(j),1),connect(group(j),2),datas);
            temp(j,:)=real([theta,phi]);
        end
        if ~isempty(temp)
            record = [record;temp];
            p=polarplot(deg2rad(temp(:,1)),abs((temp(:,2))),'o','MarkerSize',6);
            p.Color = color1(i,:);
            hold on
        end
    end    
 
end
a=gca;
a.LineWidth=2;
a.FontSize=12;
set(gcf,'color','white')
cmap = colormap(color1) ;
cbh = colorbar ; %Create Colorbar
% saveas(gcf,'Center region branch orientation_without colorbar','epsc')
%  saveas(gcf,'Center region branch orientation_without colorbar','pdf')
%  saveas(gcf,'Center region branch orientation_without colorbar','png')
 


%% Correlation: branch orientation vs branch thickness analysis_center

figure
%
clf
cor = [];
nbins = linspace(300,500,12);% generates 12 points between 1 and 10;
for i=1:11
    group=(nbins(i)<branthickness).*(branthickness<nbins(i+1));
    group=find(group);
    temp=[];
    if ~isempty(group)
        for j=1:length(group)    
            cor = branthicknessid(group(j));
            [theta,phi] = myangle(connect(cor,1),connect(cor,2),datas);
            temp(j,:)=real([theta,phi]);
        end
        if ~isempty(temp)
            p=polarplot(deg2rad(temp(:,1)),abs((temp(:,2))),'o','MarkerSize',6);
            p.Color = color1(i,:);
            hold on
        end
    end    
 
end
% figure 
a=gca;
a.LineWidth=2;
a.FontSize=12;
set(gcf,'color','white')
cmap = colormap(color1) ;
cbh = colorbar ; %Create Colorbar
cbh.TickLabels = num2cell(linspace(1,10,11));
saveas(gcf,'Center region branch thickness-orientation','epsc')
 saveas(gcf,'Center region branch thickness-orientationr','pdf')
 saveas(gcf,'Center region branch thickness-orientation','png')

%% Finish correlation analysis
fprintf('Branch correlation completed! \n')
open 02_main_dataAnalysis