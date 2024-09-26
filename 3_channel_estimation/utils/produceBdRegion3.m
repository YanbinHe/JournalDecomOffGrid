function [reg] = produceBdRegion3(middle,idx,prob)

reg = zeros(length(idx),2);

for l = 1:length(idx)
    if idx(l) == 1
        lbound = (-1+middle(idx(l)))/2;
        rbound = (middle(idx(l)+1)+middle(idx(l)))/2;
    elseif idx(l) == prob.dimN
        lbound = (middle(idx(l)-1)+middle(idx(l)))/2;
        rbound = (1+middle(idx(l)))/2;
    else
        lbound = (middle(idx(l)-1)+middle(idx(l)))/2;
        rbound = (middle(idx(l)+1)+middle(idx(l)))/2;

    end
    reg(l,:) = [lbound,rbound];
end

end