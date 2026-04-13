function s = loglikelihood_step(r)
sigma = 0.002;   % start here
s = (r.^2) / (2*sigma^2);
end
