%%  
function [hex_X_n,hex_Y_n,x_mid_out_n,y_mid_out_n,x_mid_in_n,y_mid_in_n] = Hex_grid_circular(last_x,last_y,radius)
%% Function to Create Circular Hexagonal Grid
% This Function requires another function available on the Filexchange
%% https://au.mathworks.com/matlabcentral/fileexchange/67680-hex_grid_generator
%                   Hex_grid_generator_01(last_x,last_y)
% Author: Tauseef Gulrez, Melbourne, Australia, 09-06-2018 
% E-mail: gtauseef@ieee.org  
% Behavioral Anatomy of a Hunt - Using Dynamic Real-World Paradigm and Computer Vision
% to Compare Human User-Generated Strategies with Prey Movement Varying in Predictability
% Inputs:
% last_x = last coordinate point on x-axis for last grid in x-direction,
% last_y = last coordinate point on y-axis for last grid in y-direction,
% radius = Radius of a Circular Workspace
% Outputs:
% All the points of new hexagons iside the Circle
% hex_X_n,hex_Y_n - Corner points of hexagons
% x_mid_in_n,y_mid_in_n - Mid (x,y) points inside of Hexagon
% x_mid_out_n,y_mid_out_n - Mid (x,y) points outside of Hexagon
% Example: 
% [hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out] = Hex_grid_circular(20,20,5);
% Copyright (c) 2020, Tauseef Gulrez

% Make sure that last_x and last_y are atleast double of the radius
if (last_x / 2 < radius) && (last_x / 2 < radius)
    disp('Error - last_x and last_y should be atleast double of the radius');
    return;
end
[hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out] = Hex_grid_generator_01(last_x,last_y);

cntr_x = last_x/2;
cntr_y = last_y/2;

%Circle Equation

theta=linspace(0,360);

x_circ = cntr_x + radius * cosd(theta);
y_circ = cntr_y + radius * sind(theta);

hold on;
hex_X_n = []; hex_Y_n = [];x_mid_in_n = [];y_mid_in_n = [];x_mid_out_n=[];y_mid_out_n = [];
for i = 1:1:length(hex_X)
    d_hex = pdist2([hex_X(i,1),hex_Y(i,1)],[cntr_x,cntr_y],'euclidean');
    if min(d_hex) <= radius
        hex_X_n = [hex_X_n hex_X(i,1)];
        hex_Y_n = [hex_Y_n hex_Y(i,1)];
    end
end

for i = 1:1:length(x_mid_in)
    d_mid = pdist2([x_mid_in(i,1),y_mid_in(i,1)],[cntr_x,cntr_y],'euclidean');
    if min(d_mid) <= radius
        x_mid_in_n = [x_mid_in_n x_mid_in(i,1)];
        y_mid_in_n = [y_mid_in_n y_mid_in(i,1)];
    end
end

for i = 1:1:length(x_mid_out)
    d_out = pdist2([x_mid_out(i,1),y_mid_out(i,1)],[cntr_x,cntr_y],'euclidean');
    if min(d_out) <= radius
        x_mid_out_n = [x_mid_out_n x_mid_out(i,1)];
        y_mid_out_n = [y_mid_out_n y_mid_out(i,1)];
    end
end



% 
plot(x_circ,y_circ,'.k');
plot(hex_X,hex_Y,'om','LineWidth',2);
plot(hex_X_n,hex_Y_n,'ob','LineWidth',2);
plot(x_mid_out_n,y_mid_out_n,'ob','LineWidth',2);
plot(x_mid_in_n,y_mid_in_n,'ob','LineWidth',2);
title('Circular Hexagonal Grid');
