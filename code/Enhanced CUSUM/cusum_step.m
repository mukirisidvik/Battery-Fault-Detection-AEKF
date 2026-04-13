function S = cusum_step(r)

% r = residual (already filtered if you want)

persistent Sk
if isempty(Sk)
    Sk = 0;
end

% === TUNED PARAMETERS (WORKING RANGE) ===
h = 0.02;     % drift (must be SMALLER than fault bias)
Smax = 1e6;   % prevent overflow (safety)

% === ONE-SIDED CUSUM ===
Sk = max(0, Sk + r - h);

% Saturation (numerical safety)
Sk = min(Sk, Smax);

S = Sk;
end
