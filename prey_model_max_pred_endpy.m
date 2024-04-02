%% Function Prey Model with Maximum Pred Position Last Point is Prey's Last Point
% TG, Footscray, Melbourne, 14-04-2018

function[prey_a_X, prey_a_Y] = prey_model_max_pred_endpy(pred_X, pred_Y, prey_X, prey_Y, C)

% pred_X - predator's X trajectory points
% pred_Y - predator's Y trajectory points
% prey_X - prey's X trajectory points
% prey_Y - prey's Y trajectory points
% C - is mesh of points containg hexagonal centres
% range - is the range within which Mesh points will be associated (300 is good)

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
    
    % Find Six Hex around the first point and so on    
    [hex_X,hex_Y] = six_fwd_hex_points(prey_a_X(i),prey_a_Y(i),C);

%     % Find Points which are within 300 radius of those six points
%     % This is a technique to find the Max Distant Point in Hex Points
%     hex_prey = rangesearch([hex_X' hex_Y'],[pred_X(i),pred_Y(i)],range);
    
    % Find Six Hex Points Ascending Order from Predator
    [D,I] = pdist2([hex_X' hex_Y'], [pred_X(i,1) pred_Y(i,1)],'Euclidean','Smallest',6 );
   
    % Find Six Hex Points Distances in Ascending Order from Prey_Biased Point
          if i < b1
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b1,1) prey_Y(b1,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i < b2
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b2,1) prey_Y(b2,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i < b3
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b3,1) prey_Y(b3,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i < b4
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b4,1) prey_Y(b4,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i < b5
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b5,1) prey_Y(b5,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i > b5 && i < b6
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b6,1) prey_Y(b6,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i > b5 && i > b6 && i < b7
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b7,1) prey_Y(b7,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i > b5 && i > b6 && i > b7 && i < b8
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b8,1) prey_Y(b8,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i > b5 && i > b6 && i > b7 && i > b8 && i < b9
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b9,1) prey_Y(b9,1)],'Euclidean','Smallest',6 );
          elseif i > b1 && i > b2 && i > b3 && i > b4 && i > b5 && i > b6 && i > b7 && i > b8 && i > b9 && i <= b10
              [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(b10,1) prey_Y(b10,1)],'Euclidean','Smallest',6 );
%           else
%               [D1,I1] = pdist2([hex_X' hex_Y'],[prey_X(end,1) prey_Y(end,1)],'Euclidean','Smallest',6 );
          end
    
              for j = 1:1:6
                  if D1(I1(j)) > 25
                      prey_a_X(i+1) = hex_X(I1(j));
                      prey_a_Y(i+1) = hex_Y(I1(j));
%                       disp(j);  
                      break;
                  end
              end
    end  

end