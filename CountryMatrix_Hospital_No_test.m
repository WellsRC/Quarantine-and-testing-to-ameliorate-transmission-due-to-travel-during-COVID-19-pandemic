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

cFile={'NoTest_Duration'};

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

save('Hospital_Country_NoTest_Q.mat');
% %%% Changed Republic of Ireland to Ireland to improve the visualization of
% %%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};
PlotQuarantineHospitalization(CountryM,QM0,CSR)
print(gcf,['Figure_Country_Hospital_NT.png'],'-dpng','-r600');
print(gcf,['FigureS6.png'],'-dpng','-r600');
RRR=(QM0-QM14)./QM0;
RRR=100.*RRR;
RRR(QM0==-1)=-1;

PlotQuarantineHospitalizationReduction(CountryM,RRR,CSR)
print(gcf,['Figure_Country_Hospital_Reduction_NT.png'],'-dpng','-r600');
print(gcf,['FigureS10.png'],'-dpng','-r600');