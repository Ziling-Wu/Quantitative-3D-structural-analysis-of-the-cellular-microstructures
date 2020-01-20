function s = ringSize_7E(ringdots)
A = ringdots(1,:);
B = ringdots(2,:);
C = ringdots(3,:);
D = ringdots(4,:);
E = ringdots(5,:);
F = ringdots(6,:);
G = ringdots(7,:);

a = vecdist(A,B);
b = vecdist(B,C);
c = vecdist(C,D);
d = vecdist(D,E);
e = vecdist(E,F);
f = vecdist(G,F);
g = vecdist(A,C);
g = vecdist(A,C);
h = vecdist(A,D);
i = vecdist(A,E);
j = vecdist(A,F);
k = vecdist(A,G);

s1 = sqrt((a+b+g)*(-a+b+g)*(a-b+g)*(a+b-g))/4;
s2 = sqrt((g+h+c)*(-g+h+c)*(g-h+c)*(g+h-c))/4;
s3 = sqrt((h+i+d)*(-h+i+d)*(h-i+d)*(h+i-d))/4;
s4 = sqrt((j+i+e)*(-j+i+e)*(j-i+e)*(j+i-e))/4;
s5 = sqrt((j+k+f)*(-j+k+f)*(j-k+f)*(j+k-f))/4;
s = s1+s2+s3+s4+s5;