function [idx] = find_top_peaks(gamma,updatecomp)
% find peaks of the input vector based on the entry values

[pksv,locs] = findpeaks(gamma);
[~,pks_locs] = maxk(pksv,updatecomp);
idx = locs(pks_locs);

end