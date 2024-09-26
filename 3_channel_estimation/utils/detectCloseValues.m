function clusterIndices = detectCloseValues(inputVector, threshold)
    n = length(inputVector);

    % Initialize cluster indices
    clusterIndices = zeros(n, 1);


    % Iterate through the entries and cluster them
    currentClusterIndex = 1;
    for i = 1:n
        if clusterIndices(i) == 0
            currentEntry = inputVector(i);
            closeIndices = abs(inputVector - currentEntry) < threshold;

            % Assign cluster index to the current entry and its close neighbors
            clusterIndices(closeIndices) = currentClusterIndex;
            
            % Move to the next cluster index
            currentClusterIndex = currentClusterIndex + 1;
        end
    end
end


