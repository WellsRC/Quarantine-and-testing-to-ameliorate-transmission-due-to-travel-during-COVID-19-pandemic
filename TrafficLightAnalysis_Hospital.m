% clear;
% clc;
% AL=1;
% AQ=1;
% Incubation=8.29;
% load(['Country_Data_June_27_2021_Adherence_Level_' num2str(AL*100) '.mat'],'pA','N','VTABM','avgABM','rec','Vacup');
% rec=rec(:,1); % currently immunity is uniform. can take the first row and then compute the mean later
% VABtemp=VTABM./repmat(N,1,29);
% VABtemp=mean(VABtemp(VABtemp>=0));
% cFile='Quarantine_RTPCR_Exit';
% 
% 
% recAU=mean(rec);
% recBU=mean(rec);
% 
% vacA=linspace(0,1,101);
% vacB=linspace(0,1,101);
% 
% NA=mean(N);
% NB=mean(N);
% 
% StatusC=([25 150 500 1000]);
% vAB=VABtemp;
% vBA=vAB;
% dAB=mean(avgABM(avgABM>=0));
% dBA=mean(avgABM(avgABM>=0));
% 
% NM=length(StatusC);
% 
% QM=-1.*ones(15,101);
% QMH=-1.*ones(15,101);
% 
% QMI=-1.*ones(15,101);
% QMHI=-1.*ones(15,101);
% 
% d=30;
% 
% qR=[0:14];
% FVOCA=1;
% FVOCB=1;
% RVOC=0;
% REPSVOC=0;
% RNIVOC=0;
% for tqd=0:14
%     ii=1; % Destination country is in Green Status
%     jj=4; % Origin country is in Dark Red status
%     [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,nageA,nageB] = TrafficDataReturn(StatusC(ii),StatusC(jj),0,0,recAU,recBU,NA,NB,pA,AL,Incubation);
%     IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,-1,AL,AQ,cFile); %Zero vaccination coverage and border closure
%     ZH=sum(proHA.*IA)*14*100000./NA;
%     for vvv=1:101
%         [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,nageA,nageB] = TrafficDataReturn(StatusC(ii),StatusC(jj),vacA(vvv),vacB(vvv),recAU,recBU,NA,NB,pA,AL,Incubation);
% 
%         [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
%         IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,qA,AL,AQ,cFile);
%         [QM(tqd+1,vvv)]=sum(proHA.*IA)*14*100000./NA;
%         QMI(tqd+1,vvv)=sum(IA)*14*100000./NA;
%         
%             IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,tqd,AL,AQ,cFile); %Zero vaccination coverage and border closure
%             ZHtemp=sum(proHA.*IA)*14*100000./NA;
%            
%             QMH(tqd+1,vvv)=ZHtemp;
%             QMHI(tqd+1,vvv)=sum(IA)*14*100000./NA;     
%     end
% end

load('Traffic_Hospital_VaccineUptake.mat');
figure('units','normalized','outerposition',[0 0.05 0.8 0.7]);

subplot('Position',[0.101210526315789,0.175082956259427,0.880368421052631,0.8]);
test=squeeze(QM(1,:)); % Green with Dark-red
plot(100.*vacA,QMH(1,:),'color',hex2rgb('CB6318'),'LineWidth',2); hold on
plot(100.*vacA,QMH(end,:),'color',hex2rgb('90AFC5'),'LineWidth',2);
plot(100.*vacA,test,'k','LineWidth',2);


box off;
set(gca,'LineWidth',2,'tickdir','out','fontsize',16,'XTick',[0:10:100]','Xminortick','on','YTick',[0:0.25:2],'Yminortick','on','Xlim',[0 100],'Ylim',[0 1.75]);
xtickformat(gca, 'percentage');
% xtickangle(45);
ylabel({'Two-week hospitalization rate','(per 100,000 residents)'},'Fontsize',20);
xlabel('Vaccine coverage in destination country','Fontsize',20);

% Create arrow
annotation(gcf,'arrow',[0.534868421052632 0.455921052631579],[0.558069381598793 0.395173453996983],'Color',[0.650980392156863 0.650980392156863 0.650980392156863],'LineWidth',2,'LineStyle','--');

% Create arrow
annotation(gcf,'arrow',[0.976973684210526 0.543421052631579],...
    [0.555052790346908 0.369532428355958],...
    'Color',[0.650980392156863 0.650980392156863 0.650980392156863],...
    'LineWidth',2,...
    'LineStyle','--');

axes('Position',[0.548684210526316,0.627450980392157,0.430921052631577,0.345399698340875])
plot(100.*vacA,QMH(1,:),'color',hex2rgb('CB6318'),'LineWidth',2); hold on
plot(100.*vacA,test,'k','LineWidth',2);
plot(100.*vacA,QMH(end,:),'color',hex2rgb('90AFC5'),'LineWidth',2);
ylabel({'Two-week','hospitalization rate','(per 100,000 residents)'},'Fontsize',18);
xlabel('Vaccine coverage in destination country','Fontsize',18,'Position',[27.45419847328244,0.539684881037066]);
xtickformat(gca, 'percentage');
% xtickangle(45);
set(gca,'LineWidth',2,'tickdir','out','fontsize',16,'XTick',[40:1:50]','Xminortick','on','YTick',[0.40:0.01:0.47],'Yminortick','on','Xlim',[40 50],'Ylim',[0.40 0.47]);
box off;

legend({'Zero-day quarantine','Six-day quarantine','14-day quarantine'},'Fontsize',18)
legend boxoff;


print(gcf,['Figure5.eps'],'-depsc','-r600');
print(gcf,['Figure_Hospital_Vac.png'],'-dpng','-r600');