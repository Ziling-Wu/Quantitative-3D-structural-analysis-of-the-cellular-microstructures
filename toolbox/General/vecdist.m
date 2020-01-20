function ret =  vecdist(A1,A2,datas)
if length(A1)==1
    [x1,y1,z1] = ind2sub(datas,A1);
    [x2,y2,z2] = ind2sub(datas,A2);
else
    x1 = A1(1);y1 = A1(2);z1 = A1(3);
    x2 = A2(1);y2 = A2(2);z2 = A2(3);
end
ret = sqrt((x1-x2).^2 + (y1-y2).^2 + (z1-z2).^2) ;
end