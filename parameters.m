% Propeller speed
% w = [10000; 0; 10000; 0];
w = [0; 10000; 0; 10000];

% mass
m = 0.5;

% lenght arm
L = 0.225;

% overall aerodynamic coeff for computing the lift of propellers 
% [N *s^2/rad^2]
k = 0.01;

% overall aerodynamic coeff to compute the drag torque of the propellers
% [N * m * s^2/rad^2]
b = 0.001;

% Drag of the UAV moving in air with velocity p' [Ns/m]
k_d = 0.01;
% D = diag([d,d,d].');

% Moment of Inertia Ix [Nms^2 / rad] 
Ix = 3*exp(-3);

% Moment of Inertia Iy [Nms^2 / rad] 
Iy = 3*exp(-3);

% Moment of inertia Iz [Nms^2 / rad] 
Iz = 5*exp(-6);

% Inertia matrix
I = [Ix 0 0; 0 Iy 0; 0 0 Iz];

% Gravitational acceleration [m/s^2]
g = [0; 0 ; -9.81];
g_acc = 9.81;