function [fin] = GLLWSSBL(y,A,u,option,prob)
% LWSeq. SBL
% Original code is from https://github.com/rohanpote/LWS-SBL
% Please cite the following paper if you find this code useful

% R. R. Pote and B. D. Rao, "Light-Weight Sequential SBL Algorithm: 
% An Alternative to OMP," ICASSP 2023 - 2023 IEEE International Conference 
% on Acoustics, Speech and Signal Processing (ICASSP), Rhodes Island, 
% Greece, 2023, pp. 1-5, doi: 10.1109/ICASSP49357.2023.10096051.

[m,n] = size(A);

% suppsize = option.ratioGLLW; % the number of components to be updated

switch prob.sys
    case 1
        suppsize = option.ratioGLLW;
    otherwise
        suppsize = option.ratioGLLWelse;
end


switch prob.sys
    case 1
        lambda_n = 1e-6;
    otherwise
        lambda_n=0.1*var(y);
end


%% GridLess(GL)-LWS-SBL: LWS-SBL (Lambda set to w_var here)+Grid refinement
% Dimension Reduction

[~,~,gamma_est,compute_time]=LightWeightSeqSBL(y,A,lambda_n,suppsize);

% Grid refinement
tic;
[gamma_est,u_grid_updated,Agrid_updated]=gridPtAdjPks(gamma_est,suppsize,u,A,(0:m-1),m,y*y',lambda_n,prob);
time = toc;

% estimate the parameter
[~,est_idx] = maxk(gamma_est,prob.sLevel);
fin.para = sort(u_grid_updated(est_idx));

% use least square with the estimated support
[keeplist] = find(gamma_est > 0);
keeplist = sort(keeplist);
Hset = Agrid_updated(:,keeplist);
xset = pinv(Hset)*y;
x_re = zeros(n,1);
x_re(keeplist) = xset;  
fin.x = x_re;
fin.middle = u_grid_updated;
fin.time = time + compute_time;

%% for debugging
fin.debug.gamma_est = gamma_est;
fin.debug.x_re = x_re;
fin.debug.xspec = abs(x_re).^2;
end