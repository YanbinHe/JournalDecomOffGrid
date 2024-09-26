% Default values for configurations
addpath('./functions') 
%%
% fix random seed
rng(pi)

N = 12; % the dimension of sparse vector
M1 = 8:1:11;
M2 = 8:1:11; % the number of measurements per sparse vector
M3 = 8:1:11;
K = 4;
SNR = [5,10,15,20,25,30]; % SNR values
SNR_10 = 10.^(SNR/10);
AVG = 50; % the number of trials

R_max = 200; % the maximum number of iterations for SBL/KroSBL
result = [];
epi = 0.001;
