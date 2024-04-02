%% Function Prey Model with Maximum Pred Position
% TG, Footscray, Melbourne, 14-04-2018

function[prey_a_X, prey_a_Y] = prey_model_random_01_pred(pred_X, pred_Y, prey_X, prey_Y, C)

% pred_X - predator's X trajectory points
% pred_Y - predator's Y trajectory points
% prey_X - prey's X trajectory points
% prey_Y - prey's Y trajectory points
% C - is mesh of points containg hexagonal centres
      
      L = length(pred_X);
      
      % Introduce Biasness
        b1 = round(L*0.1);
        b2 = round(L*0.2);
        b3 = round(L*0.3);
        b4 = round(L*0.4);
        b5 = round(L*0.5);
        b6 = round(L*0.6);
        b7 = round(L*0.7);
        b8 = round(L*0.8);
        b9 = round(L*0.9);
        b10 = round(L);  
      L = length(prey_X);
      
      % Preallocation of Prey's Movement coordinates
      prey_a_X = zeros(L,1);
      prey_a_Y = zeros(L,1);
      
      % First Predator's Trajectory XY
      base_X = prey_X(1,1);
      base_Y = prey_Y(1,1);
      
      % Associate 1st Prey's point to the Calibration file
      [prey_a_X(1,1),prey_a_Y(1,1)] = associate_grid(base_X,base_Y,C); 
       
      % Loop for all Prey's Points
      for i = 1:1:L
          [hex_X,hex_Y] = three_fwd_hex_points(prey_a_X(i),prey_a_Y(i),C);

          % Find Points which are within 300 radius of those six points
          hex_prey = rangesearch([hex_X' hex_Y'],[pred_X(i),pred_Y(i)],1000);

          % The sixth point is the Farthest Prey Point w.r.t. the Predator
          % Position
          %     prey_a_X(i+1) = round(hex_X(hex_prey{1}(end)));
          %     prey_a_Y(i+1) = round(hex_Y(hex_prey{1}(end)));

          % Induce randomness
          rdm = randsample(3,1);
          
          try
              prey_a_X(i+1) = hex_X(hex_prey{1}(rdm));
              prey_a_Y(i+1) = hex_Y(hex_prey{1}(rdm));
              
          catch
              try
                  [D,I] = pdist2([hex_X(hex_prey{1}(1:end));hex_Y(hex_prey{1}(1:end))]', [pred_X(end,1);pred_Y(end,1)]' ,'Euclidean','Smallest',6 );
                  prey_a_X(i+1) = hex_X(hex_prey{1}(I(1)));
                  prey_a_Y(i+1) = hex_Y(hex_prey{1}(I(1)));
              catch
                  try
                      prey_a_X(i+1) = hex_X(hex_prey{1}(1));
                      prey_a_Y(i+1) = hex_Y(hex_prey{1}(1));
                  catch
                      try
                          prey_a_X(i+1) = hex_X(hex_prey{1}(1));
                          prey_a_Y(i+1) = hex_Y(hex_prey{1}(1));
                      catch
                          try
                              prey_a_X(i+1) = hex_X(hex_prey{1}(2));
                              prey_a_Y(i+1) = hex_Y(hex_prey{1}(2));
                          catch
                              prey_a_X(i+1) = hex_X(hex_prey{1}(3));
                              prey_a_Y(i+1) = hex_Y(hex_prey{1}(3));
                              
                          end
                      end
                  end
              end

      end

end