%% Function to Generate Grid Points (Mid Points) by Computer Vision
%% TG - Footscray, Melbourne, 30-06-2018

function [xm,ym] = grid_points_cv_02(I)
[~, threshold] = edge(I, 'canny');
fudgeFactor = .5;
BW = edge(I,'canny', threshold * fudgeFactor);
[B,L,N,A] = bwboundaries(BW);

% imshow(label2rgb(L, @jet, [.5 .5 .5]))
RM = im2bw(zeros(301,1271)); % Needs to be fixed.........

T = {};
F = {};
i = 0;
%
for k = 1:N
    % hold on;
    % Boundary k is the parent of a hole if the k-th column
    % of the adjacency matrix A contains a non-zero element
    if (nnz(A(:,k)) > 0)
        boundary = B{k};
        if (length(B{k}) > 45 && length(B{k}) < 80)
            i = i+1;
            T{i} = B{k};
            RM(boundary(:,1),boundary(:,2)) = 1;
            F{i} = [boundary(:,1) boundary(:,2)];
            hold on;
            plot(boundary(:,2),boundary(:,1),'.r','LineWidth',2);
        end
    end
end

%% Detect the Mid Points of the Hexagons - 10-08-2018 TG
midd = [];
% Note: Give x as y and y as x in the function
for i = 1:1:length(F)
[px,py,mid,r] = hex_middle_point(F{i}(:,2),F{i}(:,1));
midd = [midd ; [mid(:,1) mid(:,2)]];
end

xm = midd(:,1);
ym = midd(:,2);

%
end