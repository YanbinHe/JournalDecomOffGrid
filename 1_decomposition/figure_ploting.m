%% some pre-defined values
% this file aims to reproduce the figures in the paper
run('Configuration.m');


% [all_themes, ~] = GetColors();
% all_colors = all_themes{30,1};
all_colors = [0, 70/255, 222/255;
              0.6350, 0.0780, 0.1840;
              0, 0.4470, 0.7410
              0.9290, 0.6940, 0.1250
              255/255,0,1;
              0.49 0.18 0.56;];

line_type_setm1{1} = '->';
line_type_setm1{2} = '-<';
line_type_setm1{3} = '-o';
line_type_setm1{4} = '-x';
line_type_setm1{5} = '-^';

line_type_setm2{1} = '-.>';
line_type_setm2{2} = '-.<';
line_type_setm2{3} = '-.o';
line_type_setm2{4} = '-.x';
line_type_setm2{5} = '-.^';

line_type_setm3{1} = ':>';
line_type_setm3{2} = ':<';
line_type_setm3{3} = ':o';
line_type_setm3{4} = ':x';
line_type_setm3{5} = ':^';

legend_type_set{1} = '>';
legend_type_set{2} = '<';
legend_type_set{3} = 'o';
legend_type_set{4} = 'x';
legend_type_set{5} = '^';
legend_type_set{6} = '-';
legend_type_set{7} = '-.';
legend_type_set{8} = ':';

algo_name{1} = 'SBL';
algo_name{2} = 'AM-KroSBL';
algo_name{3} = 'SVD-KroSBL';
algo_name{4} = 'dSBL';
algo_name{5} = 'OMP';

num_alg = 5;
ratio = M1.*M2.*M3/N^3;

fontsizeman = 20;
% opengl hardware
%%
% data process and figures plot
% preprocessing
trials = 50;
% first index: algorithm; second index: 3 values (nmse/srr/time); third
% index: change with different conditions
resultSaggrem1 = zeros(5,3,length(SNR));
resultSaggrem2 = zeros(5,3,length(SNR));
resultSaggrem3 = zeros(5,3,length(SNR));

for t = 1:trials
    filename = ['./results/f4_noisy_compare_1_', num2str(t),'.mat'];
    load(filename)
    for algo = 1:num_alg % for each algorithm
        metric = 1;
        for s = 1:length(SNR)
            resultSaggrem1(algo,metric,s) = resultSaggrem1(algo,metric,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 3;
        for s = 1:length(SNR)
            resultSaggrem1(algo,metric-1,s) = resultSaggrem1(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 4;
        for s = 1:length(SNR)
            resultSaggrem1(algo,metric-1,s) = resultSaggrem1(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end
    end
end

for t = 1:trials
    filename = ['./results/f4_noisy_compare_2_', num2str(t),'.mat'];
    load(filename)
    for algo = 1:num_alg % for each algorithm
        metric = 1;
        for s = 1:length(SNR)
            resultSaggrem2(algo,metric,s) = resultSaggrem2(algo,metric,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 3;
        for s = 1:length(SNR)
            resultSaggrem2(algo,metric-1,s) = resultSaggrem2(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 4;
        for s = 1:length(SNR)
            resultSaggrem2(algo,metric-1,s) = resultSaggrem2(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end
    end
end

for t = 1:trials
    filename = ['./results/f4_noisy_compare_3_', num2str(t),'.mat'];
    load(filename)
    for algo = 1:num_alg % for each algorithm
        metric = 1;
        for s = 1:length(SNR)
            resultSaggrem3(algo,metric,s) = resultSaggrem3(algo,metric,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 3;
        for s = 1:length(SNR)
            resultSaggrem3(algo,metric-1,s) = resultSaggrem3(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end

        metric = 4;
        for s = 1:length(SNR)
            resultSaggrem3(algo,metric-1,s) = resultSaggrem3(algo,metric-1,s) + resultS{s}{algo,1}{metric,2};
        end
    end
end

resultSaggrem1 = resultSaggrem1/trials;resultSaggrem2 = resultSaggrem2/trials;resultSaggrem3 = resultSaggrem3/trials;
%% compare NMSE for different SNR and m
figure
metric = 1;

h6 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{6},'Color',[0 0 0]);
hold on
h7 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{7},'Color',[0 0 0]);
hold on
h8 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{8},'Color',[0 0 0]);
hold on


for algo_index = 1:num_alg
    plot(SNR,reshape(resultSaggrem1(algo_index,metric,:),[6,1]),line_type_setm1{algo_index},'Color',all_colors(algo_index, :),'Display',algo_name{algo_index});
    hold on
end

for algo_index = 1:num_alg
    plot(SNR,reshape(resultSaggrem2(algo_index,metric,:),[6,1]),line_type_setm2{algo_index},'Color',all_colors(algo_index, :),'Display',algo_name{algo_index});
    hold on
end

for algo_index = 1:num_alg
    plot(SNR,reshape(resultSaggrem3(algo_index,metric,:),[6,1]),line_type_setm3{algo_index},'Color',all_colors(algo_index, :),'Display',algo_name{algo_index});
    hold on
end

grid on
set(gca, 'yscale', 'log');
legend('boxoff')
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizeman)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontSize',fontsizeman)
set(get(gca,'Ylabel'),'FontSize',fontsizeman)
set(get(gca,'Title'),'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
xlabel('SNR (dB)')
ylabel('NMSE')
ylim([1e-5 1])
% axis square


h1 = plot(SNR,reshape(resultSaggrem1(1,metric,:),[6,1]),legend_type_set{1},'Color',all_colors(1, :),'Display',algo_name{1});
hold on
h2 = plot(SNR,reshape(resultSaggrem1(2,metric,:),[6,1]),legend_type_set{2},'Color',all_colors(2, :),'Display',algo_name{2});
hold on
h3 = plot(SNR,reshape(resultSaggrem1(3,metric,:),[6,1]),legend_type_set{3},'Color',all_colors(3, :),'Display',algo_name{3});
hold on
h4 = plot(SNR,reshape(resultSaggrem1(4,metric,:),[6,1]),legend_type_set{4},'Color',all_colors(4, :),'Display',algo_name{4});
hold on
h5 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{5},'Color',all_colors(5, :),'Display',algo_name{5});
hold on
aux1 = plot(NaN,NaN,'LineStyle','none','DisplayName','');
aux2 = plot(NaN,NaN,'LineStyle','none','DisplayName','');
legend([h5 h1 h2 h3 h4 aux1 aux2 h6 h7 h8],{algo_name{5},algo_name{1},algo_name{2},algo_name{3},algo_name{4},'','','Low','Medium','High'},'Location','northeast','Interpreter','LaTex','NumColumns',2);

%% compare SRR for different SNR and m
figure
metric = 2;

h6 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{6},'Color',[0 0 0]);
hold on
h7 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{7},'Color',[0 0 0]);
hold on
h8 = plot(SNR,reshape(resultSaggrem1(5,metric,:),[6,1]),legend_type_set{8},'Color',[0 0 0]);
hold on


for algo_index = 1:num_alg
    plot(SNR,reshape(resultSaggrem1(algo_index,metric,:),[6,1]),line_type_setm1{algo_index},'Color',all_colors(algo_index, :),'Display',algo_name{algo_index});
    hold on
end

grid on
set(gca, 'xscale', 'log');
legend off
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizeman)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontSize',fontsizeman)
set(get(gca,'Ylabel'),'FontSize',fontsizeman)
set(get(gca,'Title'),'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
xlabel('SNR (dB)')
ylabel('SRR')
% axis square
%%
figure
metric = 3;
for algo_index = 1:num_alg
    plot(SNR,reshape(resultSaggrem1(algo_index,metric,:),[6,1]),line_type_setm1{algo_index},'Color',all_colors(algo_index, :),'Display',algo_name{algo_index});
    hold on
end


grid on
set(gca, 'yscale', 'log');
legend('boxoff')
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizeman)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontSize',fontsizeman)
set(get(gca,'Ylabel'),'FontSize',fontsizeman)
set(get(gca,'Title'),'FontSize',fontsizeman)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
xlabel('SNR (dB)')
ylabel('Time')

