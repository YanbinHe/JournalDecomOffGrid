% arrange simulation results
est_unknown(1,avg,s,k,1) = (OFF1.para - AoIRS)^2;
if abs(OFF1.para - AoIRS) < option.thresDetect
    detect_track(1,avg,s,k,1) = 1;
end
time(1,avg,s,k,1) = OFF1.time;

est_unknown(2,avg,s,k,1) = (OG1.para - AoIRS)^2;
if abs(OG1.para - AoIRS) < option.thresDetect
    detect_track(2,avg,s,k,1) = 1;
end
time(2,avg,s,k,1) = OG1.time;

est_unknown(3,avg,s,k,1) = (GLLS1.para - AoIRS)^2;
if abs(GLLS1.para - AoIRS) < option.thresDetect
    detect_track(3,avg,s,k,1) = 1;
end
time(3,avg,s,k,1) = GLLS1.time;

est_unknown(4,avg,s,k,1) = (OGSBI1.para - AoIRS)^2;
if abs(OGSBI1.para - AoIRS) < option.thresDetect
    detect_track(4,avg,s,k,1) = 1;
end
time(4,avg,s,k,1) = OGSBI1.time;
