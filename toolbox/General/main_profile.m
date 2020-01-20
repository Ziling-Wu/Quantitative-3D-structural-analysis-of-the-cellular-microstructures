%% fit all branch profiles

allfit = [];
clf
index = 1;
branlenTemp = [];
branlenThick = [];
OutLen = [];
OutThickness = [];
for i = 1:size(allthickness,2)
    thick = allthickness{i};
    t = thick(:,2)*pixelSize;
    numbran = thick(1,4);
    allbran = bran{numbran};
    connectBran = connect(numbran,:);
    tmpbran = allbran;%allbran(thick(:,3));
    dis = 0;
    brancor = [];
    brancor(1) = 0;
    for j =1:length(tmpbran)-1
        [x1,y1,z1] = ind2sub(datas,tmpbran(j));
        [x2,y2,z2] = ind2sub(datas,tmpbran(j+1));
        dis = sqrt((x1-x2).^2+(y1-y2).^2+(z1-z2).^2)*pixelSize+dis;
        brancor(j+1) = dis;
    end
    if sum(isnan(t))>0
        continue
    else
    if length(t)>1%original set
       
        a = find(abs(thick(:,2))== min(thick(:,2)),1);
        z = (brancor-brancor(a))';
        if   ((dis)<2)
            i
            continue
        else
        startDis = [vecdist(connectBran(1),tmpbran(1),datas),vecdist(connectBran(1),tmpbran(end),datas)];
        EndDis = [vecdist(connectBran(2),tmpbran(1),datas),vecdist(connectBran(2),tmpbran(end),datas)];
% [xs, ~] = sort(startDis);
        sDis = min(startDis);
        eDis = min(EndDis);
        branlenTemp(index) = dis+sDis*pixelSize+eDis*pixelSize;
       
        branlenThick(index) = branthickness(i);
        OutLen = [OutLen;z/dis];
        OutThickness = [OutThickness;t/branthickness(i)];
        index = index+1;
%         ft2 = fittype({'1','x^2'});
%         p = fit(z,t,ft2);
%         y1 = p(z);
        plot(z(1:length(t)),t,'.')
        hold on
%         hold on
%         plot(z,y1)
%         allfit = [allfit;p.b];
%         legend(gca,'off')
%          hold on
%          ylim([0,15])
        end
    end
    end
end
ylim([0,900])
xlim([-600,600])
axis image
%%
saveas(gcf,'profile','epsc')
 saveas(gcf,'profile','pdf')
 saveas(gcf,'profile','png')