function [yten,time_deco] = decompose(prob,y)
dim1 = prob.K2;
dim2 = prob.K1;
dim3 = prob.bs_ante;

tic;
yten = cell(3,1);
mat1 = reshape(y,dim2*dim3,dim1);
[mat1l,mat1v,mat1r] = svd(mat1.');
yten{1} = mat1l(:,1);
mat2 = reshape(mat1v(1,1)*conj(mat1r(:,1)), dim3, dim2);
[mat2l,mat2v,mat2r] = svd(mat2.');
yten{2} = mat2l(:,1);
yten{3} = mat2v(1,1)*conj(mat2r(:,1));

% try to balance the power of each vector
% factor = norm(yten{3})^(1/3);
% yten{1} = yten{1}*factor;
% yten{2} = yten{2}*factor;
% yten{3} = yten{3}/factor^2;

time_deco = toc;
end