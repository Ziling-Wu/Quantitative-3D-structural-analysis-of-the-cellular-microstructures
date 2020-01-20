% =========================================================================
% Sub-Function inside the main function for node type analysis
% 
% =========================================================================
%%%%%%%%%%   Section 1: Remove boundary branches and nodes      %%%%%%%%%%
%%  Inner node detection  
% Interbranch angle distribution is not realiable at the boundary.
% Therefore, in the following analysis, we will get rid of boundary region.
boundaryLimit = 30;% set boundary limit depending on your data size. Here 
                   % we use 30 pixels give the image size [386,386,308];
index = 1;
clear innerNode
for i=1:size(node,1)
    nic(i) = isboundary(node(i,1),boundaryLimit,datas); %if 1, branch is at the boundary.
    if ~nic(i)    % only left inner btranches
        innerNode(index,:) = node(i,:);
      	index=index+1;
	end
end  
clear node
node = innerNode;


%%%%%%%%%%%%%%%%%%%%   Section 2: Node type analysis      %%%%%%%%%%%%%%%%%
%% Node types number distribution
fprintf('Show all possible node types \n')
disp(unique(node(:,2)))
% set node type range
minNodeType = min(unique(node(:,2)));
maxNodeType = max(unique(node(:,2)))+1;
nodeType = minNodeType:1:maxNodeType;
hlc = histofrequency(node(:,2),nodeType); 
figure
x = hlc(:,1)-0.5;
bar(x,hlc(:,2)); colormap jet
set(gcf,'color','white')
title('Node type distribution')
%% node type frequency distribution
figure
hlc= histofrequency(node(:,2),nodeType);
x=hlc(:,1)-0.5;
bar(x,hlc(:,2))
colormap jet
set(gcf,'color','white')
xlabel('Node types');ylabel('Frequency')
% ylim([0,0.6])
% saveas(gcf,'nodetype','epsc')
% saveas(gcf,'nodetype','png')
% saveas(gcf,'nodetype','pdf')
%% 
fprintf('Node type analysis completed!\n')
open 02_main_dataAnalysis