% Initialization
close all
clear
clc
% Load parameters
% Load parameters
load('uas_parameters.mat');
load('uas_thrust_constants.mat');
load('hoop_pos.mat');

% Trajectory generation
% HOOP POSITION
start = [0; -2; 0.3];
end_ = [0; -2; 0];
% ORIGINAL OFFSET --> NEED TO SET !!!
offset1 = [0.11; -0.04; 0.07];
% offset = offset1;
offset2 = [0.0125; -0.06; 0.06];
offset3 = [0; -0.03; 0.07];
offset4 = [-0.04; -0.06; 0.08];

% TIME
% knots = [0 3 8 13 18 23];
knots = [0 5 10 15 20 25 30];

% WAYPOINT : inverted hoop4 with hoop2
waypoints = cell(1,6);
waypoints{1} = start;
waypoints{2} = p_h1 + offset1;
waypoints{3} = p_h4 + offset2;
waypoints{4} = p_h3 + offset3;
waypoints{5} = p_h2 + offset4;
waypoints{6} = end_;

% hoop_1 = [0.04; -0.32; 1.33] + offset1;
% hoop_2 = [2.13; -1.9; 1.3] + offset2;  %inverted hoop 2 and 4
% hoop_3 = [0.09; -3.94; 1.29] + offset3;
% hoop_4 = [-1.83; -1.98; 1.19] + offset4;

% waypoints{1} = start;
% waypoints{2} = hoop_1 ;
% waypoints{3} = hoop_2 ;
% waypoints{4} = hoop_3 ;
% waypoints{5} = hoop_4 ;
% waypoints{6} = end_;

% Fix this...
offset = [0; 0; 0.07];
order = 10;
corridors.times = [2.5 7.5 12.5 17.5 22.5 24];
%inverted corr 1 with 2 and 3 with 4
corr_1 = [-1.4; -0.5; 1.33] + offset;
corr_2 = [1.4; -0.5; 1.33] + offset;
corr_3 = [1.8; -3.7; 1.25] + offset;
corr_4 = [-1.4; -3.7; 1.2] + offset;
corr_5 = corr_1;
corr_6 = [0; -2; 1];

delta = 0.3;
corridors.x_lower = [corr_1(1) corr_2(1) corr_3(1) corr_4(1) corr_5(1) corr_6(1)] - delta;
corridors.x_upper = [corr_1(1) corr_2(1) corr_3(1) corr_4(1) corr_5(1) corr_6(1)] + delta;
corridors.y_lower = [corr_1(2) corr_2(2) corr_3(2) corr_4(2) corr_5(2) corr_6(2)] - delta;
corridors.y_upper = [corr_1(2) corr_2(2) corr_3(2) corr_4(2) corr_5(2) corr_6(2)] + delta;
corridors.z_lower = [corr_1(3) corr_2(3) corr_3(3) corr_4(3) corr_5(3) corr_6(3)] - delta;
corridors.z_upper = [corr_1(3) corr_2(3) corr_3(3) corr_4(3) corr_5(3) corr_6(3)] + delta;

% ...until here
make_plots = 1;
poly_traj = uas_minimum_snap_clockwise(knots, order, waypoints, corridors, make_plots);