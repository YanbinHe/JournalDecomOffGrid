%%
run("config.m");
%%
for avg = 1:AVG
    %% part 1: generate channel
    run("channel_realization.m");
    %%
    for s = 1:length(SNR)
        nSq = signalPower/(10^(SNR(s)/10));
        noise = sqrt(nSq)*1/sqrt(2) *(randn(size(y_noiseless)) + 1i*randn(size(y_noiseless)));
        ynoisy = y_noiseless + noise;
        %% part 2: channel estimation with different techniques and compute the symbol error rate
        %% generate searching region and decomposition
        [yten,time_deco] = decompose(prob,ynoisy);
        finOG = cell(3,1);
        finOFF = cell(3,1);
        finGLLS = cell(3,1);
        finOGSBI = cell(3,1);
        %% all algorithms
        %% correction for the first system
        [OFF1,OG1,GLLS1,OGSBI1] = corr_sys1(yten,A,prob,option);
        finOFF{1} = OFF1;finOG{1} = OG1;finGLLS{1} = GLLS1;finOGSBI{1} = OGSBI1;unfold_res1;
        %% correction for the second system
        [OFF2,OG2,GLLS2,OGSBI2] = corr_sys2(yten,A,prob,option);
        finOFF{2} = OFF2;finOG{2} = OG2;finGLLS{2} = GLLS2;finOGSBI{2} = OGSBI2;unfold_res2;
        %% correction for the third system
        [OFF3,OG3,GLLS3,OGSBI3] = corr_sys3(yten,A,prob,option);
        finOFF{3} = OFF3;finOG{3} = OG3;finGLLS{3} = GLLS3;finOGSBI{3} = OGSBI3;unfold_res3;
        %%
        [erOFF(avg,s),HreOFF] = ce_error(finOFF,prob,Htrue);est_track(1,avg,s) = 1*(erOFF(avg,s)<1e-3);
        [erOG(avg,s),HreOG] = ce_error(finOG,prob,Htrue);est_track(2,avg,s) = 1*(erOG(avg,s)<1e-3);
        [erGLLW(avg,s),HreGLLW] = ce_error(finGLLS,prob,Htrue);est_track(3,avg,s) = 1*(erGLLW(avg,s)<1e-3);
        [erOGSBI(avg,s),HreOGSBI] = ce_error(finOGSBI,prob,Htrue);est_track(4,avg,s) = 1*(erOGSBI(avg,s)<1e-3);
        %%
        Hest{1} = HreOFF;Hest{2} = HreOG;Hest{3} = HreGLLW;Hest{4} = HreOGSBI;
        [serOFF(avg,s),serOG(avg,s),serGLLW(avg,s),serOGSBI(avg,s),errorOFF,errorOG,errorGL,errorOGSBI] = ser_compute(Hest,Htrue,SNR(s),symbolmatrix,inPut,prob);
        %%
        status = '%d iteration, snr = %d (dB), error = %7.6e. LWSSBL error: %7.6e. On-grid error: %7.6e. OGSBI error: %7.6e.\n';
        fprintf(status, avg, SNR(s), serOFF(avg,s), serGLLW(avg,s), serOG(avg,s), serOGSBI(avg,s))
    end
end