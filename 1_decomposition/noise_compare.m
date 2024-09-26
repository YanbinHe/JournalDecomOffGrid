% noise compare
lenS = length(SNR);
lenM = length(M1);

for m = 1:lenM
    M1_loc = M1(m);
    M2_loc = M2(m);
    M3_loc = M3(m);
    % generate measuring dictionaries
    A1 = generate_dict(M1_loc,N);
    A2 = generate_dict(M2_loc,N);
    A3 = generate_dict(M3_loc,N);

    for avg = 1:AVG
        resultS = cell(1,lenS);
        %% nmse and srr vs snr
        x1 = zeros(N,1);
        x2 = zeros(N,1);
        x3 = zeros(N,1);

        % generate sparse vectors
        supp1 = randsample(1:N, K);
        x1(supp1) = rand(K,1)+0.5;%1/sqrt(2)*(randn(K,1) + 1i*randn(K,1));
        supp2 = randsample(1:N, K);
        x2(supp2) = rand(K,1)+0.5;
        supp3 = randsample(1:N, K);
        x3(supp3) = rand(K,1)+0.5;
        %%
        y1 = A1*x1;
        y2 = A2*x2;
        y3 = A3*x3;

        x = kron(x1,kron(x2,x3));
        y = kron(y1,kron(y2,y3));
        A = kron(A1,kron(A2,A3));
        %%
        for s = 1:lenS
            resultS{s} = simulationS(y,A1,A2,A3,A,N,R_max,x,SNR(s),epi);
        end
        % save data for each trial
        fname = ['./results/f4_noisy_compare_',num2str(m),'_', num2str(avg),'.mat'];
        save(fname,"resultS","y","A","x")
    end
end