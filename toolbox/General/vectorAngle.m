function temp = vectorAngle(oric)
temp(2)=abs(atand(sqrt(oric(2).^2+oric(3).^2)./abs(oric(1))));% phi
for i =1:size(oric,1)
    theta= abs(atan(abs(oric(2))/abs(oric(3))))*180/pi;
    if oric(1)>0
        y = oric(2);
        z = oric(3);
    else
        y = -oric(2);
        z = -oric(3);
    end
    if (y>=0)&&(z>0)
        theta = theta;
    elseif (y>=0)&&(z<=0)
        theta = 180-theta;
    elseif (y<0)&&(z<=0)
        theta = 180+theta;
    else
        theta = 360-theta;
    end
    temp(1) = theta;
end