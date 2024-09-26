% arrange simulation results
est_unknown(1,avg,s,3) = estError(AoA_bs,OFF3.para);
detect_track(1,avg,s,3) = 1*(est_unknown(1,avg,s,3)<1e-6);
time(1,avg,s,3) = OFF3.time;

est_unknown(2,avg,s,3) = estError(AoA_bs,OG3.para);
detect_track(2,avg,s,3) = 1*(est_unknown(2,avg,s,3)<1e-6);
time(2,avg,s,3) = OG3.time;

est_unknown(3,avg,s,3) = estError(AoA_bs,GLLS3.para);
detect_track(3,avg,s,3) = 1*(est_unknown(3,avg,s,3)<1e-6);
time(3,avg,s,3) = GLLS3.time;

est_unknown(4,avg,s,3) = estError(AoA_bs,OGSBI3.para);
detect_track(4,avg,s,3) = 1*(est_unknown(4,avg,s,3)<1e-6);
time(4,avg,s,3) = OGSBI3.time;