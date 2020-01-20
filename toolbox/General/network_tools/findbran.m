function i=findbran(n1,n2,ce)

% this function finds the index of branch i in the connect matrix ce that
% connects node n1 and n2. 

a=find(ce(:,1)==n1);
b=find(ce(:,1)==n2);

i=[a(ce(a,2)==n2),b(ce(b,2)==n1)];
i=i(1);

end 