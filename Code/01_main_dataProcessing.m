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
% =========================================================================
% clean all variances and add paths
clearvars
clc
addpath(genpath(pwd))
%% Section 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  load binary images    %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inidicate image start number, eg. the first image in folder '20190302binaru_final'
% is '0000.tif' and the last image is '0307.tif', the startPage is 0 and
% the endPage is 307, the style is '.tif', imageName is the figure name
% before zeros, here is ''. The sigDigits is the Significant digits after your
% imageName, here should be 4. 
fprintf('Start loading binarized images...\n') 
tic
startPage = 0; % image start number
endPage = 307; %  image end name
style = '.tif'; %  image format
imageName = '';% input your figure name here without zeros
sigDigits = 4; % Significant digits after your figure name
folder = './Binary/'; % folder of your images
% iteratively read in binary images
clear orig
for slice = startPage:endPage
    im = double(imread([folder,imageName,num2str(slice,['%0',num2str(sigDigits),'d']),...
        style]));
    orig(:,:,slice-startPage+1) = im;
end
orig = (orig-min(orig(:)))./(max(orig(:))-min(orig(:)));% rescale the image 
                                                        % to [0,1]
time = toc;
datas = size(orig); % volume size
fprintf('Binarized images are loaded within %f seconds!\n', time) 
% display volume size
fprintf('The size of representative volume is [%i, %i, %i].\n', datas) 
%% Plot to make sure images are loaded correctly
clf
subplot(131); imagesc(orig(:,:,1));axis image;title('First image');colorbar
subplot(132); imagesc(orig(:,:,floor(size(orig,3)/2)));axis image;title('Middle image');colorbar
subplot(133); imagesc(orig(:,:,end));axis image;title('Last image');colorbar
%%  Section 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    Skeletonization     %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start skeletonizing...\n') 
tic
skel_c = Skeleton3D(orig);
time = toc;
fprintf('Sketonization is done within %f seconds!\n', time) 
%% Show the skeltonized volume
clf
fprintf('Display skeletonized volume.\n') 
% You could indicate plot parameters in the function 'PlotScatter_datas'
% the first variable is the skeletonized volunme: skel;
% the second variable is the size of plotted dots: dotsize, such as 1,10;
% the third variable is the color of the plotted dots: dotcolor, such as 
% 'r', 'g', or indicate rgb value like [0.3, 0.2, 0.5].
dotsize = 1;
dotcolor = 'g';
% indicate view angle: AZ is the azimuth or horizontal
% rotation and EL is the vertical elevation (both in degrees).
% For more info, please type in 'help view' in the command window. 
AZ = 120;
EL = 20;
PlotScatter_datas(skel_c,dotsize,dotcolor);axis on;
FigureFormat(AZ,EL)
xlabel('x')
ylabel('y')
zlabel('z')
%% Save the skeletonized volume
clf
fprintf('Start saving skeletonized volume in the folder.\n')
% indicate folder name to save
folder = '.\Result\skeleton\';
if ~exist(folder, 'dir')
    fprintf('Generating new folder...\n')
    mkdir(folder)
else
    fprintf('Folder already existed.\n')
end
% start saving the skeletonized volume
%  indicate image format to save
style = '.tif';
sliceNumber = startPage:endPage;
for slice = 1:size(skel_c,3)
    im = skel_c(:,:,slice);
    imwrite(im,[folder,num2str(sliceNumber(slice),['%0',num2str(sigDigits),'d']),...
        style]);
end
fprintf('Saving completed!\n')
%%  Section 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    Network cleaning    %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step 1: Trimming branches
fprintf('Start network cleaning...\n')
fprintf('First step: trimming the branches.\n')
tic
trimnode = node_identification(skel_c);
trimskel = skel_c;
tic
criteria = 2;
criteria_new = 1;
while criteria ~= criteria_new
    fprintf('1\n')
    criteria = size(trimnode,1);
    trimskel = branch_trim(trimnode, trimskel);
%     trimskel = Skeleton3D(trimskel);
    trimnode = node_identification(trimskel);
    criteria_new = size(trimnode,1);
end
toc
time = toc;
fprintf('Branch trimming is completed within %f seconds!\n', time) 
%% Indentify branch, node and connections
% bran: identified branches saved in 'cell' format;
% node: identified nodes, the first column is node position and second
%       column is node type;
% connect: connected nodes for each branch;
tic
[bran,connect, node] = branch_sort2(trimskel,trimnode,datas);
time = toc;
fprintf('Branches and nodes are registered within %f seconds!\n', time) 
%% Save the trimmed skeleton volume
fprintf('Start saving trimmed skeletonized volume in the folder...\n')
% indicate folder name to save
folder = '.\Result\trimmed_skeleton\';
if ~exist(folder, 'dir')
    fprintf('Generating new folder...\n')
    mkdir(folder)
else
    fprintf('Folder already existed.\n')
end
% start saving the skeletonized volume
%  indicate image format to save
style = '.tif';
sliceNumber = startPage:endPage;
for slice = 1:size(trimskel,3)
    im = trimskel(:,:,slice);
    imwrite(im,[folder,num2str(sliceNumber(slice),['%0',num2str(sigDigits),'d']),...
        style]);
end
fprintf('Saving completed!\n')
%% Plot skeleton based on branches and nodes
figure
bran_dotsize = 1; % dot size of branch points 
bran_dotcolor = 'g';% dot color of branch points 
node_dotsize = 10; % dot size of node points 
node_dotcolor = 'r';% dot color of node points
AZ = 120; % azimuth or horizontal rotation  (in degrees).
EL = 20; % vertical elevation (in degrees).
corbran = [];
for i = 1:length(bran)
    corbran = [corbran;bran{i}];
end
PlotScatter_datas(corbran,bran_dotsize,bran_dotcolor,datas);
hold on
PlotScatter_datas(node(:,1),node_dotsize,node_dotcolor,datas) ;
FigureFormat(AZ,EL)
hold off
%%  Step 2: Node merging
fprintf('Second step: merging the nodes.\n')
% merge connected nodes
tic
[c2,n2,b2] = merge_connectednodes(connect,node,bran,datas);
% delete branches
clear c3 n3 b3
[c3,n3,b3] = merge_double(c2,n2,b2,datas,5);

% merge nearby nodes
[c4,n4,b4] = merge_nearby(c3,n3,b3,10,1,datas);

% delete branches again
clear c5 n5 b5
[c5,n5,b5] = merge_double(c4,n4,b4,datas);
time = toc;
node_final = [];
for i = 1:size(n5,1)
    if n5(i,2)>2
        node_final = [node_final;n5(i,:)];
    end
end
connect_final = c5;
bran_final = b5;
fprintf('Node merging is completed within %f seconds!\n', time) 
%% Plot skeleton based on branches and nodes
figure
bran_dotsize = 1; % dot size of branch points 
bran_dotcolor = 'g';% dot color of branch points 
node_dotsize = 10; % dot size of node points 
node_dotcolor = 'r';% dot color of node points
AZ = 120; % azimuth or horizontal rotation  (in degrees).
EL = 20; % vertical elevation (in degrees).
corbran = [];
for i = 1:length(bran_final)
    corbran = [corbran;bran_final{i}];
end
PlotScatter_datas(corbran,bran_dotsize,bran_dotcolor,datas);
hold on
PlotScatter_datas(node_final(:,1),node_dotsize,node_dotcolor,datas) ;
FigureFormat(AZ,EL)
hold off
title('Final Plot')

%% Save all required info for data analysis
fprintf('Binary volume is registered in terms of branche and node connection.\n') 
fprintf('Start saving data for analysis.\n') 
folder = '.\Result\processData_mat\';
if ~exist(folder, 'dir')
    fprintf('Generating new folder...\n')
    mkdir(folder)
else
    fprintf('Folder already existed.\n')
end 
node = node_final;
bran = bran_final;
connect = connect_final;
save([folder,'orig.mat'],'orig');% save binary volume
save([folder,'trimskel.mat'],'trimskel') % save skeleton volume
save([folder,'node_final.mat'],'node') % save registered nodes
save([folder,'bran_final.mat'],'bran') % save registered branches
save([folder,'connect_final.mat'],'connect') % save registered connections
fprintf('Save completed!\n') 