function [bran,connect,node]= branch_sort2(skel,node,datas)

skel(node(:,1))=0;
BW = bwlabeln(skel,26);
indexbran = 1;
flag = 0;
for iter = 1:max(BW(:))
    %sort the voxels for each branch
    corbran = find(BW == iter);
   %     fprintf('Iteration %d how long the branch %d\n',iter,size(corbran));
    if size(corbran,1)>1  %for more than 1 voxel branches
        indexend = 0;
        clear startnode
        for k = 1:size(corbran,1) %for all voxels on this branch
            n = neighbor(corbran(k),datas);%find 3x3x3 points
            numin = sum(double(ismember(n,corbran)));%belongs to the branch
            if numin == 2 % end point identification
                temp=(double(ismember(n,node(:,1))));
                connectnode = n(temp==1);
                if sum(temp)==1 % connected to one and only one node
                    indexend=indexend+1;
                    startnode(indexend)=connectnode; % register the node
                elseif sum(temp)>1
                    indexend=indexend+1;
                    flag = flag+1;
                    % modify 3/19
                    [x1,y1,z1] = ind2sub(datas,connectnode);
                    newNodeLoc = sub2ind(datas,round(mean(x1)),round(mean(y1)),round(mean(z1)));
                    startnode(indexend)=newNodeLoc; % register the node
                end
            end
        end

        if indexend == 2 % both ends are connected to one and only one node
            connect(indexbran,:)=startnode';% regsiter the nodes
            bran{indexbran} = corbran; % and the branch
            indexbran=indexbran+1;
        elseif indexend >2 
            fprintf('3\n');
        elseif indexend == 1  % one ended branch
%             fprintf('error\n');
            %bran{indexbran}=[[startnode,0]';corbran];   % regsiter the one ended nodes and the branch
            %indexbran=indexbran+1;
        else %floating branch or connected to more than 2 nodes
%             fprintf('attention\n');
        end
    else % for 1 voxel branches 
%         continue

        clear startnode
        n = neighbor(corbran(1),datas);
        temp = (double(ismember(n,node(:,1))));
        if sum(temp) == 2 % this single voxel branch is connected to two nodes
            startnode(1:2) = n(temp==1); % register the node
            connect(indexbran,:) = startnode';% regsiter the nodes
            bran{indexbran} = corbran; % and the branch
            indexbran=indexbran+1;
        end
%         fprintf('connected node %d\n',startnode);
    end  
end
cluster = find(connect(:,1)==connect(:,2));
cluster = flip(cluster);
for k = 1:length(cluster)
    newconnect = [connect(1:cluster(k)-1,:);connect(cluster(k)+1:end,:)];
    clear connect; 
    connect = newconnect;
    bran{cluster(k)}=[];
end
id = cellfun('length',bran);bran(id==0)=[];
clear node
node(:,1) = unique(connect(:));
for i = 1:length(node)
    numcon = length(find(connect(:,1)==node(i)))+length(find(connect(:,2)==node(i)));
    node(i,2) = numcon;
end   
end