function [finOFF,finOG,finGLLS,finOGSBI] = corr_sys2(yten,A,prob,option)
sys = 2;
prob.sys = sys;
prob.sLevel = prob.sLevelelse;option.maxItr = option.maxItrelse;
%% initialization
prob.l = -1;prob.r = 1;prob.m = prob.K1;y = yten{sys};
%% off-grid
prob.dimN = prob.dimNoff;
res.reg = generateSubintervals(prob.l,prob.r,prob.dimN);
prob.resolution = abs(res.reg(2)-res.reg(1));
res.middle = generateMiddlePoints(res.reg);
H = A{sys,1};
finOFF = offSBL(y,H,res,prob,option);
%% on grid
prob.dimN = prob.dimNon;
res.reg = generateSubintervals(prob.l,prob.r,prob.dimN);
prob.resolution = abs(res.reg(2)-res.reg(1));
res.middle = generateMiddlePoints(res.reg);
H = A{sys,2};
finOG = onSBL(y,H,prob,res.middle,option);
%% LWSSBL
prob.dimN = prob.dimNlw;
res.reg = generateSubintervals(prob.l,prob.r,prob.dimN);
prob.resolution = abs(res.reg(2)-res.reg(1));
res.middle = generateMiddlePoints(res.reg);
H = A{sys,3};
finGLLS = GLLWSSBL(y,H,res.middle,option,prob);
%% OGSBI
prob.dimN = prob.dimNogsbi;
res.reg = generateSubintervals(prob.l,prob.r,prob.dimN);
prob.resolution = abs(res.reg(2)-res.reg(1));
res.middle = generateMiddlePoints(res.reg);
H = A{sys,4};
Hgd = generate_colFuncsgradient(prob,res.middle);
finOGSBI = runOGSBI(y,H,Hgd,prob,option,res.middle);
end