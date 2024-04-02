%% Function Prey Model with Maximum Pred Position End is Pred Last Point
% TG, Footscray, Melbourne, 14-04-2018

function[prey_a_X, prey_a_Y] = prey_model_max_pred(pred_X, pred_Y, prey_X, prey_Y, C, range)
% pred_X - predator's X trajectory points
% pred_Y - predator's Y trajectory points
% prey_X - prey's X trajectory points
% prey_Y - prey's Y trajectory points
% C - is mesh of points containg hexagonal centres
% range - is the range within which Mesh points will be associated (300 is good)

        L = length(prey_X);
      
      % Preallocation of Prey's Movement coordinates
      prey_a_X = zeros(L,1);
      prey_a_Y = zeros(L,1);
      
      % First Prey's Trajectory XY
      base_X = prey_X(1,1);
      base_Y = prey_Y(1,1);
      
      % Associate the Prey's first XY to the Calibration file cell
      base_prey = rangesearch(C,[base_X base_Y],60);
      
      % Associated Prey's XY first cell
      prey_a_X(1) = C(base_prey{1}(1),1);
      prey_a_Y(1) = C(base_prey{1}(1),2);  
       
      
      
      % Loop for all Prey's Points
    for i = 1:1:length(pred_X)
    [hex_X,hex_Y] = six_fwd_hex_points(prey_a_X(i),prey_a_Y(i),C);
    
    % Find Points which are within 300 radius of those six points
    hex_prey = rangesearch([hex_X' hex_Y'],[pred_X(i),pred_Y(i)],range);
    
    [D,I] = pdist2([hex_X(hex_prey{1}(1:end));hex_Y(hex_prey{1}(1:end))]', [pred_X(end,1);pred_Y(end,1)]' ,'Euclidean','Smallest',6 );
    
    prey_a_X(i+1) = hex_X(hex_prey{1}(I(1)));
    prey_a_Y(i+1) = hex_Y(hex_prey{1}(I(1)));
   
    end  

end