function [reg] = produceBdRegion(middle)

reg = zeros(length(middle),2);

for l = 1:length(middle)
    if l == 1 % the first entry
        lbound = -1;
        rbound = (middle(l)+middle(l+1))/2;
    elseif l == length(middle) % the last entry
        lbound = (middle(l)+middle(l-1))/2;
        rbound = 1; % bounded within 1
    % for entries in the middle
    else
        lbound = (middle(l)+middle(l-1))/2;
        rbound = (middle(l)+middle(l+1))/2;
    end
    reg(l,:) = [lbound,rbound];
end

end
