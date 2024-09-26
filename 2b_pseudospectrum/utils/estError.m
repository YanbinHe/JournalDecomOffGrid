function [value] = estError(real,est)
if length(real) == length(est) % the number of sources is correct
    set_length = length(real);
    absolute_error = abs(real - est.');
    nmse = zeros(set_length,1);
    for i = 1:set_length % i-th round of extracting pairs
        [value,idx_row] = min(absolute_error);
        [~,idx_column] = min(value);
        posi = [idx_row(idx_column),idx_column];
        nmse(i) = absolute_error(posi(1),posi(2)).^2;
        absolute_error(:,idx_column) = [];
        absolute_error(idx_row(idx_column),:) = [];
    end
    value = sum(nmse)/length(real);
else
    value = 1; % fail to recover all the sources
end
end