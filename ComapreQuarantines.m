close all;
load('Traffic_RTPCRTEST_Q.mat','QM');
QMG=QM;
load('RTPCR_Test_Country.mat','QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=2:4
    for jj=2:4
        CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii-1)+(0.35.*(jj-3))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.5.*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.25.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.75.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.235162190896505,16.01381197928641,0,'A','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 5.1]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.65 3 3.35 4.15 4.5 4.85],'XTickLabel',{'Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['RTPCR_Compare.png'],'-dpng','-r600');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% No Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
load('Traffic_NoTEST_Q.mat','QM');
QMG=QM;
load('No_Test_Country.mat','QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=2:4
    for jj=2:4
        CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii-1)+(0.35.*(jj-3))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.5.*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.25.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.75.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.235162190896505,16.01381197928641,0,'B','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 5.1]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.65 3 3.35 4.15 4.5 4.85],'XTickLabel',{'Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['No Test_Compare.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Ag Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
load('Traffic_AgTEST_Q.mat','QM');
QMG=QM;
load('Single_Ag_Test_Country.mat','QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=2:4
    for jj=2:4
        CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii-1)+(0.35.*(jj-3))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.5.*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.25.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.75.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.235162190896505,16.01381197928641,0,'C','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 5.1]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.65 3 3.35 4.15 4.5 4.85],'XTickLabel',{'Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['Ag Test_Compare.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Dual Ag Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
load('Traffic_DualAgTEST_Q.mat','QM');
QMG=QM;
load('Dual_Ag_Test_Country.mat','QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=2:4
    for jj=2:4
        CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii-1)+(0.35.*(jj-3))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii-1)+(0.35.*(jj-3))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.5.*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.25.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.75.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.235162190896505,16.01381197928641,0,'D','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 5.1]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.65 3 3.35 4.15 4.5 4.85],'XTickLabel',{'Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['Dual_Ag Test_Compare.png'],'-dpng','-r600');