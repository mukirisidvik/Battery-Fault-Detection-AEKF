function Rk = R_update(F, C, Pp)
C = reshape(C,1,3);
Rk = F + C*Pp*C';
end
