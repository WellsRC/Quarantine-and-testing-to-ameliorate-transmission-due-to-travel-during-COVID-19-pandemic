clear;
clc;

load('Country_Data_April_12_2021.mat','pA','N','VTABM','avgABM','rec');
rec=rec(:,1); % currently immunity is uniform. can take the first row and then compute the mean later
VABtemp=VTABM./repmat(N,1,31);
VABtemp=mean(VABtemp(VABtemp>=0));
cFile={'Quarantine_RTPCR_Exit_Duration'};


recAU=mean(rec);
recBU=mean(rec);

vacA=linspace(0,1,101);
vacB=linspace(0,1,101);

NA=mean(N);
NB=mean(N);

StatusC=([25 150 500 1000]);
vAB=VABtemp;
vBA=vAB;
dAB=mean(avgABM(avgABM>=0));
dBA=mean(avgABM(avgABM>=0));

NM=length(StatusC);

QM=-1.*ones(1,101);
QMH=-1.*ones(1,101);

d=30;

qR=[0:14];
FVOCA=1;
FVOCB=1;
RVOC=0;
REPSVOC=0;
RNIVOC=0;
    ii=1; % Destination country is in Green Status
    jj=4; % Origin country is in Dark Red status
    [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,nageA,nageB,RA,RB] = TrafficDataReturn(StatusC(ii),StatusC(jj),0,0,recAU,recBU,NA,NB,pA);
    IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],RA,pA,d,prevA,prevB,vacupA,vacupB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,-1,cFile); %Zero vaccination coverage and border closure
    ZH=sum(proHA.*IA)*14*100000./NA;
    for vvv=1:101
        [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,nageA,nageB,RA,RB] = TrafficDataReturn(StatusC(ii),StatusC(jj),vacA(vvv),vacB(vvv),recAU,recBU,NA,NB,pA);

        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],RA,RB,pA,d,prevA,prevB,vacupA,vacupB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
        [QM(vvv)]=qA;
        tqd=0;
        while(tqd<=14)
            IA=InfectionsVOCAll(nageA,nageB,[1],[1],[0],[0],[0],RA,pA,d,prevA,prevB,vacupA,vacupB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,tqd,cFile); %Zero vaccination coverage and border closure
            ZHtemp=sum(proHA.*IA)*14*100000./NA;
            if(ZHtemp<=ZH)
                QMH(vvv)=tqd;
                tqd=15;
            else
                tqd=tqd+1;
            end
        end
    end

save('Traffic_Hospital_VaccineUptake_Hospital_Threshold.mat');