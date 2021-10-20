function AIRLINETrafficLightAnalysis(cFile,DateI,AL,AQ,IncubationP)
load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '_AIRLINEMATRIX.mat'],'pA','N','VTABM','avgABM','rec','Vacup');
rec=rec(:,1); % currently immunity is uniform. can take the first row and then compute the mean later
VABtemp=VTABM./repmat(N,1,length(N));
VABtemp=mean(VABtemp(VABtemp>=0));

recAU=mean(rec(~isnan(rec)));
recBU=mean(rec(~isnan(rec)));

vacA=mean(Vacup(~isnan(rec)));
vacB=mean(Vacup(~isnan(rec)));

NA=mean(N(~isnan(rec)));
NB=mean(N(~isnan(rec)));

StatusC=([25 150 500 1000]);
vAB=VABtemp;
vBA=vAB;
dAB=mean(avgABM(avgABM>=0));
dBA=mean(avgABM(avgABM>=0));

NM=length(StatusC);

QM=-1.*ones(NM);
d=30;

qR=[0:14];
FVOCA=1;
FVOCB=1;
RVOC=0;
REPSVOC=0;
RNIVOC=0;
for ii=1:NM
    for jj=1:NM
        [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,~,~,nageA,nageB] = TrafficDataReturn(StatusC(ii),StatusC(jj),recAU,recBU,NA,NB,pA,AL,DateI,IncubationP);
            
        [qA,~] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
        if(~isempty(qA))
            QM(ii,jj)=qA;
        else
            QM(ii,jj)=15;           
        end
    end
end
save(['Traffic_NO_VOC_Quarantine_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '_AIRLINE.mat']);
if(contains(cFile,'RTPCR_Exit'))
    splotn=2;
elseif(contains(cFile,'NoTest'))
    splotn=1;
elseif(contains(cFile,'BDVeritor_Entry_Exit'))
    splotn=4;
else
    splotn=3;
end
PlotQuarantineMatrixTraffic({'25','150','500','1000'},QM,splotn)
print(gcf,['Figure3_' cFile '_' DateI{1} '_AIRLINE.eps'],'-depsc','-r600');