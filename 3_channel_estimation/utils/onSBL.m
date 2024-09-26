function [fin] = onSBL(y,H,prob,middle,option)

time = 0;
%% construct the new dictionary
N = size(H,2);yl = length(y);
%% initialization of hyperparameters
gamma = ones(N,1);nSq = 0.1*var(y);
%% initialization of iteration
norma = 1;itr  = 1;
while(itr < option.maxItr + 1 && norma > option.convergenceThres)
    
    tic;
    gamma_old = gamma;

    %% e-step
    Gammac = diag(gamma);
    invPhic = H'* (nSq * eye(size(H,1)) + H * (gamma .* H'))^-1 * H;
    Sigma_x = Gammac - (gamma*gamma') .* invPhic;
    x_re = nSq^-1 * (Sigma_x * (H' * y));

    Lambda = real(diag(Sigma_x)) + abs(x_re).^2; % used in hyperparameter optimization

    %% m-step
    %% hyperparameter optimization
    gamma = Lambda;

    %% updating noise variance
    temp = sum(ones(length(gamma_old),1) - gamma_old.^-1 .* diag(Sigma_x));
    nSq = (norm(y - H*x_re)^2 + nSq*real(temp))/yl;
    %%
    time = time + toc; % record time consumption

    norma = norm(gamma - gamma_old)/norm(gamma_old);

    itr = itr + 1;
end

[~,est_idx] = maxk(abs(x_re).^2 + real(diag(Sigma_x)),prob.sLevel);
fin.para = sort(middle(est_idx));

switch option.mode
    case 1
        [keeplist] = find(gamma > max(gamma)*1e-2);
        keeplist = sort(keeplist);
        Hset = H(:,keeplist);
        xset = pinv(Hset)*y;
        x_re = zeros(N,1);
        x_re(keeplist) = xset;
        fin.x = x_re;
    case 2
        fin.x = x_re;
end
fin.middle = middle;
fin.time = time;
fin.gamma = gamma;
%% for debugging
fin.debug.cov = Sigma_x;
fin.debug.nSq = nSq;
fin.debug.xspec = abs(x_re).^2 + real(diag(Sigma_x));
end
