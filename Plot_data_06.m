% TG 22-Dec 2017 Lahore, Pakistan (started creating file)
% TG 16-Apr 2018 Footscray, Melbbourne, Australia (Making Prey Max Model)
% TG 24-Sep 2018 Footscray, Melbbourne, Australia (Making 3Strategy Model and all data)
% TG 05-Aug 2019 Footscray, Melbbourne, Australia (Calculating Again)
% TG 11-Apr 2020 Footscray, Melbourne, Australia (User defined Only - Cybernetic Evasion)
% TG 20-Jan 2021 Point Cook, Melbourne, Australia (Removed PSR Conditions)
clear all; clc; close all;
tic;
%% Preallocate to save results
dis = []; % Distance between Prey and Predator 
dispp = []; % Distance between Predator Model and Predator
dist_pp_max = []; % Distance between Human Prey and Max Model
dist_pp_rnd = []; % Distance between Human Prey and Random Model
dist_pp_bmax = []; % Distance between Human Prey and Biased Max Model
dist_pp_max_endpy = []; % Distance between Human Prey and Biased Max Model
dist_pp_3strategy = []; % Distance between Human Prey and 3strategy Max Model

% delta = 0;
% global range

% Lock
% 3 is bad, 16, is bad
% Max Prey Model: 7 is bad
% Finding the Anchor Points
% File: 1=ok. 2=(635,463)
% load('D:\Matlab\Warren\Calib_Images\27_u.mat');
% for files = [27]
for files = [1,2,4:20,26:40]
switch(files)
    case 2
        lp = [635,463];
    case 4
        lp = [647,364];
    case 5
        lp = [701,560];
    case 7
        lp = [701,438];
    case 8
        lp = [656,42];
    case 9
        lp = [770,343];
    case 13
        lp = [378,450];
    case 14
        lp = [856,37];
    otherwise
        lp = [];
end
% Read Calibration File
calib_file_u = horzcat('Calib_files_new/',num2str(files),'_u.mat');
%
%% Read Trajectory Files
% Read Pred Trajectory File
pred_file_u = horzcat('Traj_files/Mat_files/',num2str(files),'_u_pred.mat');
% Read Prey Trajectory File
prey_file_u = horzcat('Traj_files/Mat_files/',num2str(files),'_u_prey.mat');

%% Load All Files
% Load Calibration Files (without 700 minus)
Ctr_u = load(calib_file_u);
% Now minusing 700
Cntr_u = [Ctr_u.x 700-(Ctr_u.y)];
%
%% Load Predator Prey Trajectory Files (without 700 minus)
load(pred_file_u); load(prey_file_u);
% % Separate all Points in Pred and Prey Traj according to Chimes
[chimes_1_u,T6i,T7i] = intersect(T6(:,1),T7(:,1));
% % Determining the Range from 'u' chimes
chime = length(chimes_1_u);
% Since the first row will be headings, hence start from the second row
chime = chime + 1;
%% Data Points of Prey and Predator (x and y) conversion mainly in Y-axis
% Point Conversion Constants can be changed according to the board size
b = 700;
% Since Chimes are same across Participants. Hence, 'u' is taken, the
% smallest time.
A = chimes_1_u;
m1 = 1; n1 = 0; m = 1; n = 0;
%
%Prey P,S,R,U (x and y) Respectively
py_u_hx = T7(T7i,2); py_u_hy = b - T7(T7i,3);
%
%Pred P,S,R,U (x and y) Respectively
pd_u_hx = T6(T6i,2); pd_u_hy = b - T6(T6i,3);

%         imshow(Iu);
%         hold on;
%         % plot(Cntr_u(:,1),Cntr_u(:,2),'.r');
%         plot(pd_u_hx,700-pd_u_hy,'-og');
%         plot(py_u_hx,700-py_u_hy,'-ob');
%
%% Distance between Prey and Predator Humans
dis_u = sqrt((py_u_hx - pd_u_hx).^2 + (py_u_hy - pd_u_hy).^2);
dis_u = round(dis_u,3,'significant'); dis = [dis; mean(dis_u)];
%% Predator Model Minimum Prey Position (pd_psru_min_xy)
[pd_u_minx, pd_u_miny] = pred_model_min_prey(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);  
% Distance between Predator Model and Predator
dispynfh_u = sqrt((pd_u_minx(2:end) - pd_u_hx).^2 + (pd_u_miny(2:end) - pd_u_hy).^2);
dispynfh_u = round(dispynfh_u,3,'significant'); dispp = [dispp; mean(dispynfh_u)];
%% Prey Model Maximum Distance from Predator (Last Point is Predator's)
% [py_u_max_x, py_u_max_y] = prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
%% Distance between Prey Max Model and Prey (Last Point is Predator's)
% dispynmaxmod_u = sqrt((py_u_max_x(2:end) - py_u_hx).^2 + (py_u_max_y(2:end) - py_u_hy).^2);
% dispynmaxmod_u = round(dispynmaxmod_u,3,'significant');
% dist_pp_max = [dist_pp_max; mean(dispynmaxmod_p(1:A)) mean(dispynmaxmod_s(1:A)) mean(dispynmaxmod_r(1:A)) mean(dispynmaxmod_u(1:A))];
%% Prey Model Maximum Endpy Distance from Predator (Last Point is Prey's)
% [py_u_max_endpy_x, py_u_max_endpy_y] = prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
[py_u_max_endpy_x, py_u_max_endpy_y] = prey_model_min_right_01(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u,lp);
%% Distance between Prey Max Model Endpy (Last Point is Prey's)
dispynmaxepymod_u = sqrt((py_u_max_endpy_x(1:end) - py_u_hx).^2 + (py_u_max_endpy_y(1:end) - py_u_hy).^2);
dispynmaxepymod_u = round(dispynmaxepymod_u,3,'significant');
dist_pp_max_endpy = [dist_pp_max_endpy; mean(dispynmaxepymod_u)];
%% Prey Model Biased Maximum Distance from Predator
% [py_u_bmax_x, py_u_bmax_y] = prey_model_biased_max_pred(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
%% Distance between Prey Biased Max Model and Prey
%dispynbmaxmod_u = sqrt((py_u_bmax_x(2:end) - py_u_hx).^2 + (py_u_bmax_y(2:end) - py_u_hy).^2);
%dispynbmaxmod_u = round(dispynbmaxmod_u,3,'significant');
%dist_pp_bmax = [dist_pp_bmax; mean(dispynbmaxmod_p(1:A)) mean(dispynbmaxmod_s(1:A)) mean(dispynbmaxmod_r(1:A)) mean(dispynbmaxmod_u(1:A))];
%dist_pp_bmax = [dist_pp_bmax; mean(dispynbmaxmod_u(1:A))];
%% Prey Model Random
[py_u_rnd_x, py_u_rnd_y] = prey_model_random_01_pred(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% 
%% Distance between Random Prey Model and Prey
dispynrndmod_u = sqrt((py_u_rnd_x(2:end) - py_u_hx).^2 + (py_u_rnd_y(2:end) - py_u_hy).^2);
dispynrndmod_u = round(dispynrndmod_u,3,'significant');
dist_pp_rnd = [dist_pp_rnd; mean(dispynrndmod_u)];
%
%% Prey Model 3Strategy
 safe_dist = 25;
[py_u_3strategy_x, py_u_3strategy_y] = prey_model_3strategy_biased(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u, safe_dist);
% 
%% Distance between 3strategy Model and Prey
dispyn3strategymod_u = sqrt((py_u_3strategy_x(2:end) - py_u_hx).^2 + (py_u_3strategy_y(2:end) - py_u_hy).^2);
dispyn3strategymod_u = round(dispyn3strategymod_u,3,'significant');
dist_pp_3strategy = [dist_pp_3strategy; mean(dispyn3strategymod_u)];
% 
% imshow(Iu);
% hold on;
% % plot(Cntr_u(:,1),Cntr_u(:,2),'.r');
% plot(pd_u_hx,700-pd_u_hy,'-og');
% plot(py_u_hx,700-py_u_hy,'-ob');
% % Random
% plot(py_u_rnd_x,700-py_u_rnd_y,'-ok');
% % Max
% plot(py_u_max_endpy_x,700-py_u_max_endpy_y,'-or');
% Hybrid
%plot(py_u_3strategy_x,700-py_u_3strategy_y,'-oc');
%
%legend('Pred','Prey','Rand','Max','Location','Best');
end
%% Plot All Distances
figure;
plot(dist_pp_max_endpy,'-ob','Linewidth',1);
hold on;
plot(dist_pp_rnd,'-ok','Linewidth',1);
plot(dist_pp_3strategy,'-or','Linewidth',1);
legend('Max Prey','Rnd Prey','Location','Best');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
title('Prey Models Fit to Human Prey');
grid on;
%%
% disp(dist_pp);
% Show Image and Plot Trajectories for P, S and R
% figure('Renderer', 'painters', 'Position', [10 10 1100 250])
% imshow(Ip);
%hold on;
% plot(Ctr_p.x,Ctr_p.y,'.g');
% plot(pd_p_hx,700-pd_p_hy,'.-k');hold on;plot(py_p_hx,700-py_p_hy,'.-r');
% axis([0 1000 0 350]);
% %
% figure('Renderer', 'painters', 'Position', [10 10 1100 250])
% % imshow(Is);
% hold on;
% plot(Ctr_s.x,Ctr_s.y,'.g');
% plot(pd_s_hx,700-pd_s_hy,'.-k');hold on;plot(py_s_hx,700-py_s_hy,'.-r');
% axis([0 1000 0 350]);
%
% figure('Renderer', 'painters', 'Position', [10 10 1100 250])
% imshow(Ir);
% hold on;
% plot(Ctr_r.x,Ctr_r.y,'.g');
% plot(pd_r_hx,700-pd_r_hy,'.-k');hold on;plot(py_r_hx,700-py_r_hy,'.-r');
% axis([0 1000 0 350]);
%
% figure('Renderer', 'painters', 'Position', [10 10 1100 250])
% imshow(Iu);
% C_x = Ctr_u.x(~isnan(Ctr_u.x));
% C_y = Ctr_u.y(~isnan(Ctr_u.y));
% C = [C_x,700-C_y];
% py_u_hx11 = [];py_u_hy11 = [];pd_u_hx11 = [];pd_u_hy11 = [];
% for i = 1:1:length(py_u_hx)
% [py_u_hx1,py_u_hy1] = associate_grid(py_u_hx(i),py_u_hy(i),C);
% [pd_u_hx1,pd_u_hy1] = associate_grid(pd_u_hx(i),pd_u_hy(i),C);
% 
% py_u_hx11 = [py_u_hx11,py_u_hx1];
% py_u_hy11 = [py_u_hy11,py_u_hy1];
% 
% pd_u_hx11 = [pd_u_hx11,pd_u_hx1];
% pd_u_hy11 = [pd_u_hy11,pd_u_hy1];
% 
% end
% hold on;
% plot(C_x,C_y,'.g');
% plot(pd_u_hx,700-pd_u_hy,'o-k','LineWidth',1.5);hold on;plot(py_u_hx,700-py_u_hy,'o-r','LineWidth',1.5);
% %plot(pd_u_hx11',700-pd_u_hy11','.-b','LineWidth',1.5);plot(py_u_hx11',700-py_u_hy11','.-m','LineWidth',1.5);
% legend('Center Points','Predator','Prey','Location','Best');
% axis([0 1200 0 350]);


%% Plot Bars
% % T0 = [dispp dist_pp_rnd dist_pp_max_endpy dist_pp_3strategy];
% T0 = [dist_pp_rnd dist_pp_max_endpy dist_pp_3strategy];
% figure;
% y1 = T0(:,1);
% y2 = T0(:,2);
% y3 = T0(:,3);
% % y4 = T0(:,4);
% e1 = std(y1);
% e2 = std(y2);
% e3 = std(y3);
% % e4 = std(y4);
% 
% x1 = 1:1:length(T0);
% 
% subplot(2,1,1)
% [l1,p1] = boundedline(x1, y1, e1, '-r*','alpha');
% outlinebounds(l1,p1);
% axis([1 34 0 600]);
% set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
%     'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% title('Random Model');
% ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
% xlabel('Trial No.','FontName','Helvetica','FontSize',10);
% legend('95% Conf.','Est. value');
% %
% subplot(2,2,3)
% [l3,p3] = boundedline(x1, y2, e2, '-b*','alpha');
% outlinebounds(l3,p3);
% axis([1 34 0 600]);
% set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
%     'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% title('Max Model')
% ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
% xlabel('Trial No.','FontName','Helvetica','FontSize',10);
% legend('95% Conf.','Est. value');
% %
% subplot(2,2,4)
% [l4,p4] = boundedline(x1, y3, e3, '-m*','alpha');
% outlinebounds(l4,p4);
% axis([1 34 0 600]);
% set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
%     'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% title('Hybrid')
% ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
% xlabel('Trial No.','FontName','Helvetica','FontSize',10);
% legend('95% Conf.','Est. value');

% grid on; box off;
% xlabel('time [s]','FontName','Helvetica','FontSize',30);
% ylabel('[a.u.]','FontName','Helvetica','FontSize',30);
% legend('Estimated value','95% confidence boundaries');
%% ANOVA1 - TG 05-08-2019
% bp = boxplot(dist_pp,'Notch','on','Labels',{'P','S','R','U'},'Whisker',1,'Widths',0.5,'Colors','rkbm', ...
%         'BoxStyle','outline');
% set(bp,{'linew'},{1.5})    
%
%% ANOVA1 - TG 05-08-2019
% % bp = boxplot(dist_pp,'Notch','on','Labels',{'P','S','R','U'},'Whisker',1,'Widths',0.5,'Colors','rkbm', ...
% %         'BoxStyle','outline');
% % set(bp,{'linew'},{1.5})    
% figure;
% CategoricalScatterplot(T0,'Labels',{'Rand','Max','Hybrid'},'MarkerSize',15,'Marker','.',...
% 'MedianColor','r','WhiskerColor','k','BoxColor',[0.7 0.7 0.7],'BoxLineStyle','-',...'BoxEdgeColor',[0.5 0.5 0.5],...
% 'WhiskerLineWidth',0.1,'BoxLineWidth',1.5,'BoxAlpha',0.5,'MedianLineWidth',2);
% set(gca,'FontName','Helvetica','FontSize',10,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','off','YMinorTick','off', ...
%     'YGrid','off','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% % legend('x','y','z','zz');
% ylabel('Mean Distance','FontName','Helvetica','FontSize',10)
% title('Statistics for All Conditions');
%% T-Test Bonferroni
% [p,~,stats] = anova1(dist_pp);
% [results,means] = multcompare(stats,'CType','bonferroni');
% %% More Stats
% data = vertcat(dist_pp(:,1),dist_pp(:,2),dist_pp(:,3),dist_pp(:,4));
% id1 = {};id2 = {};id3 = {};id4 = {};
% for i = 1:1:4
%     
%     for k = 1:1:34
%         if i == 1
%         id1{k} = sprintf('A1');
%         elseif i == 2
%         id2{k} = sprintf('A2');
%         elseif i == 3
%         id3{k} = sprintf('A3');
%         elseif i == 4
%         id4{k} = sprintf('A4');
%         end
%      end
%         
% end
% idc = vertcat(id1',id2',id3',id4');
toc;
% %% Angles of Prey Escape
% for i = 1:1:360
%     j = [0];
%     hold on;
% esc_head = i; pos = j; k =1;
% d = ((sind(esc_head - pos) + k * sind(pos)).^2) /  (k^2 + 2*k*cosd(esc_head) + 1);
% plot(i,d,'.r');
% end


