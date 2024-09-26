%%
load('waterfall.mat')
fontsizemean = 20;
em_idx  =  1:30;
figure
for idx = [1,2:2:30]
    waterfall(OFF1.track_middle(:,idx), em_idx(idx), OFF1.track_gamma(:,idx).');
    hold on
    p = waterfall([NaN;OFF1.track_middle(OFF1.track_idx(:,idx),idx);NaN], em_idx(idx), [NaN,OFF1.track_gamma(OFF1.track_idx(:,idx),idx).',NaN]);
    p.Marker = "o";p.MarkerFaceColor = "k";
    p.FaceAlpha = 0;
    p.LineStyle = "none";
    hold on
end
q = waterfall([NaN;param1;NaN], em_idx(idx), [NaN,zeros(1,length(param1)),NaN]);
q.Marker = "x";q.MarkerFaceColor = "k";q.MarkerSize = 20;set(q,'LineWidth',5)
q.FaceAlpha = 0;
q.LineStyle = "none";
hold on

set(gca, 'YDir','reverse')
zlim([0,1])
xlabel('Angle','Interpreter','latex')
ylabel('EM iteration','Interpreter','latex')
legend off
view([-15 70])

set(0,'DefaultLineLineWidth',8)
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
saveas(gcf,'waterfall_off','epsc')

%%
figure
uspace  =  linspace(-1,1,180);
em_idx  =  1:30;
for idx = [1,2:2:30]
    waterfall(OG1.track_middle(:,idx), em_idx(idx), OG1.track_gamma(:,idx).');
    hold on
    p = waterfall([NaN;OG1.track_middle(OG1.track_idx(:,idx),idx);NaN], em_idx(idx), [NaN,OG1.track_gamma(OG1.track_idx(:,idx),idx).',NaN]);
    p.Marker = "o";p.MarkerFaceColor = "k";
    p.FaceAlpha = 0;
    p.LineStyle = "none";
    hold on
end
q = waterfall([NaN;param1;NaN], em_idx(idx), [NaN,zeros(1,length(param1)),NaN]);
hold on
q.Marker = "x";q.MarkerFaceColor = "k";q.MarkerSize = 20;set(q,'LineWidth',5)
q.FaceAlpha = 0;
q.LineStyle = "none";

set(gca, 'YDir','reverse')
zlim([0,1])
xlabel('Angle','Interpreter','latex')
ylabel('EM iteration','Interpreter','latex')
legend off
view([-15 70])
set(0,'DefaultLineLineWidth',8)
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
saveas(gcf,'waterfall_sbl','epsc')
%%
figure
fontsizemean = 20;
em_idx  =  1:30;
for idx = [1,2:2:30]
    waterfall(OGSBI1.track_middle(:,idx), em_idx(idx), OGSBI1.track_gamma(:,idx).');
    hold on
    p = waterfall([NaN;OGSBI1.track_middle(OGSBI1.track_idx(:,idx),idx);NaN], em_idx(idx), [NaN,OGSBI1.track_gamma(OGSBI1.track_idx(:,idx),idx).',NaN]);
    p.Marker = "o";p.MarkerFaceColor = "k";
    p.FaceAlpha = 0;
    p.LineStyle = "none";
    hold on
end
q = waterfall([NaN;param1;NaN], em_idx(idx), [NaN,zeros(1,length(param1)),NaN]);
q.Marker = "x";q.MarkerFaceColor = "k";q.MarkerSize = 20;set(q,'LineWidth',5)
q.FaceAlpha = 0;
q.LineStyle = "none";
hold on

set(gca, 'YDir','reverse')
zlim([0,1])
xlabel('Angle','Interpreter','latex')
ylabel('EM iteration','Interpreter','latex')
legend off
view([-15 70])
set(0,'DefaultLineLineWidth',8)
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
saveas(gcf,'waterfall_ogsbi','epsc')