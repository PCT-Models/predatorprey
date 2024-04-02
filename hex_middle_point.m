%% Function to Find a Middle Point and Corner Points of a Hexagon
%% TG Footscray, Melbourne, 23-02-18

function [px,py,p_mid,r] = hex_middle_point(F_1,F_2)

%% Function to Generate Hexagoal Points as follows:
% px,py - are the six points at 60,120,210,330

F(:,1) = F_1;
F(:,2) = F_2;

% plot(F(:,1),F(:,2),'.r');

% hold on;

L_max = find(F(:,2) == max(F(:,2)));
L_min = find(F(:,2) == min(F(:,2)));

% % Plot all Points
% plot(F(L_max,1),F(L_max,2),'og');
% plot(F(L_min,1),F(L_min,2),'or');

 % Plot Max and Min Points as a straight Line to Find Centre
 Point_x1 = mean(F(L_max,1));
 Point_y1 = mean(F(L_max,2));
 
 Point_x2 = mean(F(L_min,1));
 Point_y2 = mean(F(L_min,2));
 
%  plot(Point_x1,Point_y1,'ok');
%  plot(Point_x2,Point_y2,'ob');
 
Point_X = (Point_x1+Point_x2)/2;
Point_Y = (Point_y1+Point_y2)/2;

m = F(:,1);
n = F(:,2);

p_mid = [sum(m)/size(m,1) sum(n)/size(n,1)];

% p_mid = [Point_X Point_Y];

% plot(Point_X,Point_Y,'*b');

% Radius of Hexagon
%r = pdist2([Point_X Point_Y],[Point_x1 Point_y1],'euclidean');

r = 20;

% % Algorithm for creating Hexagonal Grid
% width = r * 2;
% horz = width * 3/4;
% vert = width * sqrt(3)/2; 

px = [];
py = [];

for k = [45,90,135,225,270,315]

    px(k) = p_mid(1,1) + r * cosd(k);
    py(k) = p_mid(1,2) + r * sind(k);
    
end

% plot(px,py,'.g'); 
% 
% axis([0 60 0 60]);
end 
 
 







