clc;
close all;
clear;

rng(exp(pi))
addpath ./utils/

%%

prob.K2 = 40; % the number of overhead w.r.t reflecting pattern
prob.K1 = 20; % the number of overhead w.r.t pilot signals
main_ce
%%
save resultexppi.mat


