close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compares quarantines between the EU- traffic light model and the country
% paired analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cFile='Quarantine_RTPCR_Exit';
AL=1;
AQ=1;
load(['Traffic_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_August 8, 2021.mat'],'QM');
QMG=QM;
load(['Country_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_August 8, 2021.mat'],'QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=1:4
    for jj=1:4
        if(ii>1)
            CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        else
            CQ=QM(CSR<CStatus(ii),:);
        end
        if(jj>1)
            CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        else
            CQ=CQ(:,CSR<CStatus(jj));
        end
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii)+(0.35.*(jj-2))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.7125+1.4625*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.925.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(5.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.112,16.1,0,'A','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 6.925]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.2 2.65 3 3.35 3.7 4.15 4.5 4.85 5.2 5.6500    6.0000    6.3500    6.7000],'XTickLabel',{'Green','Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['RTPCR_Compare.png'],'-dpng','-r600');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% No Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cFile='NoTest';
AL=1;
AQ=1;
load(['Traffic_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_August 8, 2021.mat'],'QM');
QMG=QM;
load(['Country_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_August 8, 2021.mat'],'QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=1:4
    for jj=1:4
        if(ii>1)
            CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        else
            CQ=QM(CSR<CStatus(ii),:);
        end
        if(jj>1)
            CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        else
            CQ=CQ(:,CSR<CStatus(jj));
        end
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii)+(0.35.*(jj-2))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.7125+1.4625*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.925.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(5.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.112,16.1,0,'B','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 6.925]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.2 2.65 3 3.35 3.7 4.15 4.5 4.85 5.2 5.6500    6.0000    6.3500    6.7000],'XTickLabel',{'Green','Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['No Test_Compare.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Ag Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cFile='Quarantine_BDVeritor_Exit';

AL=1;
AQ=1;
load(['Traffic_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_August 8, 2021.mat'],'QM');
QMG=QM;
load(['Country_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_August 8, 2021.mat'],'QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=1:4
    for jj=1:4
        if(ii>1)
            CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        else
            CQ=QM(CSR<CStatus(ii),:);
        end
        if(jj>1)
            CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        else
            CQ=CQ(:,CSR<CStatus(jj));
        end
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii)+(0.35.*(jj-2))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.7125+1.4625*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.925.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(5.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.112,16.1,0,'C','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 6.925]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.2 2.65 3 3.35 3.7 4.15 4.5 4.85 5.2 5.6500    6.0000    6.3500    6.7000],'XTickLabel',{'Green','Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;

print(gcf,['Ag Test_Compare.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Dual Ag Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cFile='Quarantine_BDVeritor_Entry_Exit';

AL=1;
AQ=1;
load(['Traffic_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_August 8, 2021.mat'],'QM');
QMG=QM;
load(['Country_NO_VOC_Quarantine_Shorter_Incubation_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_August 8, 2021.mat'],'QM','CSR');


Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];

CStatus=[25 150 500 100000];

figure('units','normalized','outerposition',[0.0 0.1 0.7 0.7]);
subplot('Position',[0.14,0.335,0.851234939759036,0.6]);
for ii=1:4
    for jj=1:4
        if(ii>1)
            CQ=QM(CSR<CStatus(ii) & CSR>=CStatus(ii-1),:);
        else
            CQ=QM(CSR<CStatus(ii),:);
        end
        if(jj>1)
            CQ=CQ(:,CSR<CStatus(jj) & CSR>=CStatus(jj-1));
        else
            CQ=CQ(:,CSR<CStatus(jj));
        end
        CQ=CQ(CQ>=0 & CQ<=15);
        scatter(1.5.*(ii)+(0.35.*(jj-2))+0.2.*(rand(size(CQ))-0.5),CQ,30,ColT(jj,:),'filled'); hold on;
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),median(CQ).*ones(101,1),'-.','color',ColT(jj,:),'LineWidth',2);
        
        plot(1.5.*(ii)+(0.35.*(jj-2))+linspace(-0.15,0.15,101),QMG(ii,jj).*ones(101,1),'color','k','LineWidth',2);
    end
    
    text(1.7125+1.4625*(ii-1),16,Stt(ii),'HorizontalAlignment','center','Fontsize',24);
end
plot(2.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(3.925.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
plot(5.425.*ones(101,1),linspace(-0.1,15,101),'color',[0.8 0.8 0.8],'LineWidth',2);
text(0.112,16.1,0,'D','Fontsize',32,'FontWeight','bold');
ylim([-0.2 15]);
xlim([0.9 6.925]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',24,'XTick',[1.15 1.5 1.85 2.2 2.65 3 3.35 3.7 4.15 4.5 4.85 5.2 5.6500    6.0000    6.3500    6.7000],'XTickLabel',{'Green','Amber','Red','Dark Red'},'YTick',[0:15],'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'})
xlabel('Status of origin country','Fontsize',26);
ylabel({'Quarantine duration','(days)'},'Fontsize',26,'Position',[0.519522115056493,7.40000724643469]);
xtickangle(90);
box off;


print(gcf,['Dual_Ag Test_Compare.png'],'-dpng','-r600');