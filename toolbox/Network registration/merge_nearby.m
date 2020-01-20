function [connect,newnode,bran]=merge_nearby(c,n,b,merge_thres,open,datas)
connect=c;
bran=b;
node = n;
%%
distance = merge_thres;
newnode = [];
nodeout = [];
index = 1;
for iter = 1:size(node,1)
     %fprintf('iteration %d\n',iter);
    flag = ismember(node(iter,1),nodeout);
    if flag
        continue
    else
        if open
            [~,~,zsign] = ind2sub(datas,node(iter,1));
            if zsign<1700
               distance = 12;
            elseif zsign>=1700&&zsign<2200
                distance = 10;
            else
                distance = 8;
            end
        end
        newnode = [newnode;node(iter,1)];
        if iter == size(node,1)%last one
            continue
        else
            array = iter+1:min(iter+1000,size(node,1));
            clear temp_distance
            [x1,y1,z1]  = ind2sub(datas,node(:,1));
            for i = 1:length(array)
                temp_distance(i) = vecdist(node(array(i),1),node(iter,1),datas);
            end
            loc = find(temp_distance <= distance);
            if ~isempty(loc)
                cluster = node(iter,1);
                for k = 1:length(loc)
                    cluster = [cluster,node(array(loc(k)),1)];
                    nodeout(index) = node(array(loc(k)),1);
                    index= index+1;
                end
                clear cg;
                cg = []; %delete intersect branches
                if length(cluster)>=2 
%                     fprintf('new %d\n',iter);
%                     imindex = 1;
                    for k = 1:length(cluster)-1
                        for kk = k+1:length(cluster)
                            cc = intersect(find(connect(:,1)==cluster(k)),find(connect(:,2)==cluster(kk)));
                            cd = intersect(find(connect(:,1)==cluster(kk)),find(connect(:,2)==cluster(k)));
                            clear tempc;
                            tempc = [cc',cd];
                            if ~isempty(tempc)
                                cg = [cg;tempc(:)];
                            end
%                                 important(imindex) = cluster(k);
%                                 imindex = imindex+1;
%                             end
                        end
                    end
                    if isempty(cg)
                    else
                        cg = sort(cg,'descend');
                        for k = 1:length(cg)% deletig=ng intersect branches
%                             tempbran = cell(1);
                            newconnect = [connect(1:cg(k)-1,:);connect(cg(k)+1:end,:)];
                            clear connect; 
                            connect = newconnect;
%                             tempbran{k} = bran{cg(k)};
                            bran{cg(k)}=[];
                        end
                        id = cellfun('length',bran);bran(id==0)=[];
                    end
                    a1 = []; a2 = [];%change connect node into undeleted node
                    [x,y,z] = ind2sub(datas,cluster);
                    center = sub2ind(datas,round(mean(x)),round(mean(y)),round(mean(z)));
                    for k = 1:length(cluster)
                        t1 = find(connect(:,1)==cluster(k));
                        %fprintf('t1 %d\n',t1);
                        a1 = [a1;t1(:)];
                        t2 = find(connect(:,2)==cluster(k));
                        a2 = [a2;t2(:)];
                    end
                    if ~isempty(a1)
                        for j = 1:length(a1)
                            connect(a1(j),1) = center;
%                             [~,loc1] = ismember(a1(j),cg);
%                             if ~isempty(loc1)
%                                 bran{a1(j)} = [bran{a1(j)};tempbran{loc1}];
%                             end
%                       fprintf('change1 %d\n',a1(j));
                        end
                    end
                    if ~isempty(a2)
                        for j = 1:length(a2)
                        connect(a2(j),2) = center;
                        end
                    end
                else
                     continue
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
newnode = unique(connect);
for i = 1:length(newnode)
    numcon = length(find(connect(:,1)==newnode(i,1)))+length(find(connect(:,2)==newnode(i,1)));
    newnode(i,2) = numcon;
end
