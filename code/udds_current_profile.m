function [UDDS_current, UDDS_full, UDDS] = udds_current_profile(filename)
% UDDS_CURRENT_PROFILE Generates battery current profile from UDDS speed
%
% INPUT:
%   filename - UDDS text file (time, speed)
%
% OUTPUT:
%   UDDS_current - [time, current]
%   UDDS_full    - same as UDDS_current (Simulink use)
%   UDDS         - alias

%% 1) READ UDDS DATA
data = readmatrix(filename);

t = data(:,1);           % time (s)
v = data(:,2);           % speed (mph)

dt = mean(diff(t));

%% 2) NORMALIZE SPEED
v_norm = v / max(v);

%% 3) COMPUTE ACCELERATION
acc = [0; diff(v)] / dt;
acc_norm = acc / (max(abs(acc)) + eps);

%% 4) CURRENT MODEL

% Base current from speed
I_speed = 4.5 * v_norm;

% Dynamic current (acceleration/deceleration)
I_accel = 6.0 * max(acc_norm, 0);
I_decel = -5.0 * max(-acc_norm, 0);

I_dyn = I_accel + I_decel;

% Noise
noise = 0.4 * randn(size(v));

% Total current
I = I_speed + I_dyn + noise;

%% 5) CLIPPING
I = min(max(I, -5), 11);

%% 6) SMOOTHING
I = smooth(I, 5);

%% 7) OUTPUT FORMATTING
UDDS_current = [t I];
UDDS_full    = UDDS_current;
UDDS         = UDDS_current;

%% 8) SAVE FILE
save('UDDS_current.mat', 'UDDS_current', 'UDDS_full', 'UDDS');

%% 9) PLOT
figure;
plot(t, I, 'b', 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Current (A)');
title('UDDS-Based Battery Current Profile');

end
