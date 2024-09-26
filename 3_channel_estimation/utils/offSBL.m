function [fin] = offSBL(y,H,rePre,prob,option)

time = 0;
middle      = rePre.middle;
switch prob.sys
    case 1
        updatecomp = option.ratioOFF;
    otherwise
        updatecomp = option.ratioOFFelse;
end
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
    idx = find_top_peaks(gamma,updatecomp);
    x_local = x_re(idx,:);
    M_temp = x_local * y';
    Sigma = x_local*x_local' + Sigma_x(idx,idx);
    diagSig = real(diag(Sigma));
    Sigma = Sigma - diag(diagSig);
    
    reg = produceBdRegion3(middle,idx,prob); % re-generate the solving region
    
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
% 
% estimate the parameter
[~,est_idx] = maxk(abs(x_re).^2 + real(diag(Sigma_x)),prob.sLevel);
fin.para = sort(middle(est_idx));

% estimate the sparse vector, depend on the direct estimate or the least square
if prob.sys == 3
    mode = 1;
else
    mode = 2;
end
switch mode
    case 1
        pruneCloseNeighbours;
        [keeplist] = find(gamma > max(gamma)*1e-2);
        keeplist = sort(keeplist);
        Hset = H(:,keeplist);
        xset = pinv(Hset)*y;
        x_re = zeros(length(gamma),1);
        x_re(keeplist) = xset;
        fin.x = x_re;
    case 2
        fin.x = x_re;
end
fin.middle = middle;
fin.time = time;
fin.gamma = gamma;
%% for debugging
fin.debug.reg = reg;
fin.debug.x_re = x_re;
fin.debug.cov = Sigma_x;
fin.debug.nSq = nSq;
fin.debug.xspec = abs(x_re).^2 + real(diag(Sigma_x));
end
