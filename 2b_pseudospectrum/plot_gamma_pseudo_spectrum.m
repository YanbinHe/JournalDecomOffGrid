clc
clear
close all

load spectrum_case2.mat

all_colors = [0, 70/255, 222/255;
    0.6350, 0.0780, 0.1840;
    0, 0.4470, 0.7410
    0.9290, 0.6940, 0.1250
    0.49 0.18 0.56;];
%%
fontsizemean = 20;
f = figure;
f.Position = [100 100 1000 400];
for avg = 1:AVG
plot(gammaTrackOff{2,avg}(:,end),gammaTrackOff{1,avg}(:,end),'-');
hold on
end
xline(param1,':','LineWidth', 3)
hold on

legend off
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',8)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'TickLabelInterpreter', 'latex')
grid on
saveas(gcf,'spectrum_offsbl','epsc')

f = figure;
f.Position = [100 100 1000 400];
for avg = 1:AVG
plot(gammaTrackON{2,avg}(:,end),gammaTrackON{1,avg}(:,end),'-');
hold on
end
xline(param1,':','LineWidth', 3)
hold on
legend off
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',8)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'TickLabelInterpreter', 'latex')
grid on
saveas(gcf,'spectrum_onsbl','epsc')

f = figure;
f.Position = [100 100 1000 400];
for avg = 1:AVG
plot(gammaTrackGLLS{2,avg},gammaTrackGLLS{1,avg},'-');
hold on
end
xline(param1,':','LineWidth', 3)
hold on
legend off
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',8)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'TickLabelInterpreter', 'latex')
grid on
saveas(gcf,'spectrum_lwssbl','epsc')

f = figure;
f.Position = [100 100 1000 400];
for avg = 1:AVG
plot(gammaOGSBI{2,avg}(:,end),gammaOGSBI{1,avg}(:,end),'-');
hold on
end
xline(param1,':','LineWidth', 3)
hold on
legend off
set(0,'DefaultLineLineWidth',3)
set(0,'DefaultAxesFontSize',fontsizemean)
set(0,'DefaultLineMarkerSize',8)
set(0,'DefaultAxesFontWeight','bold')
set(gca,'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontSize',fontsizemean)
set(get(gca,'Ylabel'),'FontSize',fontsizemean)
set(get(gca,'Title'),'FontSize',fontsizemean)
set(get(gca,'Xlabel'),'FontWeight','bold')
set(get(gca,'Ylabel'),'FontWeight','bold')
set(get(gca,'Title'),'FontWeight','bold')
set(gca,'TickLabelInterpreter', 'latex')
grid on
saveas(gcf,'spectrum_ogsbi','epsc')