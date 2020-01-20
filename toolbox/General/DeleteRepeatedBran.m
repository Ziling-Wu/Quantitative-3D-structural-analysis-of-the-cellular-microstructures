function [bran,connect] = DeleteRepeatedBran(c5,b5,ratio)

bran = b5;
connect = c5;
rebran = flip(1:length(b5));
del = [];
for i =1:length(rebran)
    clear id
    now = connect(rebran(i),:);
    id = find((c5(:,1) == now(1)) &(c5(:,2) == now(2)));
    id = [id;find((c5(:,1) == now(2)) &(c5(:,2) == now(1)))];
    if length(id)>1
        if ratio(id(1))<ratio(id(2))
            bran{id(2)}=[];
            del = [del;id(2)];

        else
            bran{id(1)}=[];
            del = [del;id(1)];
        end
    end
end
connect(unique(del),:) = [];
bran(cellfun('length',bran)==0)=[];
% connect = C;