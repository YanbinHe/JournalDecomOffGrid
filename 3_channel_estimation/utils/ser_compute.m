function [serOFF,serOG,serGL,serOGSBI,errorOFF,errorOG,errorGL,errorOGSBI] = ser_compute(H_est,H_true,SNR,symbolmatrix,inPut,prob)

% H_est: estimated channel matrix (in the form of column vector)
% H_true: the true channel matrix (in the form of column vector)
% SNR: scenario snr in dB
% X: transmitted symbols (row vector)
% inPut: the true label of transmitting symbols
% symbolmatrix: #codes in codebook x timeslot

% We first generate a certain number of symbols x according to the
% variable sym. Then we transmit these symbols through the channel by
% multiplying them and obtain y. The detector T is designed by Linear MMSE 
% detector. The received symbols y_mmse are obtained by Ty. To reterive the
% symbols, we project the received symbols on the discrete constellation by
% computing the Euclidean distance.

ms_ante = prob.ms_ante;
bs_ante = prob.bs_ante;
K2 = prob.K2;
Xun = prob.Xun;
errorOFF = zeros(K2,1);errorOG = zeros(K2,1);errorGL = zeros(K2,1);errorOGSBI = zeros(K2,1);
SNR = 10^(SNR/10); % transformed to linear

for i = 1:K2
    Htrue = reshape(H_true(:,i),bs_ante,ms_ante);
    HestOFF = reshape(H_est{1}(:,i),bs_ante,ms_ante);
    HestOG = reshape(H_est{2}(:,i),bs_ante,ms_ante);
    HestGLLW = reshape(H_est{3}(:,i),bs_ante,ms_ante);
    HestOGSBI = reshape(H_est{4}(:,i),bs_ante,ms_ante);    
    
    % post-precess received signals
    [s,~,d] = svd(HestOFF);decoderOFF = s(:,1);precoderOFF = d(:,1);
    [s,~,d] = svd(HestOG);decoderOG = s(:,1);precoderOG = d(:,1);
    [s,~,d] = svd(HestGLLW);decoderGL = s(:,1);precoderGL = d(:,1);
    [s,~,d] = svd(HestOGSBI);decoderOGSBI = s(:,1);precoderOGSBI = d(:,1);

    YunOFF = Htrue*precoderOFF*(1/sqrt(ms_ante))*Xun;
    YunOG = Htrue*precoderOG*(1/sqrt(ms_ante))*Xun;
    YunGL = Htrue*precoderGL*(1/sqrt(ms_ante))*Xun;
    YunOGSBI = Htrue*precoderOGSBI*(1/sqrt(ms_ante))*Xun;

    noiseUni = (randn(size(YunOFF))+1i*randn(size(YunOFF))); % power is two

    signal_powerOFF = norm(vec(YunOFF))^2 / numel(YunOFF);sigmasqOFF = signal_powerOFF/SNR;
    signal_powerOG = norm(vec(YunOG))^2 / numel(YunOG);sigmasqOG = signal_powerOG/SNR;
    signal_powerGL = norm(vec(YunGL))^2 / numel(YunGL);sigmasqGL = signal_powerGL/SNR;
    signal_powerOGSBI = norm(vec(YunOGSBI))^2 / numel(YunOGSBI);sigmasqOGSBI = signal_powerOGSBI/SNR;

    Yoff = YunOFF + sqrt(sigmasqOFF / 2) * noiseUni;
    Yog = YunOG + sqrt(sigmasqOG / 2) * noiseUni; 
    Ygl = YunGL + sqrt(sigmasqGL / 2) * noiseUni; 
    Ysbi = YunOGSBI + sqrt(sigmasqOGSBI / 2) * noiseUni; 

    YreOFF = decoderOFF'*Yoff;
    YreOG = decoderOG'*Yog;
    YreGL = decoderGL'*Ygl;
    YreOGSBI = decoderOGSBI'*Ysbi;

    matcompareOFF = decoderOFF'*HestOFF*precoderOFF*(1/sqrt(ms_ante))*symbolmatrix;
    for j = 1:size(matcompareOFF,1)
        matcompareOFF(j,:) = matcompareOFF(j,:) - YreOFF;
    end
    [~,decode_sol_off] = min(abs(matcompareOFF),[],1);
    errorOFF(i) = length(find(decode_sol_off ~= (inPut+1)));

    matcompareOG = decoderOG'*HestOG*precoderOG*(1/sqrt(ms_ante))*symbolmatrix;
    for j = 1:size(matcompareOG,1)
        matcompareOG(j,:) = matcompareOG(j,:) - YreOG;
    end
    [~,decode_sol_og] = min(abs(matcompareOG),[],1);
    errorOG(i) = length(find(decode_sol_og ~= (inPut+1)));

    matcompareGL = decoderGL'*HestGLLW*precoderGL*(1/sqrt(ms_ante))*symbolmatrix;
    for j = 1:size(matcompareGL,1)
        matcompareGL(j,:) = matcompareGL(j,:) - YreGL;
    end
    [~,decode_sol_gl] = min(abs(matcompareGL),[],1);
    errorGL(i) = length(find(decode_sol_gl ~= (inPut+1)));

    matcompareOGSBI = decoderOGSBI'*HestOGSBI*precoderOGSBI*(1/sqrt(ms_ante))*symbolmatrix;
    for j = 1:size(matcompareOGSBI,1)
        matcompareOGSBI(j,:) = matcompareOGSBI(j,:) - YreOGSBI;
    end
    [~,decode_sol_sbi] = min(abs(matcompareOGSBI),[],1);
    errorOGSBI(i) = length(find(decode_sol_sbi ~= (inPut+1)));
end
serOFF = mean(errorOFF)/length(inPut);
serOG = mean(errorOG)/length(inPut);
serGL = mean(errorGL)/length(inPut);
serOGSBI = mean(errorOGSBI)/length(inPut);
end
