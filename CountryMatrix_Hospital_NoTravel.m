function CountryMatrix_Hospital_NoTravel(cFile,AL,AQ)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Determines the 2-week hospitalization rate travel and no travel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
load('Country_Data_June_27_2021_Adherence_Level_100.mat','CountryM','cstatusR')
TT=[[1:29]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

NM=length(CountryM);

QM0=-1.*ones(NM);
QMNT=-1.*ones(NM);


FVOCA=1;
FVOCB=1;
RVOC=0;
REPSVOC=0;
RNIVOC=0;
for ii=1:NM
    for jj=(ii+1):NM
        [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),AL,cFile);
        if(~isempty(prevA))
            
            vAB=(VTAB./NA);
            vBA=(VTBA./NB);
            
             IA=InfectionsVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,0,AL,AQ,cFile);
             [QM0(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,0,AL,AQ,cFile);
             [QM0(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
             
             IA=InfectionsVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,-1,AL,AQ,cFile);
             [QMNT(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,-1,AL,AQ,cFile);
             [QMNT(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
        end
    end
end
% %%% Changed Republic of Ireland to Ireland to improve the visualization of
% %%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};
% PlotQuarantineHospitalization(CountryM,QM0,CSR)
% print(gcf,['Figure_Country_Hospital_NoTest_0Day_Quarantine.png'],'-dpng','-r600');
% 
% PlotQuarantineHospitalization(CountryM,QMNT,CSR)
% print(gcf,['Figure_Country_Hospital_NoTest_No_Travel.png'],'-dpng','-r600');

% RRR=(QM0-QMNT)./QMNT;
% RRR=100.*RRR;
% RRR(QM0==-1)=-1;
% 
% PlotQuarantineHospitalizationReduction_NoTravel(CountryM,RRR,CSR)
% print(gcf,['Figure_Country_Hospital_Relative_Reduction_No_Travel_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(AQ*100) '.png'],'-dpng','-r600');

RRR=(QM0-QMNT);
RRR(QM0==-1)=-1;

PlotQuarantineHospitalizationAbsReduction_NoTravel(CountryM,RRR,CSR)
print(gcf,['Figure_Country_Hospital_Relative_Reduction_No_Travel_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(AQ*100) '.png'],'-dpng','-r600');
end