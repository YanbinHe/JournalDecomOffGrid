function subintervals = generateSubintervals(a, b, n)
    % Check for valid inputs
    if nargin ~= 3
        error('Invalid number of input arguments. Please provide interval endpoints and the number of subintervals.');
    end
    
    % Calculate the length of each subinterval
    subintervalLength = (b - a) / n;
    
    % Generate subintervals
    subintervals = zeros(n, 2);
    for i = 1:n
        subintervals(i, 1) = a + (i - 1) * subintervalLength;  % Start of subinterval
        subintervals(i, 2) = a + i * subintervalLength;        % End of subinterval
    end

end
