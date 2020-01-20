function NearNodeId = findNearNode(ind,D,nodeClusterId,dist)
for i = 1:length(ind)
    newInd = find((D(ind(i),:)<=dist)&(D(ind(i),:)>0));%find nearby points
    NearNodeId = setdiff(newInd,nodeClusterId);
end