function res = OGSBI(paras)

eps = 1e-16;

Y = paras.Y;
A = paras.A;
B = paras.B;

[M, T] = size(Y);
N = size(A, 2);

alpha0 = 1 / paras.sigma2;
rho = paras.rho / T;
beta = paras.beta;
alpha = paras.alpha;
r = paras.resolution;

maxiter = paras.maxiter;
tol = paras.tolerance;

a = 1e-4;
b = 1e-4;

K = paras.K;

switch paras.prob.sys
    case 1
        updatecomp = paras.option.ratioOGSBI;
    otherwise
        updatecomp = paras.option.ratioOGSBIelse;
end

idx = [];
BHB = B' * B;
converged = false;
iter_beta = 10;
iter = 0;
time = 0;

while ~converged
    tic;
    iter = iter + 1;
    
    Phi = A;
    Phi(:,idx) = A(:,idx) + B(:,idx) * diag(beta(idx));
    
    alpha_last = alpha;
    
    C = 1 / alpha0 * eye(M) + Phi * diag(alpha) * Phi';
    Cinv = inv(C);
    Sigma = diag(alpha) - diag(alpha) * Phi' * Cinv * Phi * diag(alpha);
    mu = alpha0 * Sigma * Phi' * Y;


    gamma1 = 1 - real(diag(Sigma)) ./ (alpha + eps);
    
    % update alpha
    musq = abs(mu).^2;

    alpha = musq + real(diag(Sigma));
    if rho ~= 0
        alpha = -.5 / rho + sqrt(.25 / rho^2 + alpha / rho);
    end

    % update alpha0
    resid = Y - Phi * mu;
    alpha0 = (T * M + a - 1) / (norm(resid, 'fro')^2 + T / alpha0 * sum(gamma1) + b);
    
    % stopping criteria
    if norm(alpha - alpha_last)/norm(alpha_last) < tol || iter >= maxiter
        converged = true;
        iter_beta = 1; % we change this because if converged = true, we only update beta but not mu in the same time. Therefore it causes wrong estimation of mu.
    end

    % update beta
    [temp, idx] = sort(alpha, 'descend');
    idx = idx(1:updatecomp);

    temp = beta;
    beta = zeros(N,1);
    beta(idx) = temp(idx);
      
    P = real(conj(BHB(idx,idx)) .* (mu(idx,:) * mu(idx,:)' + T * Sigma(idx,idx)));
    v = zeros(length(idx), 1);
    for t = 1:T
        v = v + real(conj(mu(idx,t)) .* (B(:,idx)' * (Y(:,t) - A * mu(:,t))));
    end
    v = v - T * real(diag(B(:,idx)' * A * Sigma(:,idx)));
    temp1 = P \ v;
    if any(abs(temp1) > r/2) || any(diag(P) == 0)
        for i = 1:iter_beta
            for n = 1:updatecomp
                temp_beta = beta(idx);
                temp_beta(n) = 0;
                beta(idx(n)) = (v(n) - P(n,:) * temp_beta) / P(n,n);
                if beta(idx(n)) > r/2
                    beta(idx(n)) = r/2;
                end
                if beta(idx(n)) < -r/2
                    beta(idx(n)) = -r/2;
                end
                if P(n,n) == 0
                    beta(idx(n)) = 0;
                end
            end
        end
    else
        beta = zeros(N,1);
        beta(idx) = temp1;
    end  
    time = time + toc;
end

res.x = mu;
res.Sigma_x = Sigma;
res.beta = beta;
res.gamma = alpha;
res.time = time;
res.A = A + B * diag(beta);
res.sigma2 = 1/alpha0;
end
