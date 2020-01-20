function [connect,node,bran]=merge_double(c,n,b,datas,constant)
% 6/8: line 56 % don't merge too long branch
%   max(len)->min(len)
connect=c;
bran=b;
node = n;
%%
nodeout=[];
newnode = [];
for iter = 1:size(node,1)
    flag = ismember(node(iter,1),nodeout);
    if flag
        continue
    else
    if node(iter,2) == 0
        nodeout=[nodeout;node(iter,1)];
    elseif node(iter,2) == 1
        newnode = [newnode;node(iter,:)];
    elseif node(iter,2) > 2
        newnode = [newnode;node(iter,:)];
    else
        clear cc cd
        cc = find(connect(:,1) == node(iter,1));
        cd = find(connect(:,2) == node(iter,1));
        ce = [cc;cd];
%         fprintf('iteration %d,nodetype %d node %d\n',iter,node(iter,2),node(iter,1));
%         fprintf('ce %d\n',ce);

        cluster = [];
        for k = 1:length(ce)
            if connect(ce(k),1)~=node(iter,1)
                cluster = [cluster,connect(ce(k),1)];
            end
            if connect(ce(k),2)~=node(iter,1)
                cluster = [cluster,connect(ce(k),2)];
            end
        end
         %fprintf('connect %d\n',cluster);
         if isempty(cluster)
             fprintf('empty cluster\n')
             if cc == cd
                newconnect(cc,:) = 0;
                newbran{cc} = [];
                id = cellfun('length',bran);bran(id==0)=[];
             end
        
            continue
         else
            cluster = unique(cluster);
            if nargin == 4
                nodeout = [nodeout;node(iter,1)];
            else
                len = [];
                for k = 1:length(ce)
                    len = [len,length(bran{ce(k)})];
                end  
                if min(len) > constant % don't merge too long branch
                    newnode = [newnode;node(iter,:)];
                    continue
                else
                    nodeout = [nodeout;node(iter,1)];
                end
            end
            connect(ce(1),:) = cluster(:);
            newconnect = [connect(1:ce(2)-1,:);connect(ce(2)+1:end,:)]; 
            clear connect; connect = newconnect;
            tmpbran1 = bran{ce(1)};
            tmpbran2 = bran{ce(2)};
            dis = [vecdist(tmpbran1(1),tmpbran2(end),datas);vecdist(tmpbran1(end),tmpbran2(1),datas)];
            if find(dis == min(dis))==1
                bran{ce(1)} = [bran{ce(2)};node(iter,1);bran{ce(1)}];
            else
                bran{ce(1)} = [bran{ce(1)};node(iter,1);bran{ce(2)}];
            end
            bran{ce(2)} = [];
            id = cellfun('length',bran);bran(id==0)=[];
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