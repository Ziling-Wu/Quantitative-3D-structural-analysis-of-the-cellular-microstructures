function temp = chain(n,connect,temp,branOrien,datas)
nextnode = connected_node(n,connect);
[x1,y1,z1] =  ind2sub(datas,n);
[x2,y2,z2] =  ind2sub(datas,nextnode);
% loc1 = (z2>z1); 
loc1 = (x2>x1); 
% loc2 = abs(atand(sqrt((y2-y1).^2+(z2-z1).^2)./(abs(x2-x1))))<=50;
clear branId
for i = 1:length(nextnode)
    branId(i) = findbran(n,nextnode(i),connect);
end
loc2 = branOrien(branId)<=60;
CF = nextnode(loc1&loc2);
if ~isempty(CF)
   for j = 1:length(CF)
       temp = [temp;n];
       temp = chain(CF(j),connect,temp,branOrien,datas);
   end
   return
else
    temp = [temp;n];
    temp = [temp;0];
    return
end