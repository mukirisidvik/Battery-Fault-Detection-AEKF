function F = ResidualCov(mu)
mu = mu(:);              % force column vector
N  = length(mu);
F  = sum(mu.^2)/(N-1);   % scalar variance
end
