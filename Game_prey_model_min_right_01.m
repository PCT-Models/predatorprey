%% Function Prey Model with Maximum Pred Position Last Point is Prey's Last Point
% TG, Footscray, Melbourne, 14-04-2018

function[prey_a_X, prey_a_Y] = Game_prey_model_min_right(pred_X, pred_Y,prey_X, prey_Y,C,lp)
% pred_X - predator's X trajectory points
% pred_Y - predator's Y trajectory points
% prey_X - prey's X trajectory points
% prey_Y - prey's Y trajectory points
% C - is mesh of points containg hexagonal centres
% range - is the range within which Mesh points will be associated (300 is good)
% Six Hex Points are [45,90,135,225,270,315] - 

% Predators Trajectory
L = length(prey_X);

%
% Preallocation of Prey's Movement coordinates
% prey_a_X = [];
% prey_a_Y = [];
% First Predator's Trajectory XY
base_X = prey_X(1,1);
base_Y = prey_Y(1,1);
% Associate 1st Prey's point to the Calibration file
[prey_a_X(1,1),prey_a_Y(1,1)] = associate_grid(base_X,base_Y,C);
% prey_a_X(1,1) = base_X;
% prey_a_Y(1,1) = base_Y;
%
% Taking the Last Prey's Trajectory Point
r_point_x = prey_X(end,1);
r_point_y = prey_Y(end,1);

% Taking the Mid Prey's Trajectory Point
if isempty(lp)
    % Find the No. of anchor point in the Trajectory to make model turn 
    number  = round(L/2);
    m_point_x = prey_X(number,1);
    m_point_y = prey_Y(number,1);
elseif ~isempty(lp) 
    m_point_x = lp(1);
    m_point_y = lp(2);
    % Find the No. of anchor point in the Trajectory to make model turn 
    [number,~] = find(prey_X == lp(1));
end
% Initialise the distance hypothetically
d = 10;
k = 1;
D_p(1) = 10;


% while((d > 2) || (k < L) || (D_p(1) > 2)) % Either Prey points finish or distance from Last prey is smaller
while true
    
    if k == 1
         [hex_X,hex_Y] = Game_six_hex_points(prey_a_X(1,1),prey_a_Y(1,1),C);
          %[hex_X,hex_Y] = six_hex_points(prey_a_X(1,1),prey_a_Y(1,1),C);  
    elseif k >= L
        break;
    else
         [hex_X,hex_Y] = Game_six_hex_points(prey_a_X(k),prey_a_Y(k),C);
%          [hex_X,hex_Y] = six_hex_points(prey_a_X(k,1),prey_a_Y(k,1),C);  
    end
    
    if k < number
        % Distance between Prey's Last Point and Comp Model
        [D_r,I_r] = pdist2([hex_X' hex_Y'], [m_point_x m_point_y],'Euclidean','Smallest',6 );
    
    elseif k > number
    % Distance between Prey's Last Point and Comp Model
        [D_r,I_r] = pdist2([hex_X' hex_Y'], [r_point_x r_point_y],'Euclidean','Smallest',6 );
    
    end
    
    % Distance between Pred's Point and Prey's Model
        [D_p,I_p] = pdist2([hex_X' hex_Y'], [pred_X(k) pred_Y(k)],'Euclidean','Smallest',6 );    

    
    
%     if (I_p(6) == I_r(1))
        % Distance from Prey's Last Point
%         d = D_r(1);
        I_p = flip(I_p);
                
        % Both max and min are same or approx. same
        for i = 1:1:6
        sr = I_r(i); sp = I_p(i);
            if (sr == sp) || (abs(sr - sp) == 5) || (abs(sr - sp) == 4)
                    k = k+1;
                    prey_a_X(k,1) = hex_X(sr);
                    prey_a_Y(k,1) = hex_Y(sr);

                    break;
            else
                    k = k+1;
                    prey_a_X(k,1) = hex_X(sr);
                    prey_a_Y(k,1) = hex_Y(sr);
%                     disp(k);
                    break;

            end
        end
        
end
%                 J = (abs(I_p-I_r));
%                 [a,~] = find(J == (min(J)));
%                 k = k+1;
%                 prey_a_X(k,1) = hex_X(I_r(a(1)));
%                 prey_a_Y(k,1) = hex_Y(I_r(a(1)));
%         
%         
%         end
        
%         disp('True');
%         hold on;
%         plot(prey_a_X(k,1),700-prey_a_Y(k,1),'or','LineWidth',2);
%     else
%         break;
%         % Distance from Prey's Last Point
%         d = D_r(1);
%         s = I_p(5);
%         k = k+1;
%         prey_a_X(k) = hex_X(s);
%         prey_a_Y(k) = hex_Y(s);
%         disp('False');
%     end
    
end
