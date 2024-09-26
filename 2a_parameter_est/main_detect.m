clc;
close all;
clear;

rng(exp(pi))
addpath ./utils/

%% simluation on different dictionaries
% predefined values
% with prob struct, you can store all the values related to problem itself
prob.irs_ele      = 16^2; % the number of irs elements
K2                = 20:5:50;
% the number of atoms in the first dicitionay, due to the condition of the
% first dictionary, this value should be large
prob.dimNoff     = 180;
prob.dimNon      = 180;
prob.dimNgl      = 180;
prob.dimNsbi     = 180;
prob.unknown     = 6;

prob.scale        = [1,1,1];
% some constants
AVG               = 1000;
SNR               = 5:5:30; % in dB
SNR_10            = 10.^(SNR/10);

regoff = generateSubintervals(-1,1,prob.dimNoff);
angleoff = generateMiddlePoints(regoff);
regon = generateSubintervals(-1,1,prob.dimNon);
angleon = generateMiddlePoints(regon);
reggl = generateSubintervals(-1,1,prob.dimNgl);
anglegl = generateMiddlePoints(reggl);
regsbi = generateSubintervals(-1,1,prob.dimNsbi);
anglesbi = generateMiddlePoints(regsbi);

prob.sLevel                  = prob.unknown;
% options
option.maxItrsys1            = 200;
option.maxItrelse            = 200;
option.maxItrInner           = 10;
option.convergenceThres      = 1e-4;
option.convergenceThresInner = 1e-4;
option.ratioOFF              = 8;
option.ratioGLLW             = 8;
option.ratioOGSBI            = 8;
option.thresDetect           = 1e-3;
% dictionary generation

A = cell(1,4);
% dictionaries generate
%% generate signal
for avg = 1:AVG
    avg
    %% case 1
    error_track       = zeros(4,length(K2),length(SNR));
    detect_track      = zeros(4,length(K2),length(SNR));
    time              = zeros(4,length(K2),length(SNR));
    param1 = generateRandomPointsInRange(prob.unknown,[-0.9,0.9],0.1,1.5);  %sort([generaterandompoint(-0.5,-0.3);generaterandompoint(0.3,0.5);generaterandompoint(-0.1,0.1)]);
    IRS_all = generate_complex_matrix(prob.irs_ele,max(K2));
    for k2 = 1:length(K2)
        % generate the first dictionary and test all the algorithms
        prob.K2 = K2(k2);IRS = IRS_all(:,1:prob.K2);prob.IRS = IRS;
        A{1,1} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNoff,prob.dimNoff)');
        A{1,2} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNon,prob.dimNon)');
        A{1,3} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNgl,prob.dimNgl)');
        A{1,4} = IRS.'*generate_steering(prob.irs_ele,linspace(-1,1-2/prob.dimNsbi,prob.dimNsbi)');

        % signal 1
        H_p1_signal = IRS.'*generate_steering(prob.irs_ele,param1);
        y1_clean = H_p1_signal * (randn(prob.unknown,1) + 1i*randn(prob.unknown,1));
        signalPower1 = norm(y1_clean)^2/length(y1_clean);
        for s = 1:length(SNR)
            nSq1 = signalPower1/(10^(SNR(s)/10));
            noise1 = sqrt(nSq1)*1/sqrt(2) *(randn(size(y1_clean)) + 1i*randn(size(y1_clean)));
            y1 = y1_clean + noise1;
            %% correction for the first system
            [OFF1,OG1,GLLS1,OGSBI1] = corr_sys1(y1,A,prob,option);
            %% track error
            error_track(1,k2,s) = estError(param1,OFF1.para);detect_track(1,k2,s) = (error_track(1,k2,s)<1e-6)*1;time(1,k2,s) = OFF1.time;
            error_track(2,k2,s) = estError(param1,OG1.para);detect_track(2,k2,s) = (error_track(2,k2,s)<1e-6)*1;time(2,k2,s) = OG1.time;
            error_track(3,k2,s) = estError(param1,GLLS1.para);detect_track(3,k2,s) = (error_track(3,k2,s)<1e-6)*1;time(3,k2,s) = GLLS1.time;
            error_track(4,k2,s) = estError(param1,OGSBI1.para);detect_track(4,k2,s) = (error_track(4,k2,s)<1e-6)*1;time(4,k2,s) = OGSBI1.time;
        end
    end

    filename = ['./results2/simu_result_', num2str(avg),'.mat'];
    save(filename,'error_track','detect_track','time');
end