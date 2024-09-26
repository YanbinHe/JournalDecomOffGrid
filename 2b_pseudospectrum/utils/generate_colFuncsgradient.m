function array_gd = generate_colFuncsgradient(prob,angle)
% generate the gradient of the dictionary for OGSBI
% dim: dimension of the vector
% middle: dictionary 

switch prob.sys
    case 1
        IRS = prob.IRS;
        dim = prob.irs_ele;
        coef_vec = 1i * pi * [0:1:(dim-1)].';
        array_gd = prob.scale(prob.sys)*IRS.'*(coef_vec.*generate_steering(dim,angle));
    case 2
        X = prob.X;
        dim = prob.ms_ante;coef_vec = -1i * pi * [0:1:(dim-1)].';
        array_gd = generate_steering(dim,angle);
        array_gd = X.'*(coef_vec.*conj(array_gd))/prob.scale(prob.sys);
    case 3
        dim = prob.bs_ante;coef_vec = 1i * pi * [0:1:(dim-1)].';
        array_gd = (coef_vec.*generate_steering(dim,angle))/prob.scale(prob.sys);
end
end

