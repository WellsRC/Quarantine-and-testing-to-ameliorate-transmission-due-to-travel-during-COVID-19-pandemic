close all;
clear;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Shorter incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0 0 1 1]);
%%% RT-PCR Hellewell
subplot('Position',[0.064894957983193,0.5917,0.424600840336135,0.39]);
load('MLE-Estimate-RTPCR-Hill_Incubation_5_72_days.mat','beta','TPtID','TDate','TResult','PtID','par');
TI=par(1:end-2);
[~,b]=ismember(TPtID,PtID);
dt=round(TDate'-TI(b(b>0)));
t=linspace(0,50,1001);

tL=2.9;

S = TestSensitivity(t,5.723,2.9,inf,[],beta);
LL1=plot(t,S,'k','LineWidth',2);
hold on
plot(5.723.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);

L=[1:40];
S=zeros(1,40);

for ii=1:40
   S(ii)=sum(TResult(dt<=(ii+0.5)&dt>(ii-0.5)))./length(dt(dt<=(ii+0.5)&dt>(ii-0.5))); 
end
LL2=scatter(L,S,40,'k','filled');


load('MLE-Estimate-RTPCR-Hill_Incubation_5_72_days.mat','beta');
betaPCR=beta;
load('BD Veritor_LR_Parameters.mat','beta');

t=linspace(0,50,1001);
S = TestSensitivity(t,5.723,2.9,inf,[],betaPCR);
SAg = TestSensitivity(t,5.723,2.9,inf,beta,betaPCR);

LL3=plot(t,SAg,'r','LineWidth',2);
plot(5.723.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);


legend([LL2,LL1,LL3],{'Avg Test Result:Binned','Estimated RT-PCR','Rapid Antigen'},'Fontsize',20);

box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
ylabel('Diagnostic sensitivity','Fontsize',22);
xlabel('Days post-infection','Fontsize',22);

text(-6.30407911001236,0.995,'B','Fontsize',32,'FontWeight','bold');
% 
% subplot('Position',[0.563592436974789,0.5917,0.424600840336135,0.39]);
% 
% load('MLE-Estimate-RTPCR-Hill_Incubation_5_72_days.mat','beta');
% betaPCR=beta;
% load('BD Veritor_LR_Parameters.mat','beta');
% 
% t=linspace(0,50,1001);
% S = TestSensitivity(t,5.723,2.9,inf,[],betaPCR);
% SAg = TestSensitivity(t,5.723,2.9,inf,beta,betaPCR);
% 
% LL1=plot(t,S,'k','LineWidth',2); hold on
% LL2=plot(t,SAg,'r','LineWidth',2);
% plot(5.723.*ones(101,1),linspace(0,1,101),':','color',[0.75 0.75 0.75],'LineWidth',2);
% 
% box off;
% set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:50],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',20);
% ylabel('Diagnostic sensitivity','Fontsize',22);
% xlabel('Days post-infection','Fontsize',22);
% 
% 
% legend([LL1,LL2],{'RT-PCR','Rapid antigen'},'Fontsize',20);
% 
% text(-6.30407911001236,0.995,'F','Fontsize',32,'FontWeight','bold');

print(gcf,'Figure_Diagnostic_Sensitivity_Shorter.png','-dpng','-r600');