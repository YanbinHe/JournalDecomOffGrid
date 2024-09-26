function complex_matrix = generate_complex_matrix(m, n)
    % Generate random phases between 0 and 2*pi for each entry
    phases = 2 * pi * rand(m, n);
    
    % Create complex matrix with unit power and random phases
    complex_matrix = exp(1i * phases);
end