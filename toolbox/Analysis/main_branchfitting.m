%% fit all branch profiles into second order lines
allfit = [];
clf
index = 1;
branlenTemp = [];
branlenThick = [];
OutLen = [];
OutThickness = [];
for i =1:size(allthickness,2)
    thick = allthickness{i};
    t = thick(:,2)*pixelSize;
    numbran = thick(1,4);
    allbran = bran{numbran};
    connectBran = connect(numbran,:);
    tmpbran = allbran;%allbran(thick(:,3));
    dis = 0;
    brancor = [];
    brancor(1) = 0;
    for j = 1:length(tmpbran)-1
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
        if (max(abs(z))>25) || ((dis)>35) || ((dis)<2)
%             i
            continue
        else
        startDis = [vecdist(connectBran(1),tmpbran(1)),vecdist(connectBran(1),tmpbran(end))];
        EndDis = [vecdist(connectBran(2),tmpbran(1)),vecdist(connectBran(2),tmpbran(end))];
% [xs, ~] = sort(startDis);
        sDis = min(startDis);
        eDis = min(EndDis);
        branlenTemp(index) = dis+sDis*0.65+eDis*0.65;
       
        branlenThick(index) = branthickness(i);
        OutLen = [OutLen;z/dis];
        OutThickness = [OutThickness;t/branthickness(i)];
        index = index+1;
        ft2 = fittype({'1','x^2'});
        p = fit(z,t,ft2);
        y1 = p(z);
        plot(z,t,'.')
        hold on
        plot(z,y1)
        allfit = [allfit;p.b];
        legend(gca,'off')
         hold on
         ylim([0,15])
        end
    end
    end
end

%%
saveas(gcf,'profile','epsc')
 saveas(gcf,'profile','pdf')
 saveas(gcf,'profile','png')
%%
excelLenThick = [OutLen,OutThickness];
plot(OutLen,OutThickness,'.')
% xlswrite('NormalizedLenThick',excelLenThick)
%%
excelLenThickPoint =  [branlenTemp;branlenThick]';
xlswrite('LenvsThick',excelLenThickPoint)
%%
clf
x = branlenTemp';
X = [ones(length(x),1) x];
y = branlenThick';
b = X\y;
xrange = min(x):0.1:max(x);
Xrange = [ones(length(xrange),1) xrange'];
yCalc2 = Xrange*b;
scatter(branlenTemp,branlenThick,'.','b','LineWidth',1)
hold on
plot(xrange,yCalc2,'--','LineWidth',1)
% grid on
ylim([0,10])

xlabel('Branch thickness (\mu m)')
ylabel('Branch length (\mu m)')
% saveas(gcf,'branlenvsThickness','epsc')
%  saveas(gcf,'branlenvsThickness','pdf')
%  saveas(gcf,'branlenvsThickness','png')
hold on
load allChainlength
load allChainthickness
allChainthickness(allChainlength>50) = [];
allChainlength(allChainlength>50) = [];
x = allChainlength;
X = [ones(length(x),1) x];
y = allChainthickness;
b = X\y;
xrange = min(x):0.1:max(x);
Xrange = [ones(length(xrange),1) xrange'];
yCalc2 = Xrange*b;
scatter(allChainlength,allChainthickness,'r','LineWidth',0.5)
hold on
plot(xrange,yCalc2,'--','LineWidth',1)
legend('All branches','Fitted curve','Chain','fitted','Location','best');