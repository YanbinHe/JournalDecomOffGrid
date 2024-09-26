clc;
close all;
clear;

rng(pi)
addpath ./utils/

%% simluation on different dictionaries
% predefined values
% with prob struct, you can store all the values related to problem itself
prob.irs_ele      = 16^2; % the number of irs elements
K2                = 60;
AVG               = 10;
% the number of atoms in the first dicitionay, due to the condition of the
% first dictionary, this value should be large
prob.dimNoff     = 180;
prob.dimNon      = 180;
prob.dimNgl      = 180;
prob.dimNsbi     = 180;
prob.unknown     = 4;

prob.scale        = [1,1,1];
% some constants
SNR               = 40; % in dB
SNR_10            = 10.^(SNR/10);

prob.sLevel                  = prob.unknown;
% options
option.maxItrsys1            = 1000;
option.maxItrelse            = 1000;
option.maxItrInner           = 10;
option.convergenceThres      = 0;
option.convergenceThresInner = 1e-4;
option.ratioOFF              = 4;
option.ratioGLLW             = 4;
option.ratioOGSBI            = 4;
option.thresDetect           = 1e-3;
% dictionary generation

A = cell(1,4);
gammaTrackOff = cell(2,AVG);
gammaTrackON = cell(2,AVG);
gammaTrackGLLS = cell(2,AVG);
gammaOGSBI = cell(2,AVG);
%% generate signal
%% case 1
param1 = [-0.5050;-0.1050;0.1050;0.5050];
for avg = 1:AVG
    IRS_all = generate_complex_matrix(prob.irs_ele,max(K2));
    k2 = 1;
    % generate the first dictionary and test all the algorithms
    prob.K2 = K2(k2);IRS = IRS_all(:,1:prob.K2);prob.IRS = IRS;
    A{1,1} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNoff,prob.dimNoff)');
    A{1,2} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNon,prob.dimNon)');
    A{1,3} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNgl,prob.dimNgl)');
    A{1,4} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNsbi,prob.dimNsbi)');

    % signal 1
    H_p1_signal = IRS.'*generate_steering(prob.irs_ele,param1);
    y1_clean = H_p1_signal * ones(prob.unknown,1);%(randn(prob.unknown,1) + 1i*randn(prob.unknown,1));
    signalPower1 = norm(y1_clean)^2/length(y1_clean);
    s = 1;
    nSq1 = signalPower1/(10^(SNR(s)/10));
    noise1 = sqrt(nSq1)*1/sqrt(2) *(randn(size(y1_clean)) + 1i*randn(size(y1_clean)));
    y1 = y1_clean + noise1;
    %% correction for the first system
    [OFF1,OG1,GLLS1,OGSBI1] = corr_sys1(y1,A,prob,option);
    %% track error
    error_track(1,avg) = estError(param1,OFF1.para);gammaTrackOff{1,avg} = OFF1.track_gamma;gammaTrackOff{2,avg} = OFF1.track_middle;
    error_track(2,avg) = estError(param1,OG1.para);gammaTrackON{1,avg} = OG1.track_gamma;gammaTrackON{2,avg} = OG1.track_middle;
    error_track(3,avg) = estError(param1,GLLS1.para);gammaTrackGLLS{1,avg} = GLLS1.debug.gamma_est;gammaTrackGLLS{2,avg} = GLLS1.middle;
    error_track(4,avg) = estError(param1,OGSBI1.para);gammaOGSBI{1,avg} = OGSBI1.track_gamma;gammaOGSBI{2,avg} = OGSBI1.track_middle;
end

save spectrum_case2.mat