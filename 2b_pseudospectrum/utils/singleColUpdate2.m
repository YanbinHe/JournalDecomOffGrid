function [H,middle] = singleColUpdate2(H,M_temp,Sigma,diagSig,reg,idx,prob,middle)

for j = 1:length(idx)
    temp = Sigma(j,:) * H'-M_temp(j,:);
    % update the new column
    [H(:,j),middle(j,1)] = col_search(reg(j,:),temp,diagSig(j),prob);
end

end