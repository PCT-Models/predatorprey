%% Finding the Distance Between Prey and Predator and Associating Hexagon
%% TG Footscray, Melbourne, 21-02-2018

%% Notes for Calib:(psr_calib)
% P: P1(all good), P2(Tx-4), P3()
%%
clc; close all; clear all;

file = 'S_v_data/P4/par_4_p.MOV';
p = VideoReader(file);
nFrames = p.NumberOfFrames;
% For PSR
RGB = imcrop(read(p,1700),[10 200 1600 300]);

%For U
%RGB = imcrop(read(p,f_no),[55 50 1190 600]);

c_psr = load('calib_psr.mat');
c_u = load('calib_u.mat');

% Let us Load Movie Data
load('1_s_pred.mat');
load('1_s_prey.mat');

n = 700;

% Sort Calibe by Rows (x-axis from 0-1200 approx.)
A_psr = [c_psr.Tx+48 n-c_psr.Ty + 0];
A_u = [c_u.Tx n-c_u.Ty];

A_psr_sort  = sortrows(A_psr,1);
A_u_sort    = sortrows(A_u,1);

% Plot Sorted Centers on Image
imshow(RGB); hold on;
plot(A_psr_sort(1:856,1),A_psr_sort(1:856,2),'.r');

%Pred
% plot(T0(:,2),T0(:,3),'.k');
% plot(T1(:,2),T1(:,3),'.b');

% % Plot start Point of Pred
% base_X = T2(1,2);
% base_Y = T2(1,3);
% 
% % Plot start Point of Prey
% base_X1 = T3(1,2);
% base_Y1 = T3(1,3);
% 
% plot(base_X,base_Y,'ok');
% plot(base_X1,base_Y1,'og');
% 
% % Plot one point next to the Pred Point
% base_pred = rangesearch(A_psr_sort,[base_X base_Y],10);
% 
% hex_pd_X = [];
% hex_pd_Y = [];
% 
%       % Associate to the Hex Grid Point  
% hex_pd_X(1) = A_psr_sort(base_pred{1},1);
% hex_pd_Y(1) = A_psr_sort(base_pred{1},2);
% 
% % Plot first Hexagonal Point
% plot(hex_pd_X,hex_pd_Y,'^b');
% 
% for i = 1:1:60
%     
% [hex_X,hex_Y] = six_hex_points(hex_pd_X(i),hex_pd_Y(i),A_psr_sort);
% 
% plot(hex_X,hex_Y,'ob');
% 
% hex_prey = rangesearch([hex_X' hex_Y'],[T1(i,2),T1(i,3)],200);
% 
% hex_pd_X(i+1) = hex_X(hex_prey{1}(1));
% hex_pd_Y(i+1) = hex_Y(hex_prey{1}(1));
% 
% plot(T1(i,2),T1(i,3),'.r')
% plot(T0(i,2),T0(i,3),'.k')
% plot(hex_pd_X(i+1),hex_pd_Y(i+1),'om','MarkerSize',10);

% pause(0.051);
% 
% end

