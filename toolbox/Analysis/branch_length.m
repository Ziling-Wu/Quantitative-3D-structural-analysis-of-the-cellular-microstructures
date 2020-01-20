function [branlen,brandis] = branch_length(bran,connect,datas)
branlen = [];
brandis = [];
for i = 1: length(bran)
    tmpbran= bran{i};
    dis = 0;
    for j =1:length(tmpbran)-1
%         vecdist(tmpbran(j),tmpbran(j+1),datas)
        dis = vecdist(tmpbran(j),tmpbran(j+1),datas)+dis;
    end
    startDis = [vecdist(connect(i,1),tmpbran(1),datas),vecdist(connect(i,1),tmpbran(end),datas)];
    EndDis = [vecdist(connect(i,2),tmpbran(1),datas),vecdist(connect(i,2),tmpbran(end),datas)];
% [xs, ~] = sort(startDis);
    sDis = min(startDis);
    eDis = min(EndDis);
    % Branch length
    branlen = [branlen;dis+sDis+eDis];
    % Branch distance
    brandis = [brandis;vecdist(connect(i,1),connect(i,2),datas)];
end