close all;
clear;
figure('units','normalized','outerposition',[0 0 0.85 0.8]);
panel=1;

subplot('Position',[0.05+0.5.*rem(panel-1,2) 0.59-0.49*floor((panel-1)/2) 0.438 0.38]);

load('MLE-Estimate-RTPCR-Hill.mat','beta','TPtID','TDate','TResult','PtID','par');
TI=par(1:end-2);
[~,b]=ismember(TPtID,PtID);
dt=round(TDate'-TI(b(b>0)));
t=linspace(0,21,1001);

tL=2.9;

S = TestSensitivity(t,8.29,2.9,inf,[],beta);
LL1=plot(t,S,'k','LineWidth',2);
hold on

L=[1:40];
S=zeros(1,40);

for ii=1:40
   S(ii)=sum(TResult(dt<=(ii+0.5)&dt>(ii-0.5)))./length(dt(dt<=(ii+0.5)&dt>(ii-0.5))); 
end
LL2=scatter(L,S,40,'k','filled');


% legend([LL1,LL2],{'Hill function (Based on infectivity curve)','Avg Test Result:Binned'},'Fontsize',20);

box off;
set(gca,'LineWidth',2,'tickdir','out','Fontsize',16,'XTick',[0:21],'XMinorTick','on','Yminortick','on','YTick',[0:0.1:1],'Xlim',[0 21]);
ylabel('Diagnostic sensitivity','Fontsize',18);

xlabel('Days post-infection','Fontsize',18);
print(gcf,['HellewellData_RTPCR.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nat Comm

figure('units','normalized','outerposition',[0 0 0.85 0.8]);
panel=1;

subplot('Position',[0.05+0.5.*rem(panel-1,2) 0.59-0.49*floor((panel-1)/2) 0.438 0.38]);

t=linspace(0,50,1001);
S = TestSensitivityOLD(t,8.29,2.9,inf,[],0);
SAg = TestSensitivityOLD(t,8.29,2.9,inf,beta,0);

LL1=plot(t,S,'k','LineWidth',2); hold on

box off;
set(gca,'LineWidth',2,'tickdir','out','Fontsize',16,'XTick',[0:5:50],'XMinorTick','on','Yminortick','on','YTick',[0:0.1:1],'Xlim',[0 50]);
ylabel('Diagnostic sensitivity','Fontsize',18);

xlabel('Days post-infection','Fontsize',18);
print(gcf,['NatComm_RTPCR_Curve_Long.png'],'-dpng','-r600');


figure('units','normalized','outerposition',[0 0 0.85 0.8]);
panel=1;

subplot('Position',[0.05+0.5.*rem(panel-1,2) 0.59-0.49*floor((panel-1)/2) 0.438 0.38]);

t=linspace(0,50,1001);
S = TestSensitivityOLD(t,8.29,2.9,inf,[],0);
SAg = TestSensitivityOLD(t,8.29,2.9,inf,beta,0);

LL1=plot(t,S,'k','LineWidth',2); hold on

box off;
set(gca,'LineWidth',2,'tickdir','out','Fontsize',16,'XTick',[0:21],'XMinorTick','on','Yminortick','on','YTick',[0:0.1:1],'Xlim',[0 21]);
ylabel('Diagnostic sensitivity','Fontsize',18);

xlabel('Days post-infection','Fontsize',18);
print(gcf,['NatComm_RTPCR_Curve_Short.png'],'-dpng','-r600');