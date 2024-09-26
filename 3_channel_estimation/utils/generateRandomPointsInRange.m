function points = generateRandomPointsInRange(num_points, range, min_distance, max_distance)
    points = zeros(num_points, 1);
    
    for i = 1:num_points
        while true
            % Generate a random point within the given range
            point = (range(2) - range(1)) * rand() + range(1);
            
            % Check if the point satisfies the minimum distance condition
            if i > 1 && all(abs(points(1:i-1) - point) >= min_distance)
                % Check if the point satisfies the maximum distance condition
                if i > 1 && all(abs(points(1:i-1) - point) <= max_distance)
                    points(i) = point;
                    break;
                end
            elseif i == 1
                % For the first point, just assign it without checking distances
                points(i) = point;
                break;
            end
        end
    end

    points = sort(points);
end
