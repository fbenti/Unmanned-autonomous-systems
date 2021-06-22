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
end_ = [0; -2; 0];
offset1 = [0; -0.015; 0.06];
offset = offset1;
offset2 = [0.015; -0.02; 0.06];
offset3 = [0; 0.02; 0.06];
offset4 = [-0.06; -0.06; 0.07];
% hoop_1 = [0.04; -0.32; 1.33] + offset;
% hoop_2 = [-1.83; -1.98; 1.19] + offset;
% hoop_3 = [0.09; -3.94; 1.29] + offset;
% hoop_4 = [2.13; -1.9; 1.3]+ offset;

% TIME
% knots = [0 3 8 13 18 23];
knots = [0 5 10 15 20 25 28];
% WAYPOINT
waypoints = cell(1,6);
waypoints{1} = start;
waypoints{2} = p_h1 + offset1;
waypoints{3} = p_h2 + offset2;
waypoints{4} = p_h3 + offset3;
waypoints{5} = p_h4 + offset4;
waypoints{6} = end_;

% Fix this...
order = 10;
% corridors.times = [1.5 5.5 10.5 15.5 20.5];
corridors.times = [2.5 7.5 12.5 17.5 22.5 24];
% corridors.x_lower = [1.1 -1.7 -1.9 1.5 1.1];
% corridors.x_upper = [1.7 -1.1 -1.3 2.1 1.7];
% corridors.y_lower = [-0.8 -0.8 -4. -4 -0.8];
% corridors.y_upper = [-0.2 --0.2 -3.4 -3.4 -0.2];
% corridors.z_lower = [1.03 1.03 0.9 0.95 1.03];
% corridors.z_upper = [1.63 1.63 1.5 1.55 1.63];

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
poly_traj = uas_minimum_snap(knots, order, waypoints, corridors, make_plots);