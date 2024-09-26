%% some pre-defined values
% this file aims to reproduce the figures in the paper

load('resultexppi.mat')

all_colors = [0, 70/255, 222/255;
    0.6350, 0.0780, 0.1840;
    0, 0.4470, 0.7410
    0.9290, 0.6940, 0.1250
    255/255,0,1;
    0.49 0.18 0.56;];

line_type_set{1} = '-';
line_type_set{2} = '-.';
line_type_set{3} = ':';

legend_type_set{1} = '>';
legend_type_set{2} = '+';
legend_type_set{3} = 'o';
legend_type_set{4} = 'x';

algo_name{1} = 'offSBL';
algo_name{2} = 'SBL';
algo_name{3} = 'LWSSBL';
algo_name{4} = 'OGSBI';

case_name{1} = 'P1';
case_name{2} = 'P2';
case_name{3} = 'P3';

fontsizeman = 20;
num_alg = 4;
%% load simulation results
AVG = 50;
estAggre = squeeze(sum(est_unknown,2)/AVG);
detectAggre = squeeze(sum(detect_track,2)/AVG);
timeAggre = squeeze(sum(time,2)/AVG);
%% plot figures
figure

% set up captions
marker1 = plot(SNR,estAggre(1,:,1),'>','Color',all_colors(1,:));
hold on
marker2 = plot(SNR,estAggre(2,:,1),'+','Color',all_colors(2,:));
hold on
marker3 = plot(SNR,estAggre(3,:,1),'o','Color',all_colors(3,:));
hold on
marker4 = plot(SNR,estAggre(4,:,1),'x','Color',all_colors(4,:));
hold on

line1 = plot(SNR,estAggre(1,:,1),'-k');
hold on
line2 = plot(SNR,estAggre(1,:,2),'-.k');
hold on
line3 = plot(SNR,estAggre(1,:,3),':k');
hold on


for alg = 1:num_alg
plot(SNR,estAggre(alg,:,1),'Marker',legend_type_set{alg},'LineStyle',line_type_set{1},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('MSE','Interpreter','LaTex')

% figure
for alg = 1:num_alg
plot(SNR,estAggre(alg,:,2),'Marker',legend_type_set{alg},'LineStyle',line_type_set{2},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('MSE','Interpreter','LaTex')

% figure
for alg = 1:num_alg
plot(SNR,estAggre(alg,:,3),'Marker',legend_type_set{alg},'LineStyle',line_type_set{3},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
ylabel('MSE','Interpreter','LaTex')
ylim([1e-10,1])
legend([marker1,marker2,marker3,marker4,line1,line2,line3],...
    algo_name{1},algo_name{2},algo_name{3},algo_name{4},case_name{1},case_name{2},case_name{3},'Interpreter','LaTex','Location','southwest','NumColumns',2);

legend box off 

%%
figure
for alg = 1:num_alg
plot(SNR,detectAggre(alg,:,1),'Marker',legend_type_set{alg},'LineStyle',line_type_set{1},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Probability','Interpreter','LaTex')

% figure
for alg = 1:num_alg
plot(SNR,detectAggre(alg,:,2),'Marker',legend_type_set{alg},'LineStyle',line_type_set{2},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Probability','Interpreter','LaTex')

% figure
for alg = 1:num_alg
plot(SNR,detectAggre(alg,:,3),'Marker',legend_type_set{alg},'LineStyle',line_type_set{3},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
set(gca,'YScale','linear')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Probability','Interpreter','LaTex')
%%
figure
for alg = 1:num_alg
plot(SNR,timeAggre(alg,:,1),'Marker',legend_type_set{alg},'LineStyle',line_type_set{1},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Time (s)','Interpreter','LaTex')

figure
for alg = 1:num_alg
plot(SNR,timeAggre(alg,:,2),'Marker',legend_type_set{alg},'LineStyle',line_type_set{2},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
% set(gca,'YScale','log')
grid on
xlabel('SNR (dB)','Interpreter','LaTex')
ylabel('Time (s)','Interpreter','LaTex')

figure
for alg = 1:num_alg
plot(SNR,timeAggre(alg,:,3),'Marker',legend_type_set{alg},'LineStyle',line_type_set{3},'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
%% channel estimation
%% load simulation results

errorAggre = zeros(4,length(SNR));
errorAggre(1,:,:) = squeeze(sum(erOFF,1)/AVG);
errorAggre(2,:,:) = squeeze(sum(erOG,1)/AVG);
errorAggre(3,:,:) = squeeze(sum(erGLLW,1)/AVG);
errorAggre(4,:,:) = squeeze(sum(erOGSBI,1)/AVG);

serAggre = zeros(4,length(SNR));
serAggre(1,:,:) = squeeze(sum(serOFF,1)/AVG);
serAggre(2,:,:) = squeeze(sum(serOG,1)/AVG);
serAggre(3,:,:) = squeeze(sum(serGLLW,1)/AVG);
serAggre(4,:,:) = squeeze(sum(serOGSBI,1)/AVG);

figure

% set up captions
marker1 = plot(SNR,errorAggre(1,:,1),'>','Color',all_colors(1,:));
hold on
marker2 = plot(SNR,errorAggre(2,:,1),'+','Color',all_colors(2,:));
hold on
marker3 = plot(SNR,errorAggre(3,:,1),'o','Color',all_colors(3,:));
hold on
marker4 = plot(SNR,errorAggre(4,:,1),'x','Color',all_colors(4,:));
hold on

for alg = 1:num_alg
plot(SNR,errorAggre(alg,:),'--','DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
ylabel('NMSE','Interpreter','LaTex')

legend([marker1,marker2,marker3,marker4],...
    algo_name{1},algo_name{2},algo_name{3},algo_name{4},'Interpreter','LaTex','Location','southwest');
legend box off 

%% sysmbol error
figure
for alg = 1:num_alg
plot(SNR,serAggre(alg,:),strcat('--',legend_type_set{alg}),'DisplayName',algo_name{alg},'Color',all_colors(alg,:));
hold on
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
ylabel('SER','Interpreter','LaTex')
yticks([1e-5,1e-4,1e-3,1e-2,1e-1,1])