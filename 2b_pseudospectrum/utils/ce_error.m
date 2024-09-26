function [error, H_re] = ce_error(fin,prob,Htrue)

K2 = prob.K2;

H = cell(3,1);
g = cell(3,1);

for sys = 1:3
    prob.sys = sys;
    H{sys} = generate_channel(prob,fin{sys}.middle);
    g{sys} = fin{sys}.x;
end
    
H_re = reshape(kron(H{1}*g{1},kron(H{2}*g{2},H{3}*g{3})),[prob.bs_ante*prob.ms_ante,prob.K2]);

for i = 1:K2
    error(i) = (norm(H_re(:,i) - Htrue(:,i),'fro')/norm(Htrue(:,i),'fro'))^2;
end
error = mean(error);
end