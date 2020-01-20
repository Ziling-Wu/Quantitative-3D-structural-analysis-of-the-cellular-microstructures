function s = ringSize_6E(ringdots)
A = ringdots(1,:);
B = ringdots(2,:);
C = ringdots(3,:);
D = ringdots(4,:);
E = ringdots(5,:);
F = ringdots(6,:);

a = vecdist(A,B);
b = vecdist(B,C);
c = vecdist(C,D);
d = vecdist(D,E);
e = vecdist(E,F);
f = vecdist(A,F);
g = vecdist(A,C);
h = vecdist(A,D);
i = vecdist(A,E);


s1 = sqrt((a+b+g)*(-a+b+g)*(a-b+g)*(a+b-g))/4;
s2 = sqrt((g+h+c)*(-g+h+c)*(g-h+c)*(g+h-c))/4;
s3 = sqrt((h+i+d)*(-h+i+d)*(h-i+d)*(h+i-d))/4;
s4 = sqrt((f+i+e)*(-f+i+e)*(f-i+e)*(f+i-e))/4;
s = s1+s2+s3+s4;