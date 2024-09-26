function [result] = runOGSBI(Y,A,B,prob,option,grid)

M = prob.m;
K = prob.sLevel;
N = length(grid);

params.Y = Y;
params.A = A;
params.B = B;
params.resolution = abs(grid(2) - grid(1));

params.rho = 1e-2;
params.alpha = mean(abs(A'*params.Y), 2);
params.beta = zeros(N,1);
params.K = K;

params.maxiter = option.maxItr;
params.tolerance = option.convergenceThres;
params.sigma2 = mean(var(params.Y))/100;

params.option = option;
params.prob = prob;

result = OGSBI(params);
result.middle = grid + result.beta;
result.grid = grid;
%%
result.x = result.x;
result.xspec= abs(result.x).^2 + real(diag(result.Sigma_x));

[pksv,idx] = findpeaks(result.xspec);
[~,pksvposi] = maxk(pksv,prob.sLevel);
est_idx = idx(pksvposi);
result.para = sort(result.middle(est_idx));
end
