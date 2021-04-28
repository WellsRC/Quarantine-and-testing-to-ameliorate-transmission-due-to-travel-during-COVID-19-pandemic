%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Determines the 2-week hospitalization rate for a zero day quarantine and
% a 14-day quarantine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

clear;
clc;

load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

cFile={'Quarantine_RTPCR_Exit_Duration'};

NM=length(CountryM);

QM0=-1.*ones(NM);
QM14=-1.*ones(NM);

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
             
             IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],RA,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,14,cFile);
             [QM14(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,[1],[1],[0],[0],[0],RB,pA,d,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,14,cFile);
             [QM14(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
        end
    end
end
% save('Hospital_Country_RTPCR_Exit.mat');
% %%% Changed Republic of Ireland to Ireland to improve the visualization of
% %%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};

SQ=sum(min(QM0,0),2);

fnon=find(SQ>(-1.*NM+6));

QM0=QM0(fnon,:);
QM0=QM0(:,fnon);

QM14=QM14(fnon,:);
QM14=QM14(:,fnon);

CountryM=CountryM(fnon);
CSR=CSR(fnon);

PlotQuarantineHospitalization_Summary(CountryM,QM0,CSR)

text(-2.125802579686395,24.29232995658466,0,'A','Fontsize',32,'FontWeight','bold')
print(gcf,['Figure_Summary_Hosptial_Rate.png'],'-dpng','-r600');
RRR=(QM0-QM14)./QM0;
RRR=100.*RRR;
RRR(QM0==-1)=-1;


PlotQuarantineHospitalizationReduction_Summary(CountryM,RRR,CSR)
text(-2.125802579686395,24.29232995658466,0,'B','Fontsize',32,'FontWeight','bold')
print(gcf,['Figure_Summary_Hosptial_Reduction.png'],'-dpng','-r600');