%% TG Footscray Melbourne, 31-10-2019
% Reading data from Excel file and finding min Predator Trajectory

clear all; close all
cd D:\Matlab\Warren\;
% Save Data
dispypd_u_hm = [];
dispynfh_umin_m = [];
dispynfh_umax_m = [];
dispynfh_u_3st_m = [];
dispynfh_u_rnd_m = [];
% Load Points from Hex Grid Generator (70,40)
% last_X = 70;
% last_Y = 40;

% Plot Hex Grid Trajectories
[hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out] = Hex_grid_generator_01(70,40);
% Stop plot of Grid
close all;
%
cntr_grid = vertcat([x_mid_in y_mid_in],[x_mid_out,y_mid_out]);
%hold on;
%p = plot(cntr_grid(:,1),cntr_grid(:,2),'.k');
% close all;
%
Cntr_u = cntr_grid;

% Good_files folder has 44 participant good data
% CIIT Data 25_10_2019 - All Files are good.
% CIIT Data 24_10_2019 - All Good.
% Comp_prey_pred_v_2019_03\Comp_prey_pred_v_2019_03 - All Good 
% Not Included in Good Folder CIIT_Data_PreyPred\Data1 - 5,7,9,11,13,15,19,27,35 (dinfo No. format files) 
for dr = 4
    if dr == 1
        cd D:\Matlab\Warren\CIIT_Data_PreyPred\CIIT_Data_25_10_2019\Data\;
    elseif dr == 2
        cd D:\Matlab\Warren\CIIT_Data_PreyPred\CIIT_Data_24_10_2019\Data\;    
    elseif dr == 3
        cd D:\Matlab\Warren\CIIT_Data_PreyPred\Data1\Data1\;
    elseif dr == 4
        cd D:\Matlab\Warren\Comp_prey_pred_v_2019_03\Comp_prey_pred_v_2019_03\;
    elseif dr == 5
        cd D:\Matlab\Warren\CIIT_Data_PreyPred\Good_files\;
    end

dinfo = dir('*.mat');
for K = 1 : 2 : length(dinfo)
  thisfile = dinfo(K).name;
  % Load Predator
  load(thisfile);
  % Match the Prey File
  newStr = strrep(dinfo(K).name,'_pred_','_prey_');
  % Load Prey
  load(newStr); 
  %Prey 
  py_u_hx = px1; py_u_hy = py1;
  %Pred 
  pd_u_hx = pdx1; pd_u_hy = pdy1;
  % Check the Length of Prey and Pred
  lpd = length(pdx1);lpr = length(px1);
  if (lpd > lpr)
      dif = lpd-lpr;
      pd_u_hx = pd_u_hx(dif+1:end);
      pd_u_hy = pd_u_hy(dif+1:end);
  elseif (lpr > lpd)
      dif = lpr-lpd;
      py_u_hx = py_u_hx(dif+1:end);
      py_u_hy = py_u_hy(dif+1:end);
  end
%   A = [py_u_hx,py_u_hy]; B = [pd_u_hx,pd_u_hy];
%  [ii,jj]=find(A==B);
%  

%   plot(ii, jj,'ok','LineWidth',4);
%   p1 = plot(py_u_hx, py_u_hy,'-ob','LineWidth',1.5);
%   p2 = plot(pd_u_hx,pd_u_hy,'-or','LineWidth',1.5);
%   legend([p,p1,p2],'Center','Prey','Predator');

% Measuring Distances Between Strategies

% Put All matrices into column Space
if (iscolumn(py_u_hx)) == 0
   py_u_hx = py_u_hx';
end
if (iscolumn(py_u_hy)) == 0
   py_u_hy = py_u_hy';
end
if (iscolumn(pd_u_hx)) == 0
   pd_u_hx = pd_u_hx';
end
if (iscolumn(pd_u_hy)) == 0
   pd_u_hy = pd_u_hy';
end


% Distances between Human Prey and Predator i.e Distance Formula; sqrt( (x2-x1)^2 + (y2-y1)^2) 
  % dispypd_p_h
    dispypd_u_h = sqrt((py_u_hx - pd_u_hx).^2 + (py_u_hy - pd_u_hy).^2);
%     figure;
%     plot(dispypd_u_h,'-r','LineWidth',1.5);
    dispypd_u_h = round(dispypd_u_h,3,'significant');
    dis_u_hm = mean(dispypd_u_h);
    dispypd_u_hm = [dispypd_u_hm ; dis_u_hm];
    %
%     ln = length(pd_u_hy);
    % Predator Keeping Minimum Distance
    [pd_u_minx, pd_u_miny]  =   Game_pred_model_min_prey(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
    
%     % Prey Keeping Max Distance
    [prey_a_X, prey_a_Y]    =   Game_prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
%     plot(prey_a_X,prey_a_Y,'-om','LineWidth',2);

%     % Prey 3Startegy
    safe_dist = 1;
    [prey_a_X3, prey_a_Y3] = Game_prey_model_3strategy_biased(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u,safe_dist);
%      plot(prey_a_X3,prey_a_Y3,'-ok','LineWidth',2);

%    % Prey Making Protean Motion
    [prey_a_Rndx, prey_a_Rndy] = prey_model_random_01_pred(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);

%      legend('Hex Points','Prey','Predator');
    % Min Model
    dispynfh_umin = sqrt((pd_u_minx(2:end) - pd_u_hx).^2 + (pd_u_miny(2:end) - pd_u_hy).^2);
    dispynfh_umin = round(dispynfh_umin,3,'significant');
    dis_umin_m = mean(dispynfh_umin);
    dispynfh_umin_m = [dispynfh_umin_m;dis_umin_m];
    %
    % Max Model
    dispynfh_u_max = sqrt((prey_a_X(2:end) - pd_u_hx).^2 + (prey_a_Y(2:end) - pd_u_hy).^2);
    dispynfh_u_max = round(dispynfh_u_max,3,'significant');
    dis_umax_m = mean(dispynfh_u_max);
    dispynfh_umax_m = [dispynfh_umax_m;dis_umax_m];
    %
    % 3Strategy Model
    dispynfh_u_3st = sqrt((prey_a_X3(2:end) - pd_u_hx).^2 + (prey_a_Y3(2:end) - pd_u_hy).^2);
    dispynfh_u_3st = round(dispynfh_u_3st,3,'significant');
    dis_u_3st_m = mean(dispynfh_u_3st);
    dispynfh_u_3st_m = [dispynfh_u_3st_m ; dis_u_3st_m];
    
    % Random Model
    dispynfh_u_rnd = sqrt((prey_a_Rndx(2:end) - pd_u_hx).^2 + (prey_a_Rndy(2:end) - pd_u_hy).^2);
    dispynfh_u_rnd = round(dispynfh_u_rnd,3,'significant');
    dis_u_rnd_m = mean(dispynfh_u_rnd);
    dispynfh_u_rnd_m = [dispynfh_u_rnd_m ; dis_u_rnd_m];
    
end
end   
figure;
plot(dispynfh_umin_m,'-.r','LineWidth',1.5);
hold on;
plot(dispynfh_u_rnd_m,'-.g','LineWidth',1.5);
plot(dispynfh_umax_m,'-.b','LineWidth',1.5);
plot(dispynfh_u_3st_m,'-.k','LineWidth',1.5);
legend('Min Dist','Rand Dist','Max Dist','Hybrid');
%%
%%
T0 = [dispynfh_umin_m dispynfh_u_rnd_m dispynfh_umax_m dispynfh_u_3st_m];
%
figure;
y1 = T0(:,1);
y2 = T0(:,2);
y3 = T0(:,3);
y4 = T0(:,4);
e1 = std(y1);
e2 = std(y2);
e3 = std(y3);
e4 = std(y4);

x1 = 1:1:length(T0);

subplot(2,2,1)
[l1,p1] = boundedline(x1, y1, e1, '-r*','alpha');
outlinebounds(l1,p1);
axis([1 44 0 50]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Minimum Model')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,2)
[l2,p2] = boundedline(x1, y2, e2, '-k*','alpha');
outlinebounds(l2,p2);
axis([1 44 0 70]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Random Model')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,3)
[l3,p3] = boundedline(x1, y3, e3, '-b*','alpha');
outlinebounds(l3,p3);
axis([1 44 0 50]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Max Model')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,4)
[l4,p4] = boundedline(x1, y4, e4, '-m*','alpha');
outlinebounds(l4,p4);
axis([1 44 0 50]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Hybrid Model')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');

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
% bp = boxplot(dist_pp,'Notch','on','Labels',{'P','S','R','U'},'Whisker',1,'Widths',0.5,'Colors','rkbm', ...
%         'BoxStyle','outline');
% set(bp,{'linew'},{1.5})    
figure;
CategoricalScatterplot(T0,'Labels',{'Min','Rand','Max','Hybrid'},'MarkerSize',15,'Marker','.',...
'MedianColor','r','WhiskerColor','k','BoxColor',[0.7 0.7 0.7],'BoxLineStyle','-',...'BoxEdgeColor',[0.5 0.5 0.5],...
'WhiskerLineWidth',0.1,'BoxLineWidth',1.5,'BoxAlpha',0.5,'MedianLineWidth',2);
set(gca,'FontName','Helvetica','FontSize',10,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','off','YMinorTick','off', ...
    'YGrid','off','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% legend('x','y','z','zz');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10)
title('Statistics for All Conditions');
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
%%
% for file = [1]
% 
%        
%       
% %Prey 
% py_u_hx = px1; py_u_hy = py1;
% 
% %Pred 
% pd_u_hx = pdx1; pd_u_hy = pdy1;
%     
% 
% % %% Distances between Human Prey and Predator i.e Distance Formula; sqrt( (x2-x1)^2 + (y2-y1)^2) 
% % %dispypd_p_h
% dispypd_u_h = sqrt((py_u_hx - pd_u_hx).^2 + (py_u_hy - pd_u_hy).^2);
% dispypd_u_h = round(dispypd_u_h,3,'significant');
% dispypd_u_hm = mean(dispypd_u_h);
% % %
% ln = length(pd_u_hy);
% [pd_u_minx, pd_u_miny]  =   Game_pred_model_min_prey(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% [prey_a_X, prey_a_Y]    =   Game_prey_model_max_pred_endpy(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
% [prey_a_3X, prey_a_3Y,b1,b2,b3,b4,b5,b6,b7,b8,b9] = Game_prey_model_3strategy_biased(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u,1);
% %
% %% Distance between Predator Model and Predator
% % Min Model
% dispynfh_u = sqrt((pd_u_minx(2:end) - pd_u_hx).^2 + (pd_u_miny(2:end) - pd_u_hy).^2);
% dispynfh_u = round(dispynfh_u,3,'significant');
% dispynfh_um = mean(dispynfh_u);
% %
% % Max Model
% dispynfh_u_max = sqrt((prey_a_X(2:end) - pd_u_hx).^2 + (prey_a_Y(2:end) - pd_u_hy).^2);
% dispynfh_u_max = round(dispynfh_u_max,3,'significant');
% dispynfh_umax_mean = mean(dispynfh_u_max);
% %
%  hold on;
%  plot(py_u_hx, py_u_hy,'.-b','LineWidth',1.5);
%  plot(pd_u_hx,pd_u_hy,'.-r','LineWidth',1.5);
%  plot(pd_u_minx, pd_u_miny,'.-k','LineWidth',1.5);
%  plot(prey_a_X, prey_a_Y,'.-g','LineWidth',1.5);
%  
% end
% 
% %% Plotting Data
% figure;
% hold on;
% plot([1:size(dispynfh_u)],dispynfh_u,'.-k');
% plot([1:size(dispynfh_u_max)],dispynfh_u_max,'.-b');
% plot([1:size(dispypd_u_h)],dispypd_u_h(1:size(dispypd_u_h)),'.-r');
% 

%% For Warren's Specific Format

% Participants = [1,2,4:20,26:40];
% 
% xlswrite(filename,Participants','P41','A2:A35');
% xlswrite(filename,dispypd_p_hm','P41','B2:B35');
% xlswrite(filename,dispypd_s_hm','P41','C2:C35');
% xlswrite(filename,dispypd_r_hm','P41','D2:D35');
% xlswrite(filename,dispypd_u_hm','P41','E2:E35');
% 
% xlswrite(filename,dispynfh_pm','P41','F2:F35');
% xlswrite(filename,dispynfh_sm','P41','G2:G35');
% xlswrite(filename,dispynfh_rm','P41','H2:H35');
% xlswrite(filename,dispynfh_um','P41','I2:I35');



