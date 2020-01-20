% =========================================================================
% Sub-Function inside the main function for branch length and distance 
% analysis
% =========================================================================

%% Inner branches detection 

% Branch length and branch thickness are not realiable at the boundary.
% Therefore, in the following analysis, we will get rid of boundary region.


innerbran = cell(1);
innerconnect = [];
index = 1;
for i=1:size(bran,2)
    bic(i) = isboundary(bran{i},boundaryLimit,datas); %if 1, branch is at the boundary.
    if ~bic(i) % only left inner btranches
        innerbran{index} = bran{i};
      	innerconnect = [innerconnect;connect(i,:)];
      	index = index+1;
    end
end  
clear bran
clear connect
connect = innerconnect;
bran = innerbran;
%% delete repeated branch
% Calculate the first round bran length: branlen, and branch distance: brandis
% to delete repeated branches which come from structure defects (a small hole 
% inside the branch). It doesn't matter if your structure doesn't exist
% such defects to run this section.
bran = branch_order(bran,connect,datas);
[branlen,brandis] = branch_length(bran,connect,datas);
ratio = branlen./brandis;
[bran,connect] = DeleteRepeatedBran(connect,bran,ratio);


%% Calcualte again: branch length: branlen, and branch distance: brandis
[branlen,brandis] = branch_length(bran,connect,datas);
branlen = branlen*pixelSize;
brandis = brandis*pixelSize;
ratio = branlen./brandis;
%% Plot: the distance and length distribuiton
clf
hdc= histofrequency(brandis,0:5:60);
hlc= histofrequency(branlen,0:5:60);
plot(hdc(:,1),hdc(:,2),hlc(:,1),hlc(:,2));
legend('l_{ij}','l_{o,ij}')
xlabel('Branch length (\mum)');ylabel('Frequency')
axis square
% xticks([0 20 40 60 80 100])
% xlim([0,60])% adjust this start number and end number depending on your limit
% ylim([0,0.35])% adjust this start number and end number depending on your limit
set(gcf,'color','white')
set(gca,'fontsize', 16);

% Uncomment the following code if you would like to save this image
% saveas(gcf,'branch distance-length comparsion','epsc')
% saveas(gcf,'branch distance-length comparsion','pdf')
% saveas(gcf,'branch distance-length comparsion','png')
%% Plot: ratio
ratio = branlen./brandis;
hratio= histofrequency(ratio,0.95:0.03:max(ratio));

plot(hratio(:,1),hratio(:,2),'LineWidth',0.75)
xlim([0.9,2])% adjust this start number and end number depending on your limit
% ylim([0,0.15])% adjust this start number and end number depending on your limit
xlabel('Branch length/branch distance');ylabel('Frequency')
axis square
set(gcf,'color','white')

% Uncomment the following code if you would like to save this image
saveas(gcf,'branch length distance ratio','epsc')
saveas(gcf,'branch length distance ratio','pdf')
saveas(gcf,'branch length distance ratio','png')

%% plot the branches based on ratio
figure
% seperate ratio [1-1.5] into 30 ranges 
rangeNum = 30;
rangeStep = 0.0167;
color = jet(rangeNum); % colormap for ratio plot
cor = [];
bran_dotsize = 5; % dot size of branch points 

node_dotsize = 10; % dot size of node points 
node_dotcolor = 'r';% dot color of node points

for i=1:rangeNum
    group = ((1+(i-1)*rangeStep)<ratio).*(ratio<(1+i*rangeStep));
    group = find(group);
    temp = [];
    if ~isempty(group)
        for j = 1:size(group,1)
            temp = [temp;bran{group(j)}];
            cor = [cor;group(j)];
        end

        if ~isempty(temp)
            bran_dotcolor = color(i,:);% dot color of branch points 
            PlotScatter_datas(temp,bran_dotsize,bran_dotcolor,datas)
            hold on
        end
    end
end
colormap(color) ;
cbh = colorbar ; %Create Colorbar
% set(cbh,'XTickLabel',{'0','10','20','30','40','50','60'})
cbh.TickLabels = num2cell(linspace(1,1.5,11));
PlotScatter_datas(connect(cor(:),1),node_dotsize,node_dotcolor,datas)
hold on
PlotScatter_datas(connect(cor(:),2),node_dotsize,node_dotcolor,datas)
AZ = 120; % azimuth or horizontal rotation  (in degrees).
EL = 20; % vertical elevation (in degrees).
FigureFormat(AZ,EL)
saveas(gcf,'ratio length_center','epsc');
saveas(gcf,'ratio length_center','pdf');
saveas(gcf,'ratio length_center','png');

%%  plot the branches based on the length
fprintf('Show branch length range: [%d, %d] \n',min(branlen),max(branlen))
%% plot
figure
% seperate branlen [0,80] into 30 ranges 
rangeNum = 30;
rangeStep = 4000/30;
color1 = jet(rangeNum); % colormap for length plot
cor = [];
AZ = 120;
EL = 20;
for i = 1:rangeNum
    group = ((i-1)*rangeStep<branlen).*(branlen<i*rangeStep);
    group = find(group);
    temp = [];
    if ~isempty(group)
        for j = 1:size(group,1)
            temp = [temp;bran{group(j)}];
            cor = [cor;group(j)];
        end

        if ~isempty(temp)
            bran_dotcolor = color1(i,:);
            PlotScatter_datas(temp,bran_dotsize,color1(i,:),datas)
            hold on
        end
    end
end

PlotScatter_datas(connect(cor(:),1),10,'r',datas)
hold on
PlotScatter_datas(connect(cor(:),2),10,'r',datas)
cmap = colormap(color1) ;
cbh = colorbar ; %Create Colorbar
% set(cbh,'XTickLabel',{'0','100','20','30','40','50','10000'})
% cbh.TickLabels = num2cell(0:5:10000);
     
FigureFormat(AZ,EL)
saveas(gcf,'branch length_center','epsc');
saveas(gcf,'branch length_center','pdf');
saveas(gcf,'branch length_center','png');
%% Plot shorter branches
figure
cor = [];
for i=1:7 % plot shorter branches
    group=((i-1)*2<branlen).*(branlen<i*2);
    group=find(group);
    temp=[];
    if ~isempty(group)
        for j=1:length(group)
            temp=[temp;bran{group(j)}];
            cor = [cor;group(j)];
        end  
        if ~isempty(temp)
            bran_dotcolor = color1(i,:);
            PlotScatter_datas(temp,bran_dotsize,color1(i,:),datas)
            hold on
        end
    end
end

PlotScatter_datas(connect(cor(:),1),10,'r',datas)
hold on
PlotScatter_datas(connect(cor(:),2),10,'r',datas)
FigureFormat(AZ,EL)
axis([1 308 1 386 1 386])
% saveas(gcf,'branch length_center_short_branches','epsc');
% saveas(gcf,'branch length_center_short_branches','pdf');
% saveas(gcf,'branch length_center_short_branches','png');
%% Plot longer branches
figure
cor = [];
for i = 20:30 % plot longder branches by uncommenting this line
    group=((i-1)*2<branlen).*(branlen<i*2);
    group=find(group);
    temp=[];
    if ~isempty(group)
        for j=1:length(group)
            temp=[temp;bran{group(j)}];
            cor = [cor;group(j)];
        end  
        if ~isempty(temp)
            bran_dotcolor = color1(i,:);
            PlotScatter_datas(temp,bran_dotsize,color1(i,:),datas)
            hold on
        end
    end
end

PlotScatter_datas(connect(cor(:),1),10,'r',datas)
hold on
PlotScatter_datas(connect(cor(:),2),10,'r',datas)
FigureFormat(AZ,EL)
axis([1 308 1 386 1 386])
% saveas(gcf,'branch length_center_long_branches','epsc');
% saveas(gcf,'branch length_center_long_branches','pdf');
% saveas(gcf,'branch length_center_long_branches','png');
%% 
fprintf('Branch length analysis completed!\n')
open 02_main_dataAnalysis