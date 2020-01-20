function direction = bran_direction(startbran)
x = startbran(:,1:3);
y = startbran(:,4:6);
direction = x-y;
%direction = direction/norm(direction(:));
for i = 1:size(direction,1)
    direction(i,:) = direction(i,:)/norm(direction(i,:));
end