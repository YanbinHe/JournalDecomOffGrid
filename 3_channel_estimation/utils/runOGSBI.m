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
%% generate dictionaries for channel estimation using A + B diag(beta)
A = ce_generate_colFuncs(prob,result.grid);
B = ce_generate_colFuncsgradient(prob,result.grid);
result.dict = A + B * diag(result.beta);
%%
if prob.sys == 3
    mode = 1;
else
    mode = 2;
end
switch mode
    case 1
        [keeplist] = find(result.gamma > max(result.gamma)*1e-2);
        keeplist = sort(keeplist);
        Hset = result.A(:,keeplist);
        xset = pinv(Hset)*Y;
        x_re = zeros(length(result.gamma),1);
        x_re(keeplist) = xset;
        result.x = x_re;
    case 2
        result.x = result.x;
end
result.xspec= abs(result.x).^2 + real(diag(result.Sigma_x));
[~,idx] = maxk(result.gamma,prob.sLevel);
result.para = sort(result.middle(idx));
end
