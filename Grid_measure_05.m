%% 30-07-2016 Tauseef Gulrez % Finding the scale of the Grid
%
% Kidly check the coditions for PSR and U
clear all;close all;clc;
%
%


%% Make ch as base file and other as bad
exp = {'p','r','s','u'};
n = 10;
for files_ch = [n]
for files = [n]
    for nos = 4
%% Read Image Files Data Calib_Images (10-08-2018, TG)
load(sprintf('Calib_Images/%d_%s.mat',files,exp{nos}));

%% Read New Calib Files (17-09-2018, TG)
load(sprintf('Calib_files_new/%d_%s.mat',files_ch,exp{nos}));

%
if nos == 1
   I = Ip;
elseif nos == 2
   I = Ir;
elseif nos == 3
   I = Is;
elseif nos == 4
   I = Iu;
end

figure;
imshow(I);                               
hold on;

% Sort Points on X-Axis (from .mat obtain x and y)
[x1,ii]= sort(x);
y1 = y(ii);
% For Files (10_p as base, 36,37,38,39,40_p);x1(x1<785) = x1(x1<785)-7;
% For Files (40_r as base, 37,38,39_r);x1(x1>280) = x1(x1>280)+7;
% For Files (40_s as base, 36,37,38_s);x1(x1>280) = x1(x1>280)+7;x1(x1>810) = x1(x1>810)+7;x1(x1>1000) = x1(x1>1000)+7;
% For Files (40_s as base, 39_s);% x1(x1>670) = x1(x1>670)+7;x1(x1>870) = x1(x1>870)+7;
% For Files (_s: All Good, Now)
% For Files (35_u as base, 36,37,38,39,40_u);%x1(x1>250) = x1(x1>250)+7;
% For Files (5_r,% a = find(x1>620 & x1<635); % T = [(x1(a)+45),(y1(a))]; % x = vertcat(x1,T(:,1)); y = vertcat(y1,T(:,2));
% For Files (10_r,)a = find(x1>78 & x1<90); T = [(x1(a)-38),(y1(a))]; x = vertcat(x1,T(:,1)); y = vertcat(y1,T(:,2));
% For Files (12_r,)% a = find(x1>99 & x1<110); T = [(x1(a)-40),(y1(a))]; x = vertcat(x1,T(:,1)); y = vertcat(y1,T(:,2));
                          % a = find(x>1080 & x<1095); T = [(x(a)+40),(y(a))]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2));
% For Files (14_r)% a = find(x1>615 & x1<630); T = [(x1(a)+42),(y1(a))]; x = vertcat(x1,T(:,1)); y = vertcat(y1,T(:,2));
% For Files (26_r)% a = find(x1>505 & x1<520); T = [(x1(a)+42),(y1(a))]; x = vertcat(x1,T(:,1)); y = vertcat(y1,T(:,2));
% a = find(x>505 & x<520); T = [(x(a)+220),(y(a))]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2));
% a = find(x>505 & x<520); T = [(x(a)+310),(y(a))]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2)); 
% a = find(x>505 & x<520); T = [(x(a)+500),(y(a))]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2)); 
% a = find(x>505 & x<520); T = [(x(a)+550),(y(a))]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2)); 
% a = find(x>505 & x<520); T = [(x(a)+627),(y(a)-7)]; x = vertcat(x,T(:,1)); y = vertcat(y,T(:,2)); 
% x = x1; y = y1;
plot(x,y,'.r','MarkerSize',10);
% save(sprintf('Calib_files_new/%d_%s.mat',files,exp{nos}),'x','y');
% clear x y;
% Display the Image

plot(pd_u_hx,700-pd_u_hy,'.-k');
plot(py_u_hx,700-py_u_hy,'.-r');

 
    end % Experiment No. mkuj00pp
end % Files No.
end % Files_CH

