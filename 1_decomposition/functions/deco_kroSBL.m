function [metrics] = deco_kroSBL(y,A1,A2,A3,N,R_max,x)

num_dict = 3;
time = zeros(num_dict,1);

A{1} = A1;
A{2} = A2;
A{3} = A3;

dim1 = size(A1,1);
dim2 = size(A2,1);
dim3 = size(A3,1);

A_ori = A;
x_re = cell(3,1);
gammad_old = cell(3,1);
Gammac = cell(3,1);
Gammacsqrt = cell(3,1);
Sigma_x = cell(3,1);
Sigma_x_diag = cell(3,1);

gammad{1} = ones(N,1); % initialize the prior
gammad{2} = ones(N,1);
gammad{3} = ones(N,1);

keep_listc{1} = 1:N;
keep_listc{2} = 1:N;
keep_listc{3} = 1:N;

% decompose noisy y
% as the model of noise after decomposition is unknown, we treat this as a
% problem with noise estimating
tic;
yten = cell(3,1);
mat1 = reshape(y,dim2*dim3,dim1);
[mat1l,mat1v,mat1r] = svd(mat1.');
yten{1} = mat1l(:,1);
mat2 = reshape(mat1v(1,1)*conj(mat1r(:,1)), dim3, dim2);
[mat2l,mat2v,mat2r] = svd(mat2.');
yten{2} = mat2l(:,1);
yten{3} = mat2v(1,1)*conj(mat2r(:,1));
time_deco = toc;

noise_var = cell(3,1);
noise_var{1} = 10^-(1)*norm(yten{1})/length(yten{1});
noise_var{2} = 10^-(1)*norm(yten{2})/length(yten{2});
noise_var{3} = 10^-(1)*norm(yten{3})/length(yten{3});

% control the convergence status
normc = ones(num_dict,1);
itrc = ones(num_dict,1);
r_rele{1} = 5*1e-4;
r_rele{2} = 5*1e-4;
r_rele{3} = 5*1e-4;
thres = 1e-5;

for sys_idx = 1:num_dict
    while(itrc(sys_idx) < R_max + 1 && normc(sys_idx) > thres) % do the iteration
        
        itrc(sys_idx);
        
        tic;
        
        
        gammal = zeros(N^3,1);
        gammal(keep_listc{sys_idx}) = gammad{sys_idx};
        gammad_old{sys_idx} = gammal;

        if min(abs(gammad{sys_idx})) < r_rele{sys_idx}*max(abs(gammad{sys_idx}))
            indexc = find(gammad{sys_idx} > r_rele{sys_idx}*max(abs(gammad{sys_idx}))); % should keep 
            gammad{sys_idx} = gammad{sys_idx}(indexc);
            A{sys_idx} = A{sys_idx}(:,indexc);
            keep_listc{sys_idx} = keep_listc{sys_idx}(indexc);
        end
        gammaold = gammad;
        % update the posterior
        Gammac{sys_idx} = diag(gammad{sys_idx});
        invPhic = A{sys_idx}'* (noise_var{sys_idx} * eye(size(A{sys_idx},1)) + A{sys_idx} * Gammac{sys_idx} * A{sys_idx}')^-1 * A{sys_idx};
        Sigma_x{sys_idx} = Gammac{sys_idx} - Gammac{sys_idx} * invPhic * Gammac{sys_idx};
        x_re{sys_idx} = noise_var{sys_idx}^-1 * Sigma_x{sys_idx} * A{sys_idx}' * yten{sys_idx};
        
        % updating gamma 
        Sigma_x_diag{sys_idx} = real(diag(Sigma_x{sys_idx}));
        gammad{sys_idx} = Sigma_x_diag{sys_idx} + abs(x_re{sys_idx}).^2;
        
        % updating noise variance
        temp = sum(ones(length(gammaold{sys_idx}),1) - gammaold{sys_idx}.^-1 .* Sigma_x_diag{sys_idx});
        noise_var{sys_idx} = (norm(yten{sys_idx} - A{sys_idx}*x_re{sys_idx})^2 + noise_var{sys_idx}*temp)/length(yten{sys_idx});
        

        time(sys_idx) = time(sys_idx) + toc;

        gammal = zeros(N^3,1);
        gammal(keep_listc{sys_idx}) = gammad{sys_idx};

        normc(sys_idx) = norm(gammal-gammad_old{sys_idx})/norm(gammad_old{sys_idx});
        norm(gammal-gammad_old{sys_idx})/norm(gammad_old{sys_idx});
        itrc(sys_idx) = itrc(sys_idx) + 1; 
    end
end

x_rel = cell(3,1);
% re-estimate
for sys_idx = 1:num_dict
    Gammac{sys_idx} = diag(gammad{sys_idx});
    invPhic = A{sys_idx}'* (noise_var{sys_idx} * eye(size(A{sys_idx},1)) + A{sys_idx} * Gammac{sys_idx} * A{sys_idx}')^-1 * A{sys_idx};
    Sigma_x{sys_idx} = Gammac{sys_idx} - Gammac{sys_idx} * invPhic * Gammac{sys_idx};
    x_re{sys_idx} = noise_var{sys_idx}^-1 * Sigma_x{sys_idx} * A{sys_idx}' * yten{sys_idx};
    
    x_rel{sys_idx} = zeros(N,1);
    x_rel{sys_idx}(keep_listc{sys_idx}) = x_re{sys_idx};
end

x_relv = kron(x_rel{1},kron(x_rel{2},x_rel{3}));

errord = (norm(x_relv - x)/norm(x))^2

srr = recover_rate(x_relv,x);
metrics={'error',errord;
    'vector',x_relv;
    'support recovery rate',srr;
    'time',(sum(time)+time_deco);
    'noise_est',noise_var
    };
end


