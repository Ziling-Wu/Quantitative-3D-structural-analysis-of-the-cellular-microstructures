function [trimskel]= branch_trim(node, skel)

datas = size(skel);

trimskel = zeros(datas);

skel(ind2sub(datas,node(:,1)))=0;
BW = bwlabeln(skel,26);

for iter = 1:max(BW(:))
    clear corbran
    %sort the voxels for each branch
    corbran = find(BW == iter);
    % identify the starting and ending points and its connected nodes
     indexend = 1;
     if size(corbran,1)>1
        for k = 1:size(corbran,1) %for all voxels on this branch
            n = neighbor(corbran(k),datas);
            numin = sum(double(ismember(n,corbran)));
            if numin == 2 %start or end point (neighbor includes self) 
               temp=(double(ismember(n,node(:,1))));
               if sum(temp)==1 %connected to one and only one node
                  %trimskel(ind2sub(datas,corbran(k)))=1;  % save the end point no matter what
                  indexend=indexend+1;
               end
            end
        end
     else
         n=neighbor(corbran(1),datas);      
         temp=(double(ismember(n,node(:,1))));
         if sum(temp)==2 % save single voxel branch connected to two nodes
            indexend=3;
         end
     end
         

    if indexend==3 %  two ends that are connected to one and only one node
        trimskel(corbran)=1;       
    end
end
trimskel(node(:,1))=1;
end