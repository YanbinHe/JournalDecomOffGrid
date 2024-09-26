function array_res = generate_steering(dim,angle)
% generate the array response of the antenna array
% dim: dimension of the vector
% angle: AoA or AoD
array_res=sqrt(1/dim)*exp(1j*pi*(0:(dim-1))'*angle');
end

