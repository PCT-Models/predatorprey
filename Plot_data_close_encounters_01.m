%% Plotting Close Encounter Data - 16-03-2021 PC, Melb.

close all; clc; clear;

%% Close Encounter Trajectories Data
dist_pp_max_endpy = []; % Distance between Human Prey and Biased Max Model
dist_pp_3strategy = []; % Distance between Human Prey and 3strategy Max Model
st_enc = 13;
end_enc = 40;

for files = [9]
load(sprintf('Calib_Images/%d_u.mat',files));    
%  for files = [1,2,4:20,26:40]
% Read Calibration File
calib_file_u = horzcat('Calib_files_new/',num2str(files),'_u.mat');
%
% Read Trajectory Files
% Read Pred Trajectory File
pred_file_u = horzcat('Traj_files/Mat_files/',num2str(files),'_u_pred.mat');
% Read Prey Trajectory File
prey_file_u = horzcat('Traj_files/Mat_files/',num2str(files),'_u_prey.mat');

% Load All Files
% Load Calibration Files (without 700 minus)
Ctr_u = load(calib_file_u);
% Now minusing 700
Cntr_u = [Ctr_u.x (Ctr_u.y)];
%
% Load Predator Prey Trajectory Files (without 700 minus)
load(pred_file_u); load(prey_file_u);
% % Separate all Points in Pred and Prey Traj according to Chimes
[chimes_1_u,T6i,T7i] = intersect(T6(:,1),T7(:,1));
% % Determining the Range from 'u' chimes
chime = length(chimes_1_u);
% Since the first row will be headings, hence start from the second row
chime = chime + 1;
% Data Points of Prey and Predator (x and y) conversion mainly in Y-axis
% Point Conversion Constants can be changed according to the board size
b = 700;
% Since Chimes are same across Participants. Hence, 'u' is taken, the
% smallest time.
A = chimes_1_u;
m1 = 1; n1 = 0; m = 1; n = 0;
%
% %Prey P,S,R,U (x and y) Respectively
py_u_hx = T7(T7i,2); py_u_hy =  T7(T7i,3);
% %
% %Pred P,S,R,U (x and y) Respectively
pd_u_hx = T6(T6i,2); pd_u_hy =  T6(T6i,3);
% %
% %
py_u_hx = py_u_hx(st_enc:end_enc);
py_u_hy = py_u_hy(st_enc:end_enc);

pd_u_hx = pd_u_hx(st_enc:end_enc);
pd_u_hy = pd_u_hy(st_enc:end_enc);

% [hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out,hex_px,hex_py] = Hex_grid_generator_01(40,40);
% 
% cntr_x = vertcat(x_mid_in,x_mid_out);
% cntr_y = vertcat(y_mid_in,y_mid_out);
% Cntr_u = [cntr_x cntr_y]; 
%
% py_u_hx = px1;
% py_u_hy = py1;
% 
% pd_u_hx = pdx1;
% pd_u_hy = pdy1;
%
% %% Distance between Prey and Predator Humans
% dis_u = sqrt((py_u_hx - pd_u_hx).^2 + (py_u_hy - pd_u_hy).^2);
% dis_u = round(dis_u,3,'significant'); dis = [dis; mean(dis_u)];
% %% Predator Model Minimum Prey Position (pd_psru_min_xy)
% [pd_u_minx, pd_u_miny] = pred_model_min_prey(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);  
% % Distance between Predator Model and Predator
% dispynfh_u = sqrt((pd_u_minx(2:end) - pd_u_hx).^2 + (pd_u_miny(2:end) - pd_u_hy).^2);
% dispynfh_u = round(dispynfh_u,3,'significant'); dispp = [dispp; mean(dispynfh_u)];
% %% Prey Model Maximum Distance from Predator (Last Point is Predator's)
% % [py_u_max_x, py_u_max_y] = prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% %% Distance between Prey Max Model and Prey (Last Point is Predator's)
% % dispynmaxmod_u = sqrt((py_u_max_x(2:end) - py_u_hx).^2 + (py_u_max_y(2:end) - py_u_hy).^2);
% % dispynmaxmod_u = round(dispynmaxmod_u,3,'significant');
% % dist_pp_max = [dist_pp_max; mean(dispynmaxmod_p(1:A)) mean(dispynmaxmod_s(1:A)) mean(dispynmaxmod_r(1:A)) mean(dispynmaxmod_u(1:A))];
% %% Prey Model Maximum Endpy Distance from Predator (Last Point is Prey's)
[py_u_max_endpy_x, py_u_max_endpy_y] = prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% %% Distance between Prey Max Model Endpy (Last Point is Prey's)
dispynmaxepymod_u = sqrt((py_u_max_endpy_x(2:end) - py_u_hx).^2 + (py_u_max_endpy_y(2:end) - py_u_hy).^2);
dispynmaxepymod_u = round(dispynmaxepymod_u,3,'significant');
dist_pp_max_endpy = [dist_pp_max_endpy; mean(dispynmaxepymod_u)];
% %% Prey Model Biased Maximum Distance from Predator
% [py_u_bmax_x, py_u_bmax_y] = prey_model_biased_max_pred(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% %% Distance between Prey Biased Max Model and Prey
% %dispynbmaxmod_u = sqrt((py_u_bmax_x(2:end) - py_u_hx).^2 + (py_u_bmax_y(2:end) - py_u_hy).^2);
% %dispynbmaxmod_u = round(dispynbmaxmod_u,3,'significant');
% %dist_pp_bmax = [dist_pp_bmax; mean(dispynbmaxmod_p(1:A)) mean(dispynbmaxmod_s(1:A)) mean(dispynbmaxmod_r(1:A)) mean(dispynbmaxmod_u(1:A))];
% %dist_pp_bmax = [dist_pp_bmax; mean(dispynbmaxmod_u(1:A))];
% %% Prey Model Random
[py_u_rnd_x, py_u_rnd_y] = prey_model_random_01_pred(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% % 
% %% Distance between Random Prey Model and Prey
% dispynrndmod_u = sqrt((py_u_rnd_x(2:end) - py_u_hx).^2 + (py_u_rnd_y(2:end) - py_u_hy).^2);
% dispynrndmod_u = round(dispynrndmod_u,3,'significant');
% dist_pp_rnd = [dist_pp_rnd; mean(dispynrndmod_u)];
% %
% %% Prey Model 3Strategy
% For Comp Game its 1 and for Humans its 25
%  safe_dist = 1;
% [py_u_3strategy_x, py_u_3strategy_y] = Game_prey_model_3strategy_biased(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u, safe_dist);
lp = [451,5];
[lp1,lp2] = associate_grid(lp(1),lp(2),Cntr_u);
lp12 = [lp1,lp2];
[py_u_3strategy_x, py_u_3strategy_y] = prey_model_hybrid_right_01(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u, []);
%
% %% Distance between 3strategy Model and Prey
dispyn3strategymod_u = sqrt((py_u_3strategy_x - py_u_hx).^2 + (py_u_3strategy_y - py_u_hy).^2);
dispyn3strategymod_u = round(dispyn3strategymod_u,3,'significant');
dist_pp_3strategy = [dist_pp_3strategy; mean(dispyn3strategymod_u)];
% 
% imshow(Iu);
hold on;
% plot(Cntr_u(:,1),Cntr_u(:,2),'.r');
plot(pd_u_hx,pd_u_hy,'-og');
plot(py_u_hx,py_u_hy,'-ok');
% % Random
plot(py_u_rnd_x,py_u_rnd_y,'-ok');
% Max
plot(py_u_max_endpy_x,py_u_max_endpy_y,'-ob');
% Hybrid
plot(py_u_3strategy_x,py_u_3strategy_y,'-or');
% %
legend('Pred','Prey','Rand','Max','Hybrid','Location','Best');
end

figure;
plot(dist_pp_3strategy,'-or','LineWidth',2);
hold on;
plot(dist_pp_max_endpy,'-ob','LineWidth',2);
% %% 
% %save('37.mat','py_u_hx','py_u_hy','pd_u_hx','pd_u_hy','Cntr_u');
% %
% %% ANOVA1 - TG 03-06-2021
% dist_pp = [dist_pp_3strategy,dist_pp_max_endpy];
% bp = boxplot(dist_pp,'Notch','on','Labels',{'Hybrid','Max'},'Whisker',1,'Widths',0.5,'Colors','rkbm', ...
%         'BoxStyle','outline');
% set(bp,{'linew'},{1.5})    
%
Data_matrix = [pd_u_hx,pd_u_hy,py_u_hx,py_u_hy];