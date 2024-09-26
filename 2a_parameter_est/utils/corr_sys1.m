function [finOFF,finOG,finGLLS,finOGSBI] = corr_sys1(y,A,prob,option)
sys = 1;
prob.sys = sys;option.maxItr = option.maxItrsys1;
%% initialization
prob.l = -1;prob.r = 1;prob.m = prob.K2;
%% off-grid
prob.dimN = prob.dimNoff;
res.middle = linspace(prob.l,prob.r-(prob.r-prob.l)/prob.dimN,prob.dimN)';
res.reg = produceBdRegion(res.middle);
prob.resolution = abs(res.reg(3)-res.reg(2));
finOFF = offSBL(y,A{1,1},res,prob,option);
%% on grid
prob.dimN = prob.dimNon;
res.middle = linspace(prob.l,prob.r-(prob.r-prob.l)/prob.dimN,prob.dimN)';
res.reg = produceBdRegion(res.middle);
prob.resolution = abs(res.reg(3)-res.reg(2));
finOG = onSBL(y,A{1,2},prob,res.middle,option);
%% LWSSBL
prob.dimN = prob.dimNgl;
res.middle = linspace(prob.l,prob.r-(prob.r-prob.l)/prob.dimN,prob.dimN)';
res.reg = produceBdRegion(res.middle);
prob.resolution = abs(res.reg(3)-res.reg(2));
finGLLS = GLLWSSBL(y,A{1,3},res.middle,option,prob);
%% OGSBI
prob.dimN = prob.dimNsbi;
res.middle = linspace(prob.l,prob.r-(prob.r-prob.l)/prob.dimN,prob.dimN)';
res.reg = produceBdRegion(res.middle);
prob.resolution = abs(res.reg(3)-res.reg(2));
Hgd = generate_colFuncsgradient(prob,res.middle);
finOGSBI = runOGSBI(y,A{1,4},Hgd,prob,option,res.middle);
end