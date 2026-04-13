clc;
clear;
close all;

filename = 'UDDS_full.txt';

[UDDS_current, UDDS_full, UDDS] = udds_current_profile(filename);

disp('UDDS current profile generated successfully');
