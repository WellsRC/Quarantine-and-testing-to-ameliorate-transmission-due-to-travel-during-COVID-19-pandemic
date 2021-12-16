%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Plots the infecitvity curve for 8.29 days
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
tL=[2.9]; % vecotor for the incbation periods to be integrated over

% Allcoate memory for output
figure('units','normalized','outerposition',[0 0 0.85 0.8]);
panel=1;

subplot('Position',[0.05+0.5.*rem(panel-1,2) 0.59-0.49*floor((panel-1)/2) 0.438 0.38]);

% Get Basline parameters
[~,~,R0,ts,td] = BaselineParameters(tL); % Does not matter here what ts is fed in 
tt=linspace(0,35,100001);
pA=0.3544;
SelfIsolate=1;
VS=InfectiousnessfromInfection(tt,R0,R0,pA,ts,tL,td,SelfIsolate);
VNS=InfectiousnessfromInfection(tt,R0,R0,pA,ts,tL,td,0);
RS=integral(@(x)InfectiousnessfromInfection(x,R0,R0,pA,ts,tL,td,SelfIsolate),0,inf);


patch([tt flip(tt)],[VS zeros(size(tt))],hex2rgb('#F5BE41'),'LineStyle','none','Facealpha',0.3); hold on
text(-1.534999999999991+ts,0.35, num2str(round(RS,1),'%2.1f'),'Fontsize',16,'HorizontalAlignment','center');

p3=plot(tt,VS,'color',hex2rgb('#F5BE41'),'LineWidth',2); hold on
p1=plot(tt,VNS,'color',hex2rgb('#2A3132'),'LineWidth',2); hold on


legend([p1 p3],{'No self-isolation',['Self-isolation and ' num2str(100*pA) '% asymptomatic']},'Fontsize',14);
legend boxoff;
box off;
xlabel('Days post-infection','Fontsize',18);
ylabel('Infectivity','Fontsize',18);

ylim([0 0.7]);
xlim([0 25]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',16,'XTick',[0:25],'XMinorTick','on','Yminortick','on','YTick',[0:0.1:0.9]);
text(-2.836,0.7,'A','Fontsize',32,'Fontweight','bold');
panel=2;

subplot('Position',[0.05+0.5.*rem(panel-1,2) 0.59-0.49*floor((panel-1)/2) 0.438 0.38]);
% Get Basline parameters
[~,~,R0,ts,td] = BaselineParameters(tL); % Does not matter here what ts is fed in 
tt=linspace(0,35,100001);
pA=0.8191;
SelfIsolate=1;
VS=InfectiousnessfromInfection(tt,R0,R0,pA,ts,tL,td,SelfIsolate);
VNS=InfectiousnessfromInfection(tt,R0,R0,pA,ts,tL,td,0);
RS=integral(@(x)InfectiousnessfromInfection(x,R0,R0,pA,ts,tL,td,SelfIsolate),0,inf);


patch([tt flip(tt)],[VS zeros(size(tt))],hex2rgb('#F5BE41'),'LineStyle','none','Facealpha',0.3); hold on
text(-1.534999999999991+ts,0.35, num2str(round(RS,1),'%2.1f'),'Fontsize',16,'HorizontalAlignment','center');

p3=plot(tt,VS,'color',hex2rgb('#F5BE41'),'LineWidth',2); hold on
p1=plot(tt,VNS,'color',hex2rgb('#2A3132'),'LineWidth',2); hold on


legend([p1 p3],{'No self-isolation',['Self-isolation and ' num2str(100*pA) '% asymptomatic']},'Fontsize',14);
legend boxoff;
box off;
xlabel('Days post-infection','Fontsize',18);
ylabel('Infectivity','Fontsize',18);

ylim([0 0.7]);
xlim([0 25]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',16,'XTick',[0:25],'XMinorTick','on','Yminortick','on','YTick',[0:0.1:0.9]);
text(-2.836,0.7,'B','Fontsize',32,'Fontweight','bold');
print(gcf,['Figure_Infectivity_5_72.png'],'-dpng','-r600');
