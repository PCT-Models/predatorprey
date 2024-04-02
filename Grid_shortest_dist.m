% TG Melbourne 07/01/2017

% Shortest Distance Simulation

%        % Now make the Grid of Hexagons
clc;clear all;close all;

for i = 0:2:20
for j = 0
    
scale = 1;
N_sides = 6;

t=(1/(N_sides*2):1/N_sides:1)' * 2*pi;
x=sin(t);
y=cos(t);
x=scale*[x; x(1)];
y=scale*[y; y(1)];

x = x+(i*2);
y = y+(j*2);

hold on;
plot(x,y,'.-r','Linewidth',1)

end
end

for i = 0:2:20
for j = 0
    
scale = 1;
N_sides = 6;

t=(1/(N_sides*2):1/N_sides:1)' * 2*pi;
x=sin(t);
y=cos(t);
x=scale*[x; x(1)];
y=scale*[y; y(1)];

x = x+(i*2)+2;
y = y+(j*2)+2;

hold on;
plot(x,y,'.-b','Linewidth',1)

end
end