close all;
clear;

figure('units','normalized','outerposition',[0.05 0.05 0.5 0.6]);
subplot('Position',[0.14,0.193648648648649,0.84,0.78472972972973]);
load('MLE-Estimate-RTPCR-Hill_Incubation_5_72_days.mat','beta','TPtID','TDate','TResult','PtID','par');
TI=par(1:end-2);
[~,b]=ismember(TPtID,PtID);
dt=round(TDate'-TI(b(b>0)));
t=linspace(0,40,1001);

p = PCRSens(t,beta);
plot(t,p,'k','LineWidth',2)
hold on;
 %scatter(dt(dt>0),TResult(dt>0),40,'k','filled')
 %scatter(dt(dt<=0),TResult(dt<=0),40,'b')

L=[1:40];
S=zeros(1,40);

for ii=1:40
   S(ii)=sum(TResult(dt<=(ii+0.5)&dt>(ii-0.5)))./length(dt(dt<=(ii+0.5)&dt>(ii-0.5))); 
end
scatter(L,S,40,'r','filled')

legend({'Estimated','Avg Test Result:Binned'},'Fontsize',22);

box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[0:5:40],'Xminortick','on','YTick',[0:0.1:1],'YminorTick','on','Fontsize',26);
ylabel('Sensitivity','Fontsize',28);
xlabel('Days post-infection','Fontsize',28);

print(gcf,'PCR-Hill','-dpng','-r300');