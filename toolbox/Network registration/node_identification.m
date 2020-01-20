function [node] = node_identification(skel)
%get node positions
datas  = size(skel);
skelcor = find(skel);

index = 1;
for iter = 1:size(skelcor)
     n = neighbor(skelcor(iter),datas);
     numin = length(find(skel(n)));
     if numin >= 4 % which should be a node
         node(index,1) =  skelcor(iter);
         node(index,2)=numin-1;
         index = index+1;
     end
end
end