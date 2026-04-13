function x_hat = StateCorrect(x_pred, K, res)
x_hat = x_pred + K * res;
end
