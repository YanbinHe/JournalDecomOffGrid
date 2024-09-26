function [fin] = onSBL(y,H,prob,middle,option)

time = 0;
updatecomp = option.ratioOGSBI;
%% construct the new dictionary
N = size(H,2);yl = length(y);
%% initialization of hyperparameters
gamma = ones(N,1);nSq = 0.1*var(y);
%% initialization of iteration
norma = 1;itr  = 1;
track_gamma = [];
track_middle = [];
track_idx = [];
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
    track_gamma = [track_gamma,gamma];
    track_middle = [track_middle,middle];

    [temp, idx] = sort(gamma, 'descend');
    idx = idx(1:updatecomp);
    track_idx = [track_idx,idx];

    %% updating noise variance
    temp = sum(ones(length(gamma_old),1) - gamma_old.^-1 .* diag(Sigma_x));
    nSq = (norm(y - H*x_re)^2 + nSq*real(temp))/yl;
    %%
    
    time = time + toc; % record time consumption

    norma = norm(gamma - gamma_old)/norm(gamma_old);

    itr = itr + 1;
end

xspec = abs(x_re).^2 + real(diag(Sigma_x));
[pksv,idx] = findpeaks(xspec); % need to be refined
[~,pksvposi] = maxk(pksv,prob.sLevel);
est_idx = idx(pksvposi);
fin.para = sort(middle(est_idx));

fin.x = x_re;
fin.middle = middle;
fin.time = time;
fin.track_gamma = track_gamma;
fin.track_middle = track_middle;
fin.track_idx = track_idx;
%% for debugging
fin.debug.gamma = gamma;
fin.debug.cov = Sigma_x;
fin.debug.nSq = nSq;
fin.debug.xspec = abs(x_re).^2 + real(diag(Sigma_x));
end
