%% simluation on the SBL based IRS channel estimation with angle spread
% predefined values
% with prob struct, you can store all the values related to problem itself
prob.ms_ante      = 6; % the number of antennas at user equippment side
prob.bs_ante      = 16; % the number of antennas at bs
prob.irs_ele      = 16^2; % the number of irs elements

% the number of atoms in the first dicitionay, due to the condition of the
% first dictionary, this value should be large
prob.dimNsys1    = 180;
% the number of atoms in the second and third dictionary
prob.dimNoff     = 50;
prob.dimNlw      = 150;
prob.dimNogsbi   = 150;
prob.dimNon      = 150;

prob.scale        = [1,1,1];
% some constants
timeslots         = 1e6;
modulating_scheme = 16;
AVG               = 50;
SNR               = -5:5:20; % in dB
est_unknown       = zeros(4,AVG,length(SNR),3);
detect_track      = zeros(4,AVG,length(SNR),3);
time              = zeros(4,AVG,length(SNR),3);
est_track         = zeros(4,AVG,length(SNR));

regsys1 = generateSubintervals(-1,1,prob.dimNsys1);
anglesys1 = generateMiddlePoints(regsys1);% 180

regoff = generateSubintervals(-1,1,prob.dimNoff);
angleoff = generateMiddlePoints(regoff);% 50

regon = generateSubintervals(-1,1,prob.dimNon);
angleon = generateMiddlePoints(regon);% 150

reglw = generateSubintervals(-1,1,prob.dimNlw);
anglelw = generateMiddlePoints(reglw);% 50

regogsbi = generateSubintervals(-1,1,prob.dimNogsbi);
angleogsbi = generateMiddlePoints(regogsbi);% 150

prob.sLevelsysm              = 3;
prob.sLevelelse              = 1;
% options
option.maxItrsys1            = 200;
option.maxItrelse            = 200;
option.maxItrInner           = 10;
option.convergenceThres      = 1e-4;
option.convergenceThresInner = 1e-4;
option.spread1               = 3;
option.spread2               = 1;
option.ratioOFF              = 5;
option.ratioGLLW             = 5;
option.ratioOGSBI            = 5;
option.ratioOFFelse          = 1;
option.ratioGLLWelse         = 1;
option.ratioOGSBIelse        = 1;
option.mode                  = 2;
option.thresDetect           = 1e-3;
% dictionary generation
A2off     = generate_steering(prob.bs_ante,angleoff);
A1off     = generate_steering(prob.ms_ante,angleoff);

A2on      = generate_steering(prob.bs_ante,angleon);
A1on      = generate_steering(prob.ms_ante,angleon);

A2lw      = generate_steering(prob.bs_ante,anglelw);
A1lw      = generate_steering(prob.ms_ante,anglelw);

A2ogsbi   = generate_steering(prob.bs_ante,angleogsbi);
A1ogsbi   = generate_steering(prob.ms_ante,angleogsbi);

A_irs_d = generate_steering(prob.irs_ele,anglesys1);
A_irs_a = generate_steering(prob.irs_ele,anglesys1);

A = cell(3,4);
% dictionaries generate
A{3,1} = A2off;A{3,2} = A2on;A{3,3} = A2lw;A{3,4} = A2ogsbi;

symbolmatrix = repmat((qammod((0:modulating_scheme-1)', modulating_scheme)),1,timeslots);