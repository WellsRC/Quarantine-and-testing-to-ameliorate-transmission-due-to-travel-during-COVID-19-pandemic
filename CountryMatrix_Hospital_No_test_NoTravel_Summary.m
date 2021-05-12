% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % Determines the 2-week hospitalization rate for a zero day quarantine and
% % a 14-day quarantine
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

clear;
clc;

load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

cFile={'NoTest_Duration'};

NM=length(CountryM);

QM0=-1.*ones(NM);
QMNT=-1.*ones(NM);

d=30;

FVOCA=1;
FVOCB=1;
RVOC=0;
REPSVOC=0;
RNIVOC=0;
for ii=1:NM
    for jj=(ii+1):NM
        [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,RA,RB,~,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),[],[],cFile);
        if(~isempty(prevA))
            
            vAB=(VTAB./NA);
            vBA=(VTBA./NB);
            
             IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],RA,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,0,cFile);
             [QM0(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,[1],[1],[0],[0],[0],RB,pA,d,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,0,cFile);
             [QM0(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
             
             IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],RA,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,-1,cFile);
             [QMNT(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,[1],[1],[0],[0],[0],RB,pA,d,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,-1,cFile);
             [QMNT(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
        end
    end
end
load('Impact_of_Travel_On_Hospitalization_Rate_Origin_Country.mat');
% %%% Changed Republic of Ireland to Ireland to improve the visualization of
% %%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};
PlotQuarantineHospitalization(CountryM,QM0,CSR)
print(gcf,['Figure_Country_Hospital_NoTest_0Day_Quarantine.png'],'-dpng','-r600');

PlotQuarantineHospitalization(CountryM,QMNT,CSR)
print(gcf,['Figure_Country_Hospital_NoTest_No_Travel.png'],'-dpng','-r600');

RRR=(QM0-QMNT)./QMNT;
RRR=100.*RRR;
RRR(QM0==-1)=-1;

PlotQuarantineHospitalizationReduction_NoTravel(CountryM,RRR,CSR)
print(gcf,['Figure_Country_Hospital_Relative_Reduction_No_Travel_NoTest.png'],'-dpng','-r600');

RRR=(QM0-QMNT);
RRR(QM0==-1)=-1;

PlotQuarantineHospitalizationAbsReduction_NoTravel(CountryM,RRR,CSR)
print(gcf,['Figure_Country_Hospital_Absolute_Reduction_No_Travel_NoTest.png'],'-dpng','-r600');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Plot the Summary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
close all;
figure('units','normalized','outerposition',[0.05 0.05 1 1]);


RRR=(QM0-QMNT);

RRR(QM0==-1)=-1;

MImpact=zeros(length(QM0(:,1)),1);
for ii=1:length(QM0(:,1))
   temp=RRR(:,ii); % looking at the origin country ii and not destination country 
   temp2=QM0(:,ii);
   MImpact(ii)=mean(temp(temp2>=0));
end
[test,simpact]=sort(MImpact);

RRRt=RRR(:,simpact);
QM0t=QM0(:,simpact);

for ii=1:length(RRR(:,1))
   temp=RRRt(ii,:); % plotting across the orgin countries
   temp2=QM0t(ii,:);
   ff=find(temp2>=0);
   pp1=plot(ff,temp(ff),'k-o','LineWidth',2); hold on
end
pp2=plot([1:length(MImpact)],MImpact(simpact),'r:','LineWidth',4);

set(gca,'LineWidth',2','Tickdir','out','XTick',[1:31],'Xminortick','off','XTicklabel',{CountryM{simpact}},'Fontsize',20,'YTick',[-1:0.1:1],'Yminortick','on');

ylabel({'Net change','in two-week hospitalization rate','(per 100,000 residents) for destination country'},'Fontsize',26)
ylim([-1 1]);
xlim([1 31])
xlabel('Origin country','Fontsize',26)
box off;
legend([pp1 pp2],{'Destination country','Average'},'Fontsize',22);
legend boxoff;
xtickangle(90)
print(gcf,['Figure3.png'],'-dpng','-r600');