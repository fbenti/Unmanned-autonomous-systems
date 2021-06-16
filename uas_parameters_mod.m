%% INITIALIZATION

clear
close all
clc

%% SIMULATION PARAMETERS
map = [0 0 0 0 0 0 0 0 0 0;
       0 1 0 1 1 1 1 1 1 0;
       1 1 0 1 1 0 0 0 1 0;
       0 0 0 0 1 0 1 0 1 0;
       0 1 1 0 0 0 1 0 0 0;
       0 0 1 1 1 1 1 1 1 0;
       1 0 0 0 1 0 0 0 1 0;
       1 1 1 0 0 0 1 0 1 0;
       1 1 1 1 1 1 1 0 1 0;
       0 0 0 0 0 0 0 0 0 0];
map = flip(map)';
route = astar_3d(map, [0 0 1] + [1 1 0], [3 5 1] + [1 1 0]) -[1 1 0];

wall_color = [0.8 0.2 0.2];
sample_time = 4e-2;
publish_rate = 1 * sample_time;
x0 = 36;
y0 = 80;
z0 = 1;
g = 9.81;
mass_drone = 0.5 ;
mass_rod = 0.0;
mass_tip = 0;
mass_total = mass_drone + mass_rod + mass_tip;
stiffness_rod = 100 ;
critical_damping_rod = 2 * sqrt(mass_total * stiffness_rod) ;
stiffness_wall = 100 ;
critical_damping_wall = 2 * sqrt(mass_total * stiffness_wall) ;
inertia_xx = 3*exp(-6);
inertia_yy = 3*exp(-6);
inertia_zz = 1*exp(-5) ;
arm_length = 0.225 ;
rotor_offset_top = 0.01 ;
motor_constant = 8.54858e-06 ;
% drag coefficient b
moment_constant = 0.001 ;
max_rot_velocity = 838 ;
allocation_matrix = ...
    [1 1 1 1
     0 arm_length 0 -arm_length
     -arm_length 0 arm_length 0
     -moment_constant moment_constant -moment_constant moment_constant] ;
mix_matrix = inv(motor_constant * allocation_matrix) ;
air_density = 1.2041;
% lift coefficient
drag_coefficient = 0.01;
reference_area = pi * 75e-3^2;

% Propeller speed
% w = [10000; 0; 10000; 0];
% w = [0; 10000; 0; 10000];
% w = [122.625;122.625;122.625;122.625];

% massg = [0; 0 ; -9.81];
m = 0.5;
M = diag([m,m,m].');

% lenght arm
L = 0.225;

% overall aerodynamic coeff for computing the lift of propellers 
% [N *s^2/rad^2]
k_l = 0.01;

% overall aerodynamic coeff to compute the drag torque of the propellers
% [N * m * s^2/rad^2]
b_t = 0.001;

% Drag of the UAV moving in air with velocity p' [Ns/m]
d = 0.01;   
D = diag([d,d,d].');

% Moment of Inertia Ix [Nms^2 / rad] 035
Ix = 3*exp(-6);

% Moment of Inertia Iy [Nms^2 / rad] 
Iy = 3*exp(-6);

% Moment of inertia Iz [Nms^2 / rad] 
Iz = 1*exp(-5);

% Inertia matrix
I = [Ix 0 0; 0 Iy 0; 0 0 Iz];
invI = inv(I);

% Gravitational acceleration [m/s^2]
mg = [0; 0; -m*9.81];
g_acc = 9.81;


% % PID 

% ROLL
K_r = -0.075;
T_r = 22.8;
Kp_r = 0.6*K_r*6;
Ki_r = 1.2*K_r/T_r*0.3;
Kd_r = -0.075*K_r*T_r*6.2;

% PITCH
% K_p = -0.075;
% T_p = 23.410;
% Kp_p = 0.6*K_p*6;
% Ki_p = 1.2*K_p/T_p*0.3;
% Kd_p = -0.075*K_p*T_p*6.2;

K_p = -0.01;
T_p = 62.11;
Kp_p = 0.6*K_p*40;
Ki_p = 1.2*K_p/T_p*1.2;
Kd_p = -0.075*K_p*T_p*17;

% YAW
K_y = -0.075;
T_y = 23.8;
Kp_y = 0.6*K_y*10;
Ki_y = 1.2*K_y/T_y*0.1;
Kd_y = -0.075*K_y*T_y*7;

% ALTIDTUDE - Z
Kp_z = 20;
Ki_z = 0.01;
Kd_z = -65;

% PID - X
% Kp_x = -0.003;
% Ki_x = 0;
% Kd_x = 0;
% Kd_x = -CCt.Kd;
% 
% K_x = -0.003;
% T_x = 38.897;
% Kp_x = 0.2*K_x*10;
% % % Ki_x = 1.2*K_x/T_x*0.1;
% Ki_x = 0;
% Kd_x = -0.066666*K_x*T_x*0.5;

K_x = -2.33e-04;
T_x = 28.391;
Kp_x = 0.6*K_x*15;
% Ki_x = 1.2*K_x/T_x*0.1;
Ki_x = 0;
Kd_x = -0.075*K_x*T_x*45;

% PID - Y
% Kp__y = 0;
% Ki__y = 0;
% Kd__y = 0;
K__y = -2.33e-04;
T__y = 28.391;
Kp__y = 0.6*K__y*15;
% Ki__y = 1.2*K__y/T__y*0.1;
Ki__y = 0;
Kd__y = -0.075*K__y*T__y*45;

