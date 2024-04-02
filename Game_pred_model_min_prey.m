% Function for finding the Pred Model with Minimum Prey Position
% TG, Footscray, Melbourne, 10-02-2018


function[pred_a_X, pred_a_Y] = Game_pred_model_min_prey(pred_X, pred_Y, prey_X, prey_Y, C)

% pred_X - predator's X trajectory points
% pred_Y - predator's Y trajectory points
% prey_X - prey's X trajectory points
% prey_Y - prey's Y trajectory points
% C - is mesh of points containg hexagonal centres

% Store all Predator's Hexagonal Points (out of six at minimum distance from Prey)
% Model points 'model_X', model_Y

      L = length(prey_Y);
      
      % Preallocation of Pred's Minimum Movement coordinates
      pred_a_X = zeros(L,1);
      pred_a_Y = zeros(L,1);
      
      base_X = pred_X(1,1);
      base_Y = pred_Y(1,1);
      
      % Associate 1st Pred's point to the Calibration file
%       [prey_a_X(1,1),prey_a_Y(1,1)] = associate_grid(base_X,base_Y,C); 
      base_pred = rangesearch(C,[base_X base_Y],10);
      
      pred_a_X(1) = C(base_pred{1}(1),1);
      pred_a_Y(1) = C(base_pred{1}(1),2);
       
      % Loop for all Prey's Points
      for i = 1:1:length(prey_X)
          [hex_X,hex_Y] = Game_six_hex_points(pred_a_X(i),pred_a_Y(i),C);
          
          hex_prey = rangesearch([hex_X' hex_Y'],[prey_X(i),prey_Y(i)],100);
          
          % The first point is the Closest Pred Point w.r.t. the Prey
          % Position
          pred_a_X(i+1) = round(hex_X(hex_prey{1}(1)));
          pred_a_Y(i+1) = round(hex_Y(hex_prey{1}(1)));
      end

end