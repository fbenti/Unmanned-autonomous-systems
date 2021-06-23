% Initialization
% close all
% clear
% clc
% Load parameters
load('uas_parameters.mat');
load('uas_thrust_constants.mat');

% Trajectory generation

% HOOP POSITION
start = [0; -2; 1.3];
hoop_1 = [0.04; -0.32; 1.33];
hoop_2 = [-1.83; -1.98; 1.19];
hoop_3 = [0.09; -3.94; 1.29];
hoop_4 = [2.13; -1.9; 1.3];
end_ = [0; -2; 0];

offset1 = [0; -0.015; 0.06];
offset2 = [0.015; -0.02; 0.06];
offset3 = [0; 0.02; 0.06];
offset4 = [-0.06; -0.06; 0.07];

% DEFINED HOOP
waypoints = cell(1,7);
waypoints{1} = start;
waypoints{2} = hoop_1 + offset1;
waypoints{3} = hoop_2 + offset2;
waypoints{4} = hoop_3 + offset3;
waypoints{5} = hoop_4 + offset4;
waypoints{6} = start;
waypoints{7} = end_;

% % TRACKED HOOP
% waypoints = cell(1,7);
% waypoints{1} = start;
% waypoints{2} = p_h1 + offset1;
% waypoints{3} = p_h2 + offset2;
% waypoints{4} = p_h3 + offset3;
% waypoints{5} = p_h4 + offset4;
% waypoints{6} = start;
% waypoints{7} = end_;

% TIME
% knots = [0 5 10 15 20 25 30];
knots = [0 3 8 13 18 23 28];

% Fix this...
offset = [0; 0; 0.06];
order = 10;
% corridors.times = [2.5 7.5 12.5 17.5 22.5 27.5];
corridors.times = [1.5 5.5 10.5 15.5 20.5 25.5];

% corr_0 = [0; -2; 1.3];
corr_1 = [1.8; -0.5; 1.33] + offset;
corr_2 = [-1.4; -0.5; 1.33] + offset;
corr_3 = [-1.6; -3.7; 1.2] + offset;
corr_4 = [1.8; -3.7; 1.25] + offset;
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
poly_traj = Copy_uas_minimum_snap(knots, order, waypoints, corridors, make_plots);