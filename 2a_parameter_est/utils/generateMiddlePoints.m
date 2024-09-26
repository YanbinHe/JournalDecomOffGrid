function middlePoints = generateMiddlePoints(intervals)
    % Check for valid input
    if nargin ~= 1
        error('Invalid number of input arguments. Please provide a matrix with intervals.');
    end
    
    % Get the number of intervals and validate input matrix
    [numIntervals, cols] = size(intervals);
    if cols ~= 2
        error('Invalid input matrix. Each row should represent an interval with two columns (start and end).');
    end
    
    % Generate middle points
    middlePoints = zeros(numIntervals, 1);
    for i = 1:numIntervals
        middlePoints(i) = (intervals(i, 1) + intervals(i, 2)) / 2;
    end

end
