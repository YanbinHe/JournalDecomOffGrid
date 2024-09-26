function array_res = generate_colFuncs(prob,angle)
% generate the array response of the antenna array
% dim: dimension of the vector
% angle: AoA or AoD

if prob.sys == 1
    IRS = prob.IRS;
    dim = prob.irs_ele;
    array_res = prob.scale(prob.sys)*IRS.'*generate_steering(dim,angle);
elseif prob.sys == 2
    X = prob.X;
    dim = prob.ms_ante;
    array_res = generate_steering(dim,angle);
    array_res = X.'*conj(array_res)/prob.scale(prob.sys);
elseif prob.sys == 3
    dim = prob.bs_ante;
    array_res = generate_steering(dim,angle)/prob.scale(prob.sys);
end
end

