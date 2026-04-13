function K = KalmanGain(Pp, C, R)
% Force dimensions explicitly
C = reshape(C, 1, 3);   % 1×3 row vector

S = C*Pp*C' + R;        % scalar
K = (Pp*C') / S;        % 3×1
end
