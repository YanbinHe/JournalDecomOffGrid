function [finOFF,finOG,finGLLS,finOGSBI] = corr_sys1(yten,A,prob,option)
sys = 1;
prob.sys = sys;
prob.sLevel = prob.sLevelsysm;
%% initialization
prob.l = -1;prob.r = 1;
res.middle = linspace(prob.l,prob.r-(prob.r-prob.l)/prob.dimNsys1,prob.dimNsys1)';
res.reg = produceBdRegion(res.middle);
prob.resolution = abs(res.reg(3)-res.reg(2));
y = yten{sys};
prob.m = prob.K2;prob.dimN = prob.dimNsys1;option.maxItr = option.maxItrsys1;
%% off-grid
finOFF = offSBL(y,A{sys,1},res,prob,option);
%% on grid
finOG = onSBL(y,A{sys,2},prob,res.middle,option);
%% LWSSBL
finGLLS = GLLWSSBL(y,A{sys,3},res.middle,option,prob);
%% OGSBI
Hgd = generate_colFuncsgradient(prob,res.middle);
finOGSBI = runOGSBI(y,A{sys,4},Hgd,prob,option,res.middle);
end