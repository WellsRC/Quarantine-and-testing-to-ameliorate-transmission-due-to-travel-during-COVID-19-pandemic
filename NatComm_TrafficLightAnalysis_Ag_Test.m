clear;
clc;

load('Country_Data_April_12_2021.mat','pA','N','VTABM','avgABM','rec','Vacup');
rec=rec(:,1); % currently immunity is uniform. can take the first row and then compute the mean later
VABtemp=VTABM./repmat(N,1,31);
VABtemp=mean(VABtemp(VABtemp>=0));
cFile={'NatComm-Quarantine_BDVeritor_Exit_Duration'};

recAU=mean(rec);
recBU=mean(rec);

vacA=mean(Vacup);
vacB=mean(Vacup);

NA=mean(N);
NB=mean(N);

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
        [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,nageA,nageB,RA,RB] = TrafficDataReturn(StatusC(ii),StatusC(jj),vacA,vacB,recAU,recBU,NA,NB,pA);
            
        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],RA,RB,pA,d,prevA,prevB,vacupA,vacupB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
        if(~isempty(qA))
            QM(ii,jj)=qA;
        else
            QM(ii,jj)=15;           
        end

    end
end
close all;
PlotQuarantineMatrixTraffic({'25','150','500','1000'},QM,3)
print(gcf,['Figure_Traffick_AgTest_Exit_NatComm.png'],'-dpng','-r600');
print(gcf,['FigureS18C.png'],'-dpng','-r600');