%% Finding Six Points on Grid Around Any Hexagonal Point
%% TG Footscray, Melbourne, 21-02-2018

function [hex_X,hex_Y] = Game_three_fwd_hex_points(point_X,point_Y,C)

dd = 2;
hex_X = [];
hex_Y = [];
k = 0;

%  for i = [45,90,135,225,270,315]
 for i = [45,270,315]
    k = k+1;
hex_01_x = dd * cosd(i);
hex_01_y = dd * sind(i);
h_x = point_X + hex_01_x;
h_y = point_Y + hex_01_y;
hex_pred = rangesearch(C,[h_x(1) h_y(1)],40);
hex_X(k) = C(hex_pred{1}(1),1);
hex_Y(k) = C(hex_pred{1}(1),2);

end

end