% arrange simulation results
est_unknown(1,avg,s,1) = estError(AoIRS,OFF1.para);
detect_track(1,avg,s,1) = 1*(est_unknown(1,avg,s,1)<1e-6);
time(1,avg,s,1) = OFF1.time;

est_unknown(2,avg,s,1) = estError(AoIRS,OG1.para);
detect_track(2,avg,s,1) = 1*(est_unknown(2,avg,s,1)<1e-6);
time(2,avg,s,1) = OG1.time;

est_unknown(3,avg,s,1) = estError(AoIRS,GLLS1.para);
detect_track(3,avg,s,1) = 1*(est_unknown(3,avg,s,1)<1e-6);
time(3,avg,s,1) = GLLS1.time;

est_unknown(4,avg,s,1) = estError(AoIRS,OGSBI1.para);
detect_track(4,avg,s,1) = 1*(est_unknown(4,avg,s,1)<1e-6);
time(4,avg,s,1) = OGSBI1.time;
