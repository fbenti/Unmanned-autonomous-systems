%% Initialization

% close all
% clear
% clc

% load('pwm.mat')
% load('acc.mat')
% out.pwm = pwm;;
% out.acceleration = acceleration;

% load('uas_thrust_data.mat')

g = 9.81;

%% Identification

indices = out.pwm.Time > 5 & out.pwm.Time < 40 & out.acceleration.Data - g > 0;


%%
% 
% figure
% plot(out.acceleration.Time, out.acceleration.Data - g)
% grid on
% hold all
% plot(out.pwm.Time, out.pwm.Data/60000)
% ylim([-10 10])

%%

x = out.pwm.Data(indices)/60000;
y = out.acceleration.Data(indices) - g;
result = line_fit(x, y);
% p1 = result.p1;
% p2 = result.p2 - 3;
p1 = result(1)
p2 = result(2)
save('uas_thrust_constants_ivan.mat', 'p1', 'p2')
% save('uas_thrust_constants.mat', 'p1', 'p2')



