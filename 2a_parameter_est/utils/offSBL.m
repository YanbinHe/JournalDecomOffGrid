function [fin] = offSBL(y,H,rePre,prob,option)

time = 0;
middle      = rePre.middle;
updatecomp  = option.ratioOFF;
%% construct the new dictionary
N = size(H,2);yl = length(y);
%% initialization of hyperparameters
gamma = ones(N,1);nSq = 0.1*var(y);
%% initialization of iteration
norma = 1;itr  = 1;
while(itr < option.maxItr + 1 && norma > option.convergenceThres)
    
    tic;
    gamma_old = gamma;

    % e-step
    invPhic = H'* (nSq * eye(size(H,1)) + H * (gamma .* H'))^-1 * H;
    Sigma_x = diag(gamma) - (gamma*gamma') .* invPhic;
    x_re = nSq^-1 * (Sigma_x * (H' * y));

    Lambda = real(diag(Sigma_x)) + abs(x_re).^2; % used in hyperparameter optimization

    %% m-step
    %% hyperparameter optimization
    gamma = Lambda;
    %% grid refinement
    [~,idx] = maxk(gamma,updatecomp); % need to be refined
    x_local = x_re(idx,:);
    M_temp = x_local * y';
    Sigma = x_local*x_local' + Sigma_x(idx,idx);
    diagSig = real(diag(Sigma));
    Sigma = Sigma - diag(diagSig);

    reg = produceBdRegion3(middle,idx,prob); % generate the solving region

    norm_dl = 1;
    itr_dl = 1;

    while(norm_dl > option.convergenceThresInner && itr_dl < option.maxItrInner)
        middle_old = middle;
        [H(:,idx),middle(idx,:)] = singleColUpdate2(H(:,idx),M_temp,Sigma,diagSig/2,reg,idx,prob,middle(idx,:));
        norm_dl = norm(middle - middle_old);
        itr_dl = itr_dl + 1;
    end
    %% updating noise variance
    temp = sum(ones(length(gamma_old),1) - gamma_old.^-1 .* diag(Sigma_x));
    nSq = (norm(y - H*x_re)^2 + nSq*real(temp))/yl;

    time = time + toc; % record time consumption

    norma = norm(gamma - gamma_old)/norm(gamma_old);

    itr = itr + 1;
end
% estimate the parameter
pruneCloseNeighbours;

xspec = abs(x_re).^2 + real(diag(Sigma_x));
[pksv,idx] = findpeaks(xspec);
[~,pksvposi] = maxk(pksv,prob.sLevel);
est_idx = idx(pksvposi);
fin.para = sort(middle(est_idx));

% estimate the sparse vector, depend on the direct estimate or the least square
fin.x = x_re;
fin.middle = middle;
fin.time = time;
%% for debugging
fin.debug.gamma = gamma;
fin.debug.reg = reg;
fin.debug.x_re = x_re;
fin.debug.cov = Sigma_x;
fin.debug.nSq = nSq;
fin.debug.xspec = abs(x_re).^2 + real(diag(Sigma_x));
end
