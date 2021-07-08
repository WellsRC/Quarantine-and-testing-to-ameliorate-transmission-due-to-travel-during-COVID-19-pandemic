function TrafficLightAnalysis(cFile,AL,AQ)
if(contains(cFile,'Shorter'))
    Incubation=5.723;
else
    Incubation=8.29;
end
load(['Country_Data_June_27_2021_Adherence_Level_' num2str(AL*100) '.mat'],'pA','N','VTABM','avgABM','rec','Vacup');
rec=rec(:,1); % currently immunity is uniform. can take the first row and then compute the mean later
VABtemp=VTABM./repmat(N,1,29);
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
        [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,~,~,nageA,nageB] = TrafficDataReturn(StatusC(ii),StatusC(jj),vacA,vacB,recAU,recBU,NA,NB,pA,AL,Incubation);
            
        [qA,~] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacupA,vacupB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
        if(~isempty(qA))
            QM(ii,jj)=qA;
        else
            QM(ii,jj)=15;           
        end
    end
end
save(['Traffic_NO_VOC_Quarantine_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '.mat']);
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
print(gcf,['Figure3_' cFile '.eps'],'-depsc','-r600');