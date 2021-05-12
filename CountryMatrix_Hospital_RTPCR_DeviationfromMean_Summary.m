% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % Determines the 2-week hospitalization rate for a zero day quarantine and
% % a 14-day quarantine
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
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
             
        end
    end
end
load('Hospital_Country_RTPCR_Exit_Deviation_From_Mean.mat');
% % %%% Changed Republic of Ireland to Ireland to improve the visualization of
% % %%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};

MQM0=zeros(size(QM0));
for ii=1:NM
    temp=QM0(ii,:);
   MQM0(ii,:)=QM0(ii,:)-mean(temp(temp>=0)); 
end
MQM0(QM0<0)=-1;

SQ=sum(min(QM0,0),2);

fnon=find(SQ>(-1.*NM+6));

MQM0=MQM0(fnon,:);
MQM0=MQM0(:,fnon);

CountryM=CountryM(fnon);
CSR=CSR(fnon);

QM0=QM0(fnon,:);
QM0=QM0(:,fnon);

stdDev=zeros(length(fnon),1);
for ii=1:length(fnon)
    temp=MQM0(:,ii);
    temp2=QM0(:,ii);
   stdDev(ii)=mean(abs(temp(temp2>=0))); 
    
end
[~,indexS]=sort(stdDev);

CountryM=CountryM(indexS);
MQM0t=MQM0(indexS,indexS);

PlotQuarantineHospitalizationDeviation(CountryM,MQM0t)
print(gcf,['Figure_Country_Hospital_Deviation_0-day.png'],'-dpng','-r600');