function [connect,node,bran] = merge_connectednodes(c,n,b,datas)
%merge connected nodes
connect=c;
bran=b;
node = n;
%%
newnode = [];
nodeout = [];
for iter = 1:size(node,1)
    flag = ismember(node(iter,1),nodeout);
    if flag
        continue
    else
        nearnode = node(iter+1:min(iter+500,end),1);
        if iter == size(node,1) % last node
            continue
        else
            nei = neighbor(node(iter,1),datas); % neighbors
            [Lia, L] = ismember(nei,nearnode); % check if neighbors are nodes
            Loc = L(L~=0);%%
            Lia = sum(Lia);
            if Lia == 0  % no connected nodes
               newnode = [newnode;node(iter,1)];
               continue
            else % exist connected nodes
                nodeout = [nodeout;node(iter,1)];
             %   fprintf('exist connected nodes %d\n',Lia);
                cluster = [];
                for i = 1:length(Loc)
                    cluster = [cluster;nearnode(Loc(i))];
                end
                cluster = [cluster;node(iter,1)];
                temp = cluster(cluster~=max(cluster));
                % find deleted nodes in connect and replace by new nodes.
                for i = 1:length(temp)
                    cb = find(connect(:,1)==temp(i));
                    if isempty(cb)
                    else
                        for j = 1:length(cb)
                            connect(cb(j),1) = max(cluster);
                        end
                        bran{cb(1)}=[temp(i);bran{cb(1)}];
                    end
                    cb = find(connect(:,2)==temp(i));
                    if isempty(cb)
                    else
                        for j = 1:length(cb)
                            connect(cb(j),2) = max(cluster);
                        end
                        bran{cb(1)}=[bran{cb(1)};temp(i)];
                    end
                end   
            end       
        end
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
node(:,1) = unique(connect);
for i = 1:length(node)
    numcon = length(find(connect(:,1)==node(i)))+length(find(connect(:,2)==node(i)));
    node(i,2) = numcon;
end

