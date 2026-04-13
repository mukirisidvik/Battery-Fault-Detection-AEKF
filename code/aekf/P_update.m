function Pk = P_update(Pp, K, C)
% Updated covariance: Pk = (I - K*C) * Pp
C = reshape(C,1,3);
I = eye(3);
Pk = (I - K*C) * Pp;
end
