function [thickness,newbran_thickness,newconnect_thickness,cont] = branch_thickness(bran,connect,node,new_img)
datas = size(new_img);
cont = edge3(new_img,'approxcanny',0.6);
%% newbran , newconnect middle point and direction
% find each branch center point and save in middleBran
newbran = bran;
newconnect = connect; 
numbran = length(newbran);
middleBran = zeros(numbran,1);
for i = 1:numbran
    element = newbran{i};
    lensbran = size(element,1);
    if (mod(lensbran,2)==1)%odd
        middle = floor(lensbran/2)+1;
        middleBran(i) = element(middle);
    else %even
        middle = floor(lensbran/2);
        middleBran(i)=element(middle);
    end
end
%% Calculate branch central thickness
newbran_thickness=cell(1);
newconnect_thickness = [];
index =1;
clear thickness
for i = 1: length(middleBran)
    [x0,y0,z0] = ind2sub(datas,middleBran(i,1));
    width = 15;
        w = 1;
        temp = 0;
        while temp <1
            w = w+1;
            region = cont(x0-w:x0+w,y0-w:y0+w,z0-w:z0+w);
            temp = length(find(region == 1));
        end
    newbran_thickness{index} = newbran{i};
    newconnect_thickness(index,:) = newconnect(i,:);
    thickness(index,1) = middleBran(i,1);
    thickness(index,2) = w;%pi*radius^2;
    index = index+1;
end       