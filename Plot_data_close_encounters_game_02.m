%% Plotting Close Encounter Data - 16-03-2021 PC, Melb.

close all; clc; clear;

%% Close Encounter Trajectories Data
dist_pp_max_endpy = []; % Distance between Human Prey and Biased Max Model
dist_pp_3strategy = []; % Distance between Human Prey and 3strategy Max Model

load('D:\Matlab\Warren\1_U_1_pred_2021_3_16_20_9_54.mat');
load('D:\Matlab\Warren\1_U_1_prey_2021_3_16_20_9_54.mat');

% load('D:\Matlab\Warren\CIIT_Data_PreyPred\Good_files\11_U_1_pred_2019_10_24_14_17_58.mat');
% load('D:\Matlab\Warren\CIIT_Data_PreyPred\Good_files\11_U_1_prey_2019_10_24_14_17_58.mat');

% Start The Loop for Prey-Pred Filename Matching

[hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out,hex_px,hex_py] = Hex_grid_generator_01(60,30);

cntr_x = vertcat(x_mid_in,x_mid_out);
cntr_y = vertcat(y_mid_in,y_mid_out);
Cntr_u = [cntr_x cntr_y]; 
%
% Pred and Prey Traj Coords
py_u_hx = px1;py_u_hy = py1;
pd_u_hx = pdx1; pd_u_hy = pdy1;


% close all;
%
lp = [14,12];
[lp1,lp2] = associate_grid(lp(1),lp(2),Cntr_u);
lp12 = [lp1,lp2];
% Max Model
[py_u_hybrid_x,py_u_hybrid_y] = Game_prey_model_hybrid_right_01(pd_u_hx,pd_u_hy,py_u_hx,py_u_hy,Cntr_u,lp12);
% Random Model
[py_u_rnd_x, py_u_rnd_y] = Game_prey_model_random(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% %% Distance between Prey Max Model Endpy (Last Point is Prey's)
dispynmaxepymod_u = sqrt((py_u_hybrid_x - py_u_hx).^2 + (py_u_hybrid_y - py_u_hy).^2);
dispynmaxepymod_u = round(dispynmaxepymod_u,3,'significant');
dist_pp_max_endpy = [dist_pp_max_endpy; mean(dispynmaxepymod_u)];
% %
% 
% imshow(Iu);
hold on;
plot(Cntr_u(:,1),Cntr_u(:,2),'.c');
p1 = plot(pd_u_hx,pd_u_hy,'-or','LineWidth',1.5);
p2 = plot(py_u_hx,py_u_hy,'-ob','LineWidth',1.5);
% % Random
p3 = plot(py_u_rnd_x,py_u_rnd_y,'-ok');
% Max
% p4 = plot(py_u_max_endpy_x,py_u_max_endpy_y,'-ok','LineWidth',1.5);
% % Hybrid
p4 = plot(py_u_hybrid_x,py_u_hybrid_y,'-om','LineWidth',1.5);
% %
legend([p1,p2,p3,p4],'Pred','Prey','Rand','Max','Location','Best');

%figure;
% plot(dist_pp_3strategy,'-or','LineWidth',2);
%hold on;
%plot(dist_pp_max_endpy,'-og','LineWidth',2);
%%
%save('37.mat','py_u_hx','py_u_hy','pd_u_hx','pd_u_hy','Cntr_u');