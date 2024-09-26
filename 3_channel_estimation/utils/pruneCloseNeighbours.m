% Prune the columns of dictionaries with really close value given a
% predefined threshold

l = length(middle);
index_local = []; % index should be preserved

label = detectCloseValues(middle,5*1e-3);
numCluster = max(label);
for nC = 1:numCluster
    clu = find(label == nC); % indices for repeating estimates
    [~,idx_temp] = max(gamma(clu)); % choose the one with the largest gamma value as the one to be preserved
    index_local = [index_local,clu(idx_temp)];
end
x_re = x_re(index_local,:);
middle = middle(index_local,:);
gamma = gamma(index_local,:);
Sigma_x = Sigma_x(index_local,index_local);
H = H(:,index_local);
