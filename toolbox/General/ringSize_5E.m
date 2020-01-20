function s = ringSize_5E(ringdots)
A = ringdots(1,:);
B = ringdots(2,:);
C = ringdots(3,:);
D = ringdots(4,:);
E = ringdots(5,:);

a = vecdist(A,B);
b = vecdist(B,C);
c = vecdist(C,D);
d = vecdist(D,E);
e = vecdist(A,E);
f = vecdist(A,C);
g = vecdist(A,D);
s1 = sqrt((a+b+f)*(-a+b+f)*(a-b+f)*(a+b-f))/4;
s2 = sqrt((c+f+g)*(-c+f+g)*(c-f+g)*(c+f-g))/4;
s3 = sqrt((g+e+d)*(-g+e+d)*(g-e+d)*(g+e-d))/4;
s = s1+s2+s3;
