% =========================================================================
% Sub-Function inside the main function for ring analysis
% =========================================================================
%%  Ring detection
fprintf('Start ring detection ... It will take some time.\n') 
ne = [];
for i = 1:size(node,1)
    if node(i,2)>2
        ne = [ne;node(i,:)];
    end
end
ce = connect;
j = 0;
clear registern loopn
% Four different type rings are analysis here: 4-Edge,5-Edge, 6-Edge and 7-Edge
ring4 = cell(1);
ring5 = cell(1);
ring6 = cell(1);
ring7 = cell(1);
% Iterative analyze every node to detect rings
tic
for i = 1:size(ne,1)
    n0 = ne(i,1);
%     try
        [lp4,lp5,lp6,lp7,nb1] = findloop(ce,n0,datas);% find all loop connected with node n0
        if ~isempty(size(nb1))
            j = j+1;
            registern(j)=i;
            loopn(:,j) = [size(lp4,1),size(lp5,1),size(lp6,1),size(lp7,1)];
            % 4-Edge rings
            if ~isempty(lp4) % exist 4-Edge rings 
                error4 = cell(1);
                fit4 = [];
                for k = 1:size(lp4,1)
                    lp = lp4(k,:);
                    branTemp = [];
                    for ii = 1:3
                        branTemp = [branTemp;bran{findbran(lp(ii),lp(ii+1),connect)}];
                    end
                    branTemp = [branTemp;bran{findbran(lp(4),lp(1),connect)}];
                    [fit,errors] = planeFitting_v2(branTemp,datas); % fit ring into plane
                    fit4 = [fit4,fit];
                    error4{k} = errors;
                end
                ring4{j,2} = fit4;ring4{j,3} = error4;
                ring4{j,1} = lp4;
            end
            % 5-Edge rings
            if ~isempty(lp5)
                error5 = cell(1);
                fit5 = [];
                for k = 1:size(lp5,1)
                    
                    lp = lp5(k,:);
                    branTemp = [];
                    for ii = 1:4
                        branTemp = [branTemp;bran{findbran(lp(ii),lp(ii+1),connect)}];
                    end
                    branTemp = [branTemp;bran{findbran(lp(5),lp(1),connect)}];
                    [fit,errors] = planeFitting_v2(branTemp,datas);
                    fit5 = [fit5,fit];
                    error5{k} = errors;
                    
                end
                ring5{j,2} = fit5;ring5{j,3} = error5;
                ring5{j,1} = lp5;
            end
            % 6-Edge rings
            if ~isempty(lp6)
                fit6 = [];
                error6 = cell(1);
                for k = 1:size(lp6,1)
                    lp = lp6(k,:);
                    branTemp = [];
                    for ii = 1:5
                        branTemp = [branTemp;bran{findbran(lp(ii),lp(ii+1),connect)}];
                    end
                    branTemp = [branTemp;bran{findbran(lp(6),lp(1),connect)}];
                    [fit,errors] = planeFitting_v2(branTemp,datas);
                    fit6 = [fit6,fit];
                    error6{k} = errors;
                end
                ring6{j,2} = fit6;ring6{j,3} = error6;
                ring6{j,1} = lp6;
            end
             % 7-Edge rings
            if ~isempty(lp7)
                 fit7 = [];
                error7 = cell(1);
                for k = 1:size(lp7,1)
                    lp = lp7(k,:);
                    branTemp = [];
                    for ii = 1:6
                        branTemp = [branTemp;bran{findbran(lp(ii),lp(ii+1),connect)}];
                    end
                    branTemp = [branTemp;bran{findbran(lp(7),lp(1),connect)}];
                    [fit,errors] = planeFitting_v2(branTemp,datas);
                    fit7 = [fit7,fit];
                    error7{k} = errors;
                end
                ring7{j,1} = lp7;
                ring7{j,2} = fit7;ring7{j,3} = error7;
            end
        end  
%     catch ME
%         fprintf('findloop without success: %s\n', ME.message);
%         continue;  % Jump to next iteration 
%     end    
end
time = toc;
fprintf('Ring detection is completed within %f seconds!\n', time) 
ring = cell(1);
ring{1} = ring4;
ring{2} = ring5;
ring{3} = ring6;
ring{4} = ring7;
%% Ring size and Ring angle calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%   4-Edge ring     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('4-Edge ring analysis ...\n') 
ring4 = ring{1};
dis = [];
allAngle4 = [];
allRingSize4 = [];
loc4 = [];
for j = 1:size(ring4,1)
    index = 0;% number of rings it left for each node
    tempRingDots = ring4{j,1};
    tempRing = ring4{j,3};
    tempRingDir = ring4{j,2};
    if ~isempty(tempRing)
        angle = [];
        ringSize = [];
    for i =1:length(tempRing)
        tempDis = tempRing{i};% The plane fitting error; If it is too big, 
                              % means this ring is not in the same plan
        if max(tempDis)>5
            continue
        else
            index = index+1;
            loc4 = [loc4;[j,i]];
        dis = [dis;tempDis];
        fit = tempRingDir(:,i);
        tempAngle = vectorAngle([fit(1),fit(2),fit(3)]);
        angle = [angle;tempAngle];
        
        [y,x,z] = ind2sub(datas,tempRingDots(i,:)');
        if abs(fit(3))<0.1 
            z0 = z;
        else
            z0 = -(fit(1)*x+fit(2)*y+fit(4))/fit(3);
        end
        ringdots = [x,y,z0];
%         ringdots = [x,y,z];
        s = ringSize_4E(ringdots,datas);
        ringSize = [ringSize;s];
        end
    end
    ring4{j,4} = angle;
    ring4{j,5} = ringSize;
    ring4{j,6}= index;
    allAngle4 = [allAngle4;angle];
    allRingSize4 = [allRingSize4;ringSize];
    end
end
fprintf('4-edge ring analysis completed!\n')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%   5-Edge ring     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('5-Edge ring analysis ...\n') 
ring5 = ring{2};
dis = [];
allAngle5 = [];
allRingSize5 = [];
loc5 = [];
for j =1:size(ring5,1)
    index = 0;% number of rings it left for each node
    tempRingDots = ring5{j,1};
    tempRing = ring5{j,3};
    tempRingDir = ring5{j,2};
    if ~isempty(tempRing)
        angle = [];
        ringSize = [];
    for i =1:length(tempRing)
        tempDis = tempRing{i};
        if max(tempDis)>5
            continue
        else
            index = index+1;
            loc5 = [loc5;[j,i]];
        dis = [dis;tempDis];
        fit = tempRingDir(:,i);
        tempAngle = vectorAngle([fit(1),fit(2),fit(3)]);
        angle = [angle;tempAngle];
        
        [y,x,z] = ind2sub(datas,tempRingDots(i,:)');
        z0 = -(fit(1)*x+fit(2)*y+fit(4))/fit(3);
        ringdots = [x,y,z0];
        s = ringSize_5E(ringdots);
        ringSize = [ringSize;s];
        end
    end
    ring5{j,4} = angle;
    ring5{j,5} = ringSize;
    ring5{j,6}= index;
    allAngle5 = [allAngle5;angle];
    allRingSize5 = [allRingSize5;ringSize];
    end
end
fprintf('5-edge ring analysis completed!\n')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%   6-Edge ring     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('6-Edge ring analysis ...\n') 
loc6 = [];
ring6 = ring{3};
dis = [];
allAngle6 = [];
allRingSize6 = [];
for j =1:size(ring6,1)
    index = 0;
    tempRingDots = ring6{j,1};
    tempRing = ring6{j,3};
    tempRingDir = ring6{j,2};
    if ~isempty(tempRing)
        angle = [];
        ringSize = [];
    for i =1:length(tempRing)
        tempDis = tempRing{i};
        
        if max(tempDis)>5
            continue
        else
            index = index+1;
            loc6 = [loc6;[j,i]];
            dis = [dis;tempDis];
        fit = tempRingDir(:,i);
        tempAngle = vectorAngle([fit(1),fit(2),fit(3)]);
        angle = [angle;tempAngle];
        
        
        [y,x,z] = ind2sub(datas,tempRingDots(i,:)');
        z0 = -(fit(1)*x+fit(2)*y+fit(4))/fit(3);
        if length(find(z0<=0))>0
           ringdots = [x,y,z];
        else
           ringdots = [x,y,z0];
        end
        s = real(ringSize_6E(ringdots));
        ringSize = [ringSize;s];
        end
    end
    ring6{j,4} = angle;
    ring6{j,5} = ringSize;
    ring6{j,6}= index;
    allAngle6 = [allAngle6;angle];
    allRingSize6 = [allRingSize6;ringSize];
    end
end
fprintf('6-edge ring analysis completed!\n')
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%   7-Edge ring     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('7-Edge ring analysis ...\n') 
ring7 = ring{4};
dis = [];
allAngle7 = [];
allRingSize7 = [];
loc7 = [];
for j =1:size(ring7,1)
    index = 0;
    tempRingDots = ring7{j,1};
    tempRing = ring7{j,3};
    tempRingDir = ring7{j,2};
    if ~isempty(tempRing)
        angle = [];
        ringSize = [];
    for i =1:length(tempRing)
        tempDis = tempRing{i};
        if max(tempDis)>5
            continue
        else
            index = index+1;
            loc7 = [loc7;[j,i]];
        dis = [dis;tempDis];
        fit = tempRingDir(:,i);
        tempAngle = vectorAngle([fit(1),fit(2),fit(3)]);
        angle = [angle;tempAngle];
        
        [y,x,z] = ind2sub(datas,tempRingDots(i,:)');
        z0 = -(fit(1)*x+fit(2)*y+fit(4))/fit(3);
        if length(find(z0<=0))>0
           ringdots = [x,y,z];
        else
           ringdots = [x,y,z0];
        end
        s = ringSize_7E(ringdots);
        ringSize = [ringSize;s];
        end
    end
    ring7{j,4} = angle;
    ring7{j,5} = ringSize;
    ring7{j,6} = index;
    allAngle7 = [allAngle7;angle];
    allRingSize7 = [allRingSize7;ringSize];
    end
end
fprintf('7-edge ring analysis completed!\n')
%% Ring detection parameters
clear a
a(1,1) = 4;

a(1,2) = mean(sqrt(allRingSize4))*pixelSize;
a(1,3) =std(sqrt((allRingSize4)));
a(1,4) = length(allRingSize4);

% a(1,2) = mean(sqrt(allRingSize4/pi)*pixelSize*2);
% a(1,3) =std(sqrt(allRingSize4/pi)*pixelSize*2);
% a(1,4) = length(allRingSize4);
a(2,1) = 5;
a(2,2) =mean(sqrt(allRingSize5/pi)*pixelSize*2);
a(2,3) =std(sqrt(allRingSize5/pi)*pixelSize*2);
a(2,4) = length(allRingSize5);
a(3,1) = 6;
a(3,2) =mean(sqrt(allRingSize6/pi)*pixelSize*2);
a(3,3) =std(sqrt(allRingSize6/pi)*pixelSize*2);
a(3,4) = length(allRingSize6);
a(4,1) = 7;
a(4,2) =mean(sqrt(allRingSize7/pi)*pixelSize*2);
a(4,3) =std(sqrt(allRingSize7/pi)*pixelSize*2);
a(4,4) = length(allRingSize7);
clc
fprintf(['There are %d 4-Edge rings detected. The mean ring size is %4f and ',... 
        'standard variation is %4f \n'],a(1,4),a(1,2),a(1,3)) 
fprintf(['There are %d 5-Edge rings detected. The mean ring size is %4f and ',... 
        'standard variation is %4f \n'],a(2,4),a(2,2),a(2,3)) 
fprintf(['There are %d 6-Edge rings detected. The mean ring size is %4f and ',... 
        'standard variation is %4f \n'],a(3,4),a(3,2),a(3,3)) 
fprintf(['There are %d 7-Edge rings detected. The mean ring size is %4f and ',... 
        'standard variation is %4f \n'],a(4,4),a(4,2),a(4,3)) 
%% Plot rings
%%%% Start ring plotting if you would like to; if not, go to next section
%%%% directly
fprintf('Start ring plotting ...\n') 
open main_ring_plot


%% Finish ring section
fprintf('Ring analysis completed!\n')
open main_dataAnalysis