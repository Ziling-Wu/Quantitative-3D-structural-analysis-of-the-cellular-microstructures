% =========================================================================
%  Title:  Quantitative-3D-structural-analysis-of-the-cellular-microstructures
%  Author: Ting Yang, Ziling Wu, Hongshun Chen, Yunhui Zhu, and Ling Li
%  Date:   9 Jan 2020
%  Here we provide comprehensive quantitative description and analysis of the 
%  natural cellular materials in 3D. In the first part
%  01_main_dataprocessing.m, network registration is performed based on
%  binarized 3D volume; In the second part 02_main_dataAnalysis.m, feature
%  extraction and data visulization are performed based on the registered
%  network. Enjoy this structural analysis journey!
% ==========================================
% clean all variances and add paths
clearvars
clc
addpath(genpath(pwd))
%% Section 1: load all required data for analysis
fprintf('Start loading all required data for analysis ... \n') 
folder = '.\Result\processData_mat\';
load([folder,'orig.mat']');% load binary volume
load([folder,'trimskel.mat']) % load skeleton volume
load([folder,'node_final.mat']) % load registered nodes
load([folder,'bran_final.mat']) % load registered branches
load([folder,'connect_final.mat']) % load registered connections
datas = size(orig); % volume size
pixelSize = 0.65;% resolution is 0.65 um/pixel
fprintf('Loading completed!\n') 
% display volume size
fprintf('The size of representative volume is [%i, %i, %i].\n', datas)
%% Section 2: Data analysis of node, branch properties

% Analysis: Node, branch length, branch thickness, branch orientation,ring, 
% chain and FFT of node
fprintf('Start node and branch analysis ... \n') 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%        Node            %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter 1: node type
fprintf('Start node type analysis ... \n')
fprintf('Open code for node type analysis ... \n')
close all;% close all figures
open main_node.m

%% Branch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%        Branch          %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Branch length and distance

fprintf('Start branch length analysis ... \n')
fprintf('Open code for branch length analysis ... \n')
open main_length.m 

%% Branch thickness and profile
% branch thickness and profile analysis should based on previous branch
% length and distance analysis. Make sure you run the last section before
% this one. 
fprintf('Start branch thickness analysis ... \n')
fprintf('Open code for branch thickness analysis ... \n')
open main_thickness.m 

%% Branch orientation distribution

close all
fprintf('Start branch orientation analysis ... \n')
fprintf('Open code for branch orientation analysis ... \n')
open main_branchOrientation.m 

%% Interbranch angles
close all;
fprintf('Start interbranch analysis ... \n')
fprintf('Open code for interbranch analysis ... \n')
open main_interBranchAngle.m 
%% Correlation
close all;
fprintf('Start interbranch analysis ... \n')
fprintf('Open code for interbranch analysis ... \n')
open main_correlation.m 
%% Chain
close all;% close all figures
fprintf('Start chain analysis ... \n')
open main_chain.m
%% Ring
close all;% close all figures
fprintf('Start ring analysis ... \n') 
fprintf('Open code for ring analysis ... \n')
open main_ring.m

%% FFT
fprintf('Start node distribution analysis ... \n')
fprintf('Open code for node distribution analysis based on Fourier transform... \n')
open main_fft.m
%% Plot based on node type
% set color for these four nodetypes
colorMap = [1,0.6,0.1; % 3-N
            1,1,0;     % 4-N
            1,0,1;     % 5-N
            0,0,1];    % 6-N
bran_dotsize = 1.5; % dot size of branch points 
bran_dotcolor = [0.5,0.5,0.5]; % dot color of branch points
node_dotsize = 25; % dot size of node points 

for i=1:4
    node_dotcolor = colorMap(i,:);% dot color of node points
    PlotScatter_datas(node(node(:,2)==i+2,1),node_dotsize,node_dotcolor,datas)
    hold on
end
temp = [];
for i = 1:size(bran,2)
    temp = [temp;bran{i}];
end
hold on
PlotScatter_datas(temp,bran_dotsize,bran_dotcolor,datas)
FigureFormat
colormap spring(4)
%colorbar 
% saveas(gcf,'nodetype_center_thinner','epsc');
% saveas(gcf,'nodetype_center_thinner','pdf');
% saveas(gcf,'nodetype_center_thinner','png');
%% plot the branches based on different branch: this will take some time
figure
for i = 1:size(bran,2) 
    temp = bran{i};
    bran_dotcolor = [1-i/size(bran,2),i/size(bran,2),1-i/size(bran,2)];
    PlotScatter_datas(temp,bran_dotsize,bran_dotcolor,datas)
    hold on 
end

PlotScatter_datas(connect(:,1),node_dotsize,node_dotcolor,datas)
hold on
PlotScatter_datas(connect(:,2),node_dotsize,node_dotcolor,datas)
axis off
colormap jet
FigureFormat(AZ,EL)