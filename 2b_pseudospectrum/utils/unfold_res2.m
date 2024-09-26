est_unknown(1,avg,s,k,2) = (OFF2.para - AoD_ms)^2;
if abs(OFF2.para - AoD_ms) < option.thresDetect
    detect_track(1,avg,s,k,2) = 1;
end
time(1,avg,s,k,2) = OFF2.time;

est_unknown(2,avg,s,k,2) = (OG2.para - AoD_ms)^2;
if abs(OG2.para - AoD_ms) < option.thresDetect
    detect_track(2,avg,s,k,2) = 1;
end
time(2,avg,s,k,2) = OG2.time;

est_unknown(3,avg,s,k,2) = (GLLS2.para - AoD_ms)^2;
if abs(GLLS2.para - AoD_ms) < option.thresDetect
    detect_track(3,avg,s,k,2) = 1;
end
time(3,avg,s,k,2) = GLLS2.time;

est_unknown(4,avg,s,k,2) = (OGSBI2.para - AoD_ms)^2;
if abs(OGSBI2.para - AoD_ms) < option.thresDetect
    detect_track(4,avg,s,k,2) = 1;
end
time(4,avg,s,k,2) = OGSBI2.time;
