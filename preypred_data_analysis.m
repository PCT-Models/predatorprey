%% Prey Predator Pusuit Data Analysis - TG

clc, close all; clear all;
%% Preallocate to save results
% Read Excel File
filename = 'predatorprey.xlsx';

dist_pp = []; % Distance between Human Predator and Predator
% dispypd_p_h_save = [];
% dispypd_s_h_save = [];
% dispypd_r_h_save = [];
% dispypd_u_h_save = [];

%% Read Files in a Loop
for files = [1,2,4:20,26:40]
% tic();
% 
% sheet = horzcat('P',num2str(files));    

% Read From Excel Files
%Prey P,S,R,U (x and y) Respectively
% py_p_hx = xlsread(filename,sheet,'B:B'); % P-x-axis
% py_p_hy = xlsread(filename,sheet,'C:C');   % P-y-axis
% py_s_hx = xlsread(filename,sheet,'D:D');
% py_s_hy = xlsread(filename,sheet,'E:E');
% py_r_hx = xlsread(filename,sheet,'F:F');
% py_r_hy = xlsread(filename,sheet,'G:G');
% py_u_hx = xlsread(filename,sheet,'H:H');
% py_u_hy = xlsread(filename,sheet,'I:I');

%Pred P,S,R,U (x and y) Respectively
% pd_p_hx = xlsread(filename,sheet,'J:J'); % P-x-axis
% pd_p_hy = xlsread(filename,sheet,'K:K');
% pd_s_hx = xlsread(filename,sheet,'L:L');
% pd_s_hy = xlsread(filename,sheet,'M:M');
% pd_r_hx = xlsread(filename,sheet,'N:N');
% pd_r_hy = xlsread(filename,sheet,'O:O');
% pd_u_hx = xlsread(filename,sheet,'P:P');
% pd_u_hy = xlsread(filename,sheet,'Q:Q');
%
%% Distances between Human Prey and Predator i.e Distance Formula; sqrt( (x2-x1)^2 + (y2-y1)^2) 
% dispypd_p_h = sqrt((py_p_hx - pd_p_hx).^2 + (py_p_hy - pd_p_hy).^2);
% dispypd_p_h = round(dispypd_p_h,3,'significant');
% dispypd_s_h = sqrt((py_s_hx - pd_s_hx).^2 + (py_s_hy - pd_s_hy).^2);
% dispypd_s_h = round(dispypd_s_h,3,'significant');
% dispypd_r_h = sqrt((py_r_hx - pd_r_hx).^2 + (py_r_hy - pd_r_hy).^2);
% dispypd_r_h = round(dispypd_r_h,3,'significant');
% dispypd_u_h = sqrt((py_u_hx - pd_u_hx).^2 + (py_u_hy - pd_u_hy).^2);
% dispypd_u_h = round(dispypd_u_h,3,'significant');
%
%% Reading Excel File Data
% dispypd_p_h = xlsread(filename,sheet,'R:R');
% dispypd_s_h = xlsread(filename,sheet,'S:S');
% dispypd_r_h = xlsread(filename,sheet,'T:T');
% dispypd_u_h = xlsread(filename,sheet,'U:U');
%% Predator Prey Distance Measure

% dispypd_p_h_save = [dispypd_p_h_save;dispypd_p_h];
% dispypd_s_h_save = [dispypd_s_h_save;dispypd_s_h];
% dispypd_r_h_save = [dispypd_r_h_save;dispypd_s_h];
% dispypd_u_h_save = [dispypd_u_h_save;dispypd_s_h];

% Mean Distance (41 slide)
% dist_pp = [dist_pp; mean(dispypd_p_h) mean(dispypd_s_h) mean(dispypd_r_h) mean(dispypd_u_h)];
% 
% toc();
end

%% Run Sheet 41 for results
tic();
dispypd_p_41 = xlsread(filename,'41','B:B');
dispypd_s_41 = xlsread(filename,'41','C:C');
dispypd_r_41 = xlsread(filename,'41','D:D');
dispypd_u_41 = xlsread(filename,'41','E:E');
dist_pp = [dispypd_p_41 dispypd_s_41 dispypd_r_41 dispypd_u_41];
toc();
%%
T0  = dist_pp;
figure;
subplot(1,2,1);
plot(T0(:,1),'-or','LineWidth',2);
hold on;
plot(T0(:,2),'-ok','LineWidth',2); 
plot(T0(:,3),'-ob','LineWidth',2);
plot(T0(:,4),'-om','LineWidth',2);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );
legend('P','S','R','U')
xlabel('No. of Trials');
ylabel('Average Distance');
% set(gcf, 'PaperPositionMode', 'auto');
% print -dpng plot_dist_pp_human.png
% close;
% Error Bar Plot
subplot(1,2,2);
xx = [1,2,3,4];
dat = [mean(T0(:,1)),mean(T0(:,2)),mean(T0(:,3)),mean(T0(:,4))];
bar(xx,dat);
set(gca, 'FontSize',8,'XTick',xx,'XTickLabel',{'Predictive','Semi-Random','Random','User-Defined' });
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );
ylabel('Mean Distance');
xlabel('Trial Conditions');
axis([0 5 0 102]);
hold on
er = errorbar(xx,dat,[std(T0(:,1)); std(T0(:,2));std(T0(:,3));std(T0(:,4))]);
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
hold off;
suptitle('Average Distance between Prey and Predator');
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 10 5];
% print -dpng plot_dist_pp_human.png
%%
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
axis([1 34 0 150]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Predicted Condition')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,2)
[l2,p2] = boundedline(x1, y2, e2, '-k*','alpha');
outlinebounds(l2,p2);
axis([1 34 0 150]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Semi-Random Condition')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,3)
[l3,p3] = boundedline(x1, y3, e3, '-b*','alpha');
outlinebounds(l3,p3);
axis([1 34 0 150]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('Random Condition')
ylabel('Mean Distance','FontName','Helvetica','FontSize',10);
xlabel('Trial No.','FontName','Helvetica','FontSize',10);
legend('95% Conf.','Est. value');
subplot(2,2,4)
[l4,p4] = boundedline(x1, y4, e4, '-m*','alpha');
outlinebounds(l4,p4);
axis([1 34 0 150]);
set(gca,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','on','YMinorTick','on', ...
    'YGrid','on','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
title('User-Generated Condition')
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
CategoricalScatterplot(dist_pp,'Labels',{'P','S','R','U'},'MarkerSize',15,'Marker','.',...
'MedianColor','r','WhiskerColor','k','BoxColor',[0.7 0.7 0.7],'BoxLineStyle','-',...'BoxEdgeColor',[0.5 0.5 0.5],...
'WhiskerLineWidth',0.1,'BoxLineWidth',1.5,'BoxAlpha',0.5,'MedianLineWidth',2);
set(gca,'FontName','Helvetica','FontSize',10,'Box','off','TickDir','out','TickLength', [.02 .02],'XMinorTick','off','YMinorTick','off', ...
    'YGrid','off','XColor', [.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth', 1);
% legend('x','y','z','zz');
ylabel('Mean Distance','FontName','Helvetica','FontSize',10)
title('Statistics for All Conditions');

%% T-Test Bonferroni
[p,~,stats] = anova1(dist_pp);
[results,means] = multcompare(stats,'CType','bonferroni');
%