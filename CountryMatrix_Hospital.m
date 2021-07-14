function CountryMatrix_Hospital(cFile,AL,AQ)

load('Country_Data_June_27_2021_Adherence_Level_100.mat','CountryM','cstatusR')
TT=[[1:29]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

NM=length(CountryM);

QM0=-1.*ones(NM);
QM14=-1.*ones(NM);


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
             
             IA=InfectionsVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,14,AL,AQ,cFile);
             [QM14(ii,jj)]=sum(proHA.*IA)*14*100000./NA;
            
             IB=InfectionsVOCAll(nageB,nageA,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,14,AL,AQ,cFile);
             [QM14(jj,ii)]=sum(proHB.*IB)*14*100000./NB;
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
% print(gcf,['Figure_Country_Hospital_No_Quarantine_' cFile '.png'],'-dpng','-r600');


PlotQuarantineHospitalizationHighLow(CountryM,QM0,CSR)
print(gcf,['Figure_Country_Hospital_High_Low_No_Travel_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(AQ*100) '.png'],'-dpng','-r600');


RRR=(QM0-QM14)./abs(QM0); % abs is to account for any negative imminent infections
RRR=100.*RRR;
RRR(QM0==-1)=-1;

PlotQuarantineHospitalizationReduction(CountryM,RRR,CSR)
print(gcf,['Figure_Country_Hospital_Reduction_Q=0_to_Q=14_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(AQ*100) '.png'],'-dpng','-r600');

fprintf('Maximum reduction in hospitalization for going from 0-day to 14-day quarantine: %3.1f %% \n',max(RRR(:)));
nnn=100.*length(RRR(RRR>=0 & RRR<1))./length(RRR(RRR>=0));
fprintf('Percent of pairs with less than one percent reduction in hospitalization for going from 0-day to 14-day quarantine: %3.1f %% \n',nnn);

end