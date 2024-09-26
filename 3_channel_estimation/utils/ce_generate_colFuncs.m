function array_res = ce_generate_colFuncs(prob,angle)
% generate the array response of the antenna array
% dim: dimension of the vector
% angle: AoA or AoD

IRS = prob.IRS;
switch prob.sys
    case 1
        dim = prob.irs_ele;
        array_res = prob.scale(prob.sys)*IRS.'*generate_steering(dim,angle)/sqrt(dim);
    case 2
        dim = prob.ms_ante;
        array_res = generate_steering(dim,angle);
        array_res = conj(array_res)/prob.scale(prob.sys);
    case 3
        dim = prob.bs_ante;
        array_res = generate_steering(dim,angle)/prob.scale(prob.sys);
end
end

