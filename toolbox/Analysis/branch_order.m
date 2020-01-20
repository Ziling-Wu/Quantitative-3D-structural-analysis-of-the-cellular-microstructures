function newbran = branch_order(bran,connect,datas)
newbran = cell(1);
for i = 1:length(bran)
    newTempbran = [];
    tmpbran= unique(bran{i});
    startnode = connect(i,1);
    n = neighbor(startnode,datas);
    nextNode = intersect(n,tmpbran);
    if isempty(nextNode)
       clear dist
       for j = 1:length(tmpbran)
           dist(j) = vecdist(startnode,tmpbran(j),datas);
       end
       ind = find(dist == min(dist));
       nextNode = tmpbran(ind);
    end
    newTempbran = [newTempbran,nextNode];
    flag = length(nextNode);
    while flag<length(tmpbran)
        flag = flag + 1;
        n = neighbor(nextNode(1),datas);
        curNode = setdiff(intersect(n,tmpbran),newTempbran);
        if ~isempty(curNode)
            newTempbran = [newTempbran(:);curNode(:)]';
            nextNode = curNode;
        else
            restBran = setdiff(tmpbran,newTempbran);
            dist = [];
            for j = 1:length(restBran)
                dist(j) = vecdist(nextNode(1),restBran(j),datas);
            end
%             if isempty(dist)
%                 break
%             end
            ind = find(dist == min(dist));
            newTempbran = [newTempbran(:);restBran(ind)]';
            nextNode = restBran(ind); 
        end
    end
    if length(newTempbran)>2
        currentBran = newTempbran(:);
        currentBran_front = currentBran(1:end-1);
        if vecdist(newTempbran(end),newTempbran(end-1),datas)>10
    %         vecdist(newTempbran(end),newTempbran(end-1),datas)
            if vecdist(newTempbran(end),newTempbran(1),datas)>10
    %             vecdist(newTempbran(end),newTempbran(1),datas)
                adjustBran = currentBran_front;
            else
                adjustBran = [currentBran(end);currentBran_front];
            end
        else
            adjustBran = currentBran;
        end

        newbran{i} = adjustBran;
    else
        newbran{i} = newTempbran(:);
    end
end