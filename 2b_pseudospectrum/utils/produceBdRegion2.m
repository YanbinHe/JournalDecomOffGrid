function [reg] = produceBdRegion2(middle,reg,idx,prob)

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
    reg(idx(l),:) = [lbound,rbound];
end

end