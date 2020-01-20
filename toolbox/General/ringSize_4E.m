function s = ringSize_4E(ringdots,datas)
A = ringdots(1,:);
B = ringdots(2,:);
C = ringdots(3,:);
D = ringdots(4,:);

a = vecdist(A,B,datas);
b = vecdist(B,C,datas);
c = vecdist(C,D,datas);
d = vecdist(D,A,datas);
e = vecdist(A,C,datas);
s1 = sqrt((a+b+e)*(-a+b+e)*(a-b+e)*(a+b-e))/4;
s2 = sqrt((c+d+e)*(-c+d+e)*(c-d+e)*(c+d-e))/4;
s = s1+s2;
