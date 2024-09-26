%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Clear previous work
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all;
clc;

%%% Import default configurations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Run the configuration script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('Configuration.m')


m = 3;

M1_loc = M1(m);
M2_loc = M2(m);
M3_loc = M3(m);
% generate measuring dictionaries
A1 = generate_dict(M1_loc,N);
A2 = generate_dict(M2_loc,N);
A3 = generate_dict(M3_loc,N);

for s = 1:length(SNR)
    SNR_loc = SNR(s);

    for avg = 1:AVG

        x1 = zeros(N,1);
        x2 = zeros(N,1);
        x3 = zeros(N,1);

        % generate sparse vectors
        supp1 = randsample(1:N, K);
        x1(supp1) = rand(K,1)+0.5;
        supp2 = randsample(1:N, K);
        x2(supp2) = rand(K,1)+0.5;
        supp3 = randsample(1:N, K);
        x3(supp3) = rand(K,1)+0.5;
        %%
        y1 = A1*x1;
        y2 = A2*x2;
        y3 = A3*x3;
        y_clean = kron(y1,kron(y2,y3));

        signal_power = (norm(y_clean)^2)/length(y_clean);
        noise_var = (signal_power)/(10^(SNR_loc/10));
        noise = sqrt(noise_var/2)*(randn(size(y_clean))+1i*randn(size(y_clean)));
        y = y_clean + noise;

        n_power_before(avg,s) = norm(y-y_clean)^2;
        %% decompose
        dim1 = size(A1,1);
        dim2 = size(A2,1);
        dim3 = size(A3,1);

        mat1 = reshape(y,dim2*dim3,dim1);
        [mat1l,mat1v,mat1r] = svd(mat1.');
        y1_est = mat1l(:,1);
        mat2 = reshape(mat1v(1,1)*conj(mat1r(:,1)), dim3, dim2);
        [mat2l,mat2v,mat2r] = svd(mat2.');
        y2_est = mat2l(:,1);
        y3_est = mat2v(1,1)*conj(mat2r(:,1));

        n_power_after(avg,s) = norm(kron(y1_est,kron(y2_est,y3_est))-y_clean)^2;

        bound(avg,s) = noise_var*(length(y1)+length(y2)+length(y3)-3);
    end
end


n_before = (mean(n_power_before,1));
n_after = (mean(n_power_after,1));
n_bound = (mean(bound,1));