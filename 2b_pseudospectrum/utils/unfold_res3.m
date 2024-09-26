est_unknown(1,avg,s,3) = (OFF3.para - AoA_bs)^2;
if abs(OFF3.para - AoA_bs) < option.thresDetect
    detect_track(1,avg,s,3) = 1;
end
time(1,avg,s,3) = OFF3.time;

est_unknown(2,avg,s,3) = (OG3.para - AoA_bs)^2;
if abs(OG3.para - AoA_bs) < option.thresDetect
    detect_track(2,avg,s,3) = 1;
end
time(2,avg,s,3) = OG3.time;

est_unknown(3,avg,s,3) = (GLLS3.para - AoA_bs)^2;
if abs(GLLS3.para - AoA_bs) < option.thresDetect
    detect_track(3,avg,s,3) = 1;
end
time(3,avg,s,3) = GLLS3.time;

est_unknown(4,avg,s,3) = (OGSBI3.para - AoA_bs)^2;
if abs(OGSBI3.para - AoA_bs) < option.thresDetect
    detect_track(4,avg,s,3) = 1;
end
time(4,avg,s,3) = OGSBI3.time;