% =========================================================================
% Sub-Function inside the main function for branch orientation analysis 
% =========================================================================

% calculate branch orientation based on connection info -> branOrien
% the first variable: theta is the angle proejcted to y-z plan; the angle 
% rotated from z direction;
% the second variable: phi is the angle rotated from x direction; 
% Both vairbales are in degrees.

branOrien = zeros(size(connect,1),2); % store branch orientation
for i=1:size(connect,1)
    [y1,x1,z1] = ind2sub(datas,connect(i,1));
    [y2,x2,z2] = ind2sub(datas,connect(i,2));
    [theta,phi,z] = myangle(connect(i,1),connect(i,2),datas);  
    branOrien(i,:) = ([theta,phi]);
end
% polarplot: the first variable should be in radius;
% the second variable should be in degrees
figure
polarplot(deg2rad(branOrien(:,1)),branOrien(:,2),'o');
% saveas(gcf,'branch orientation','epsc');
% saveas(gcf,'branch orientation','pdf');
% saveas(gcf,'branch orientation','png');
%% Finish branch orientation analysis
fprintf('Branch orientation analysis completed! \n')
open 02_main_dataAnalysis