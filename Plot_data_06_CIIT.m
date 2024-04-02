%% Data Plot for Prey Predator CIIT Data - Point Cook 14-03-2021

clear; clc; close all;

% Preallocate to save results
dis = []; % Distance between Prey and Predator 
dispp = []; % Distance between Predator Model and Predator
dist_pp_max = []; % Distance between Human Prey and Max Model
dist_pp_rnd = []; % Distance between Human Prey and Random Model
dist_pp_bmax = []; % Distance between Human Prey and Biased Max Model
dist_pp_max_endpy = []; % Distance between Human Prey and Biased Max Model
dist_pp_3strategy = []; % Distance between Human Prey and 3strategy Max Model

% Load Data
[hex_X,hex_Y,x_mid_in,y_mid_in,x_mid_out,y_mid_out,hex_px,hex_py] = Hex_grid_generator_02(70,60);

cntr_x = vertcat(x_mid_in,x_mid_out);
cntr_y = vertcat(y_mid_in,y_mid_out);
Cntr_u = [cntr_x cntr_y]; 

folder = 'D:\Matlab\Warren\CIIT_Data_PreyPred\Good_files\';
files=dir(fullfile(folder,'*.mat'));

file_name = {};
for i = 1:1:length(files)
file_name{i} = files(i).name;
end

close all;
%% Start The Loop for Prey-Pred Filename Matching
for i = 1:1:numel(file_name)
% 25 is a bad file
% for i = 1
switch(i)
    case 1
        lp = [40.2,32.52];
   case 11
        lp = [44.5,31.65];
   case 21
        lp = [28.6,5.272]; 
   case 53
        lp = [46,22.3];
   case 59
        lp = [32.9,28.25];
   case 69
        lp = [46,8.678];
   case 85
        lp = [32.9,23.14];
    otherwise
        lp = [];
end
h = strfind(file_name{i},'pred');
if h > 0
    % Pred File
    temp_name = file_name{i};
    file_date = temp_name(h+5:end-4);
    s = horzcat('prey_',file_date); 
    p = strfind(file_name,s);
    [~,id] = find(~cellfun(@isempty,p));
    
    load(file_name{i});
    load(file_name{id});

    pd_u_hx = pdx1;  pd_u_hy = pdy1;
    py_u_hx = round(px1,4,'significant');  py_u_hy = round(py1,4,'significant');
    
    % Check the size of Prey and Predator if difference then consider one
    % less
    if (size(pd_u_hx,2) > 1)
        pd_u_hx = pd_u_hx'; 
    end
    if (size(pd_u_hy,2) > 1)
        pd_u_hy = pd_u_hy'; 
    end
    if (size(py_u_hx,2) > 1)
        py_u_hx = py_u_hx'; 
    end
    if (size(py_u_hy,2) > 1)
        py_u_hy = py_u_hy'; 
    end
    
    if (size(pd_u_hx,1) > size(py_u_hx,1))
        pd_u_hx = pd_u_hx(1:end-1);
        pd_u_hy = pd_u_hy(1:end-1);
    elseif (size(pd_u_hx,1) < size(py_u_hx,1))
        py_u_hx = py_u_hx(1:end-1);
        py_u_hy = py_u_hy(1:end-1);
    end
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
[py_u_max_endpy_x, py_u_max_endpy_y] = Game_prey_model_min_right_01(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u,lp);
%% Distance between Prey Max Model Endpy (Last Point is Prey's)
dispynmaxepymod_u = sqrt((py_u_max_endpy_x - py_u_hx).^2 + (py_u_max_endpy_y - py_u_hy).^2);
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
[py_u_rnd_x, py_u_rnd_y] = Game_prey_model_random(pd_u_hx, pd_u_hy, py_u_hx, py_u_hy, Cntr_u);
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
    
else
    continue;
end

end
% Temp Plot to be deleted
% hold on;
% plot(Cntr_u(:,1),Cntr_u(:,2),'.c');
% p1 = plot(pd_u_hx,pd_u_hy,'-or','LineWidth',1.5);
% p2 = plot(py_u_hx,py_u_hy,'-ob','LineWidth',1.5);
% % % Random
% p3 = plot(py_u_rnd_x,py_u_rnd_y,'-ok');
% % Max
% p4 = plot(py_u_max_endpy_x,py_u_max_endpy_y,'-ok','LineWidth',1.5);
% 
% legend([p1,p2,p3,p4],'Pred','Prey','Rand','Max','Location','Best');
%% Plot All Distances
plot(5.*dist_pp_max_endpy,'-ob','Linewidth',1);
hold on;
plot(5.*dist_pp_rnd,'-ok','Linewidth',1);
%plot(dist_pp_3strategy,'-or','Linewidth',1);
legend('Max Prey','Rnd Prey','Location','Best');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
title('Computer Based Human Experiments');
grid on;

T0 = [dist_pp_rnd dist_pp_max_endpy dist_pp_3strategy];
figure;
y1 = T0(:,1);
y2 = T0(:,2);
y3 = T0(:,3);
% y4 = T0(:,4);
e1 = std(y1);
e2 = std(y2);
e3 = std(y3);
% e4 = std(y4);

x1 = 1:1:length(T0);

subplot(2,1,1)
[l1,p1] = boundedline(x1, y1, e1, '-r*','alpha');
outlinebounds(l1,p1);
axis([1 44 0 100]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Random Model');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
%
subplot(2,2,3)
[l3,p3] = boundedline(x1, y2, e2, '-b*','alpha');
outlinebounds(l3,p3);
axis([1 44 0 100]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Max Model')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
%
subplot(2,2,4)
[l4,p4] = boundedline(x1, y3, e3, '-m*','alpha');
outlinebounds(l4,p4);
axis([1 44 0 100]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Hybrid')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');

%% ANOVA1 - TG 05-08-2019
% bp = boxplot(dist_pp,'Notch','on','Labels',{'P','S','R','U'},'Whisker',1,'Widths',0.5,'Colors','rkbm', ...
%         'BoxStyle','outline');
% set(bp,{'linew'},{1.5})    
figure;
CategoricalScatterplot(T0,'Labels',{'Rand','Max','Hybrid'},'MarkerSize',15,'Marker','.',...
'MedianColor','r','WhiskerColor','k','BoxColor',[0.7 0.7 0.7],'BoxLineStyle','-',...'BoxEdgeColor',[0.5 0.5 0.5],...
'WhiskerLineWidth',0.1,'BoxLineWidth',1.5,'BoxAlpha',0.5,'MedianLineWidth',2);
set(gca,'FontName','Helvetica','FontSize',10,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','off','YMinorTick','off', ...
    'YGrid','off','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% legend('x','y','z','zz');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10)
title('Statistics for All Conditions');