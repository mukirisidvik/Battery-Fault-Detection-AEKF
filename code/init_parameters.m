function params = init_parameters()
% INIT_PARAMETERS Initializes battery and AEKF parameters

%% ===============================
% Sampling Time
%% ===============================
params.Ts = 1;

%% ===============================
% Battery Parameters (Base Cell)
%% ===============================
params.R  = 4.3e-3;
params.R1 = 0.32e-3;
params.C1 = 629.7;
params.R2 = 2.8e-3;
params.C2 = 2247.7;

%% ===============================
% Derived RC Parameters
%% ===============================
params.a1 = exp(-params.Ts/(params.R1 * params.C1));
params.b1 = params.R1 * (1 - params.a1);

params.a2 = exp(-params.Ts/(params.R2 * params.C2));
params.b2 = params.R2 * (1 - params.a2);

%% ===============================
% Battery Capacity
%% ===============================
params.Qb = 4.5 * 3600;

%% ===============================
% OCV-SOC Table
%% ===============================
params.SOC_bp = [0 0.2 0.4 0.6 0.8 0.86 1.0];
params.OCV    = [3.20 3.27 3.30 3.33 3.36 3.35 3.45];

params.dOCV = gradient(params.OCV, params.SOC_bp);

%% ===============================
% AEKF Parameters
%% ===============================
params.Q = diag([1e-6, 1e-6, 1e-5]);
params.Rk = 1e-3;
params.P0 = diag([1e-4, 1e-4, 1e-2]);

%% ===============================
% CUSUM Parameters
%% ===============================
params.mu0 = 0;
params.sigma0 = 0.002;

params.mu1 = 0.02;
params.sigma1 = 0.002;

params.J = 3000;

%% ===============================
% Multi-Cell Parameters
%% ===============================
params.Cell(1).R1 = 0.31e-3;
params.Cell(1).C1 = 632.4;
params.Cell(1).R2 = 3.1e-3;
params.Cell(1).C2 = 2367.5;

params.Cell(2).R1 = 0.34e-3;
params.Cell(2).C1 = 605.3;
params.Cell(2).R2 = 3.0e-3;
params.Cell(2).C2 = 2453.6;

params.Cell(3).R1 = 0.36e-3;
params.Cell(3).C1 = 591.5;
params.Cell(3).R2 = 2.8e-3;
params.Cell(3).C2 = 2087.1;

params.Cell(4).R1 = 0.36e-3;
params.Cell(4).C1 = 647.1;
params.Cell(4).R2 = 3.4e-3;
params.Cell(4).C2 = 2579.9;

end
