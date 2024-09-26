%% some pre-defined values
% this file aims to reproduce the figures in the paper

all_colors = [0, 70/255, 222/255;
    0.6350, 0.0780, 0.1840;
    0, 0.4470, 0.7410
    0.9290, 0.6940, 0.1250
    255/255,0,1;
    0.49 0.18 0.56;];

marker_type = {'>','+','o','x'};
algo_name = {'OffSBL','SBL','LWSSBL','OGSBI'};
case_name = {'$\#$Unknowns = 2','$\#$Unknowns = 4','$\#$Unknowns = 6'};
line_type = {'-','-.',':'};

fontsizeman = 20;
SNR               = 5:5:30; % in dB
SNR_10            = 10.^(SNR/10);
K2                = 20:5:50;
num_alg = 4;
ratio = K2/180;
%%
trial = 1000;
errorAggre   = zeros(3,4,length(K2),length(SNR));
detectAggre  = zeros(3,4,length(K2),length(SNR));
timeAggre    = zeros(3,4,length(K2),length(SNR));

for case_idx = 1:3 % from 2 unknowns to 6 unknowns
    for t = 1:trial
        switch case_idx
            case 1 % 2
                filename = ['./results2/simu_result_2valueunknown_', num2str(t),'.mat'];
                load(filename,'error_track','detect_track','time');

            case 2 % 4
                filename = ['./results2/simu_result_4unknown_', num2str(t),'.mat'];
                load(filename,'error_track','detect_track','time');

            case 3 % 6
                filename = ['./results2/simu_result_', num2str(t),'.mat'];
                load(filename,'error_track','detect_track','time');
        end

        errorAggre(case_idx,:,:,:) = errorAggre(case_idx,:,:,:) + reshape(error_track,[1,4,length(K2),length(SNR)]);
        detectAggre(case_idx,:,:,:) = detectAggre(case_idx,:,:,:) + reshape(detect_track,[1,4,length(K2),length(SNR)]);
        timeAggre(case_idx,:,:,:) = timeAggre(case_idx,:,:,:) + reshape(time,[1,4,length(K2),length(SNR)]);

    end
end

errorAggre = errorAggre/trial;
detectAggre = detectAggre/trial;
timeAggre = timeAggre/trial;
%% plot figures

% set up captions
marker1 = plot(SNR,squeeze(errorAggre(1,1,7,:)),'>','Color',all_colors(1,:));
hold on
marker2 = plot(SNR,squeeze(errorAggre(1,2,7,:)),'+','Color',all_colors(2,:));
hold on
marker3 = plot(SNR,squeeze(errorAggre(1,3,7,:)),'o','Color',all_colors(3,:));
hold on
marker4 = plot(SNR,squeeze(errorAggre(1,4,7,:)),'x','Color',all_colors(4,:));
hold on

line1 = plot(SNR,squeeze(errorAggre(1,1,7,:)),'-k');
hold on
line2 = plot(SNR,squeeze(errorAggre(2,1,7,:)),'-.k');
hold on
line3 = plot(SNR,squeeze(errorAggre(3,1,7,:)),':k');
hold on

k2 = 7;
for case_idx = 1:3
    for alg = 1:num_alg
        plot(SNR,squeeze(errorAggre(case_idx,alg,k2,:)),'Marker',...
            marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
        hold on
    end
end

legend([marker1,marker2,marker3,marker4,line1,line2,line3],...
    algo_name{1},algo_name{2},algo_name{3},algo_name{4},case_name{1},case_name{2},case_name{3},'Interpreter','LaTex','Location','southwest','NumColumns',2);

legend box off 

fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('MSE','Interpreter','LaTex')
saveas(gcf,'mse_snr','epsc')
%%
case_snr = 6;
figure
for case_idx = 1:3
    for alg = 1:num_alg
        plot(ratio,squeeze(errorAggre(case_idx,alg,:,case_snr)),'Marker',...
            marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
        hold on
    end
end
fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'YScale','log')
grid on
xlabel('Ratio','Interpreter','LaTex')
ylabel('MSE','Interpreter','LaTex')
saveas(gcf,'mse_ratio','epsc')
%%
k2 = 7;
figure
for case_idx = 1:3
for alg = 1:num_alg
    plot(SNR,squeeze(detectAggre(case_idx,alg,k2,:)),'Marker',...
        marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
hold on
end
end
fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Probability','Interpreter','LaTex')
saveas(gcf,'prob_snr','epsc')
%%
case_snr = 6;
figure
for case_idx = 1:3
    for alg = 1:num_alg
        plot(ratio,squeeze(detectAggre(case_idx,alg,:,case_snr)),'Marker',...
            marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
        hold on
    end
end
fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
grid on
xlabel('Ratio','Interpreter','LaTex')
ylabel('Probability','Interpreter','LaTex')
saveas(gcf,'prob_ratio','epsc')
%%
k2 = 7;
figure
for case_idx = 1:3
for alg = 1:num_alg
    plot(SNR,squeeze(timeAggre(case_idx,alg,k2,:)),'Marker',...
        marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
hold on
end
end
fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Time (s)','Interpreter','LaTex')
%%
case_snr = 6;
figure
for case_idx = 1:3
    for alg = 1:num_alg
        plot(ratio,squeeze(timeAggre(case_idx,alg,:,case_snr)),'Marker',...
            marker_type{alg},'LineStyle',line_type{case_idx},'Color',all_colors(alg,:));
        hold on
    end
end
fontsizemean = 20;
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',14)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'YScale','log')
grid on
xlabel('Ratio','Interpreter','LaTex')
ylabel('Time (s)','Interpreter','LaTex')