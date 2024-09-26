% generate channel realization
% here the angles should be OFF GRID

AoD_ms  = generaterandompoint(0.3,0.5);
vAoDm = generate_steering(prob.ms_ante,AoD_ms);
AoA_irs = generaterandompoint(-0.2,0.2);
vAoAi = generate_steering(prob.irs_ele,AoA_irs);
AoD_irs = generaterandompoint(0.3,0.5);
vAoDi = generate_steering(prob.irs_ele,AoD_irs);
AoA_bs = generaterandompoint(0,0.5);
vAoAb = generate_steering(prob.bs_ante,AoA_bs);
AoIRS = AoA_irs-AoD_irs;
%%
% path gain CN(0,1)
alpha_mi = (1*randn(option.spread1,1) + 1i*randn(option.spread1,1))/sqrt(2); % from ms to irs
alpha_ib = (1*randn(option.spread2,1) + 1i*randn(option.spread2,1))/sqrt(2); % from irs to bs

H2 = sqrt(prob.bs_ante*prob.irs_ele)*vAoAb*alpha_ib*vAoDi';
H1 = sqrt(prob.ms_ante*prob.irs_ele)*vAoAi*alpha_mi*vAoDm';

% generate pilot signals, irs pattern, and transmitted symbol
X = 1/sqrt(prob.ms_ante)*pilot_gen(prob.ms_ante,max(prob.K1));
IRS = 1/sqrt(prob.irs_ele)*generate_complex_matrix(prob.irs_ele,max(prob.K2));

% regulate IRS matrix
% make sure that somehow the irs should point to the receiver, otherwise
% the received signal is too weak. But this is only for the simulation.
% This is not the case when it comes to real world!
for i = 1:max(prob.K2)
    Htrue(:,i) = vec(H2*diag(IRS(:,i))*H1);
    while norm(Htrue(:,i),'fro') < 1e-5
        IRS(:,i) = 1/sqrt(prob.irs_ele)*generate_complex_matrix(prob.irs_ele,1);
        Htrue(:,:,i) = vec(H2*diag(IRS(:,i))*H1);
    end
end

prob.IRS = IRS;prob.X = X;

% generate the first dictionary
H_p1 = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNsys1,prob.dimNsys1)')/sqrt(prob.irs_ele);
A{1,1} = H_p1;A{1,2} = H_p1;A{1,3} = H_p1;A{1,4} = H_p1;
A{2,1} = X.'*conj(A1off);A{2,2} = X.'*conj(A1on);A{2,3} = X.'*conj(A1lw);A{2,4} = X.'*conj(A1ogsbi);

% generate signal
y_bar = kr(X.'*H1.',H2)*IRS;
signalPower = norm(vec(y_bar))^2/length(vec(y_bar)); %average signal power per symbol
y_noiseless = vec(y_bar(1:prob.K1*prob.bs_ante,1:prob.K2));
inPut = randi([0, modulating_scheme-1], 1, timeslots);
Xun = pskmod(inPut, modulating_scheme);prob.Xun = Xun;