close all;
clear;

figure('units','normalized','outerposition',[0 0 1 1]);
%%% RT-PCR Hellewell
subplot('Position',[0.064894957983193,0.5917,0.424600840336135,0.39]);
load('MLE-Estimate-RTPCR-Hill_Incubation_8_29_days.mat','beta','TPtID','TDate','TResult','PtID','par');
TI=par(1:end-2);
[~,b]=ismember(TPtID,PtID);
dt=round(TDate'-TI(b(b>0)));
t=linspace(0,50,1001);

tL=2.9;

S = TestSensitivity(t,8.29,2.9,inf,[],beta);
LL1=plot(t,S,'k','LineWidth',2);
hold on
plot(8.29.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);

L=[1:40];
S=zeros(1,40);

for ii=1:40
   S(ii)=sum(TResult(dt<=(ii+0.5)&dt>(ii-0.5)))./length(dt(dt<=(ii+0.5)&dt>(ii-0.5))); 
end
LL2=scatter(L,S,40,'k','filled');

legend([LL1,LL2],{'Estimated','Avg Test Result:Binned'},'Fontsize',20);

box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
ylabel('Diagnostic sensitivity','Fontsize',22);
xlabel('Days post-infection','Fontsize',22);

text(-6.30407911001236,0.995,'A','Fontsize',32,'FontWeight','bold');

subplot('Position',[0.563592436974789,0.5917,0.424600840336135,0.39]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% BD Veritor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
tt=4;
load('BDVeritor_Parameter.mat');
ts=8.29;
t=linspace(8.29,50,1001);

LL1=plot(t,LR(t,beta),'r','LineWidth',2); 
hold on;

plot(8.29.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);
LL2=scatter(Dt+ts,S(1,:)./S(2,:),30,'r','filled');
xlim([8 50]);
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
ylabel({'Percent','postive agreement'},'Fontsize',22);
xlabel('Days post-infection','Fontsize',22);

legend([LL1,LL2],{'Estimated PPA','Emperical PPA'},'Fontsize',20);

box off;

text(0.805933250927065,1.002389162561576,'B','Fontsize',32,'FontWeight','bold');
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% RT-PCR vs Ag Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot('Position',[0.063592436974789,0.111,0.424600840336134,0.39]);
load('MLE-Estimate-RTPCR-Hill_Incubation_8_29_days.mat','beta');
betaPCR=beta;
load('BDVeritor_Parameter.mat','beta');

t=linspace(0,50,1001);
S = TestSensitivity(t,8.29,2.9,inf,[],betaPCR);
SAg = TestSensitivity(t,8.29,2.9,inf,beta,betaPCR);

LL1=plot(t,S,'k','LineWidth',2); hold on
LL2=plot(t,SAg,'r','LineWidth',2);
plot(8.29.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);

box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
ylabel('Diagnostic sensitivity','Fontsize',22);
xlabel('Days post-infection','Fontsize',22);


legend([LL1,LL2],{'RT-PCR','Rapid antigen'},'Fontsize',20);

text(-6.30407911001236,0.995,'C','Fontsize',32,'FontWeight','bold');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% RT-PCR vs Ag Test Nat Comm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
subplot('Position',[0.563592436974789,0.111,0.424600840336134,0.39]);

load('BDVeritor_Parameter.mat','beta');

t=linspace(0,50,1001);
S = TestSensitivityOLD(t,8.29,2.9,inf,[],0);
SAg = TestSensitivityOLD(t,8.29,2.9,inf,beta,0);

LL1=plot(t,S,'k','LineWidth',2); hold on
LL2=plot(t,SAg,'r','LineWidth',2);
plot(8.29.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);

box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
ylabel('Diagnostic sensitivity','Fontsize',22);
xlabel('Days post-infection','Fontsize',22);


legend([LL1,LL2],{'RT-PCR (Wells et al)','Rapid antigen'},'Fontsize',20);
text(-8.59,0.995,'D','Fontsize',32,'FontWeight','bold');

print(gcf,'Figure_Diagnostic_Sensitivity.png','-dpng','-r600');