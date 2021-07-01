function CountryMatrixVOC(cFile,AL)

T=[];
for zzz=3:-1:1
    AL=0.5+0.25.*(zzz-1)
load('Country_Data_June_9_2021_Adherence_Level_100.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

NM=length(CountryM);

QM=-1.*ones(NM);
qR=[0:14];

[RAlpha20201201GRY,RBetaGH501YV2,RDeltaG478KV1]=FactorIncreaseVOC;

for ii=1:NM
    for jj=(ii+1):NM
        [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,VOCDeltaG478KV1A,VOCDeltaG478KV1B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCBetaGH501YV2A,VOCBetaGH501YV2B] = DataReturnSim(CountryM(ii),CountryM(jj),AL);
        if(~isempty(VOCDeltaG478KV1A)&&~isempty(VOCDeltaG478KV1B)&&~isempty(VOCBetaGH501YV2A)&&~isempty(VOCBetaGH501YV2B)&&~isempty(VOCAlpha20201201GRYA)&&~isempty(VOCAlpha20201201GRYB))
            if((VOCDeltaG478KV1A>=0)&&(VOCDeltaG478KV1B>=0)&&(VOCBetaGH501YV2A>=0)&&(VOCBetaGH501YV2B>=0)&&(VOCAlpha20201201GRYA>=0)&&(VOCAlpha20201201GRYB>=0))
                vAB=(VTAB./NA);
                vBA=(VTBA./NB);
                FVOCA=[1-VOCBetaGH501YV2A-VOCAlpha20201201GRYA-VOCDeltaG478KV1A VOCDeltaG478KV1A VOCAlpha20201201GRYA VOCBetaGH501YV2A];
                FVOCB=[1-VOCDeltaG478KV1B-VOCAlpha20201201GRYB-VOCBetaGH501YV2B VOCDeltaG478KV1B VOCAlpha20201201GRYB VOCBetaGH501YV2B];
                RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                REPSVOC=[0 0 0 0];
                RNIVOC=[0 0 0 0];
                [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                if(~isempty(qA))
                    QM(ii,jj)=qA;
                else
                    QM(ii,jj)=15;    
                    qA=15;
                end

                if(~isempty(qB))
                    QM(jj,ii)=qB;
                else
                    QM(jj,ii)=15;  
                    qB=15;
                end
                
                if(isempty(T))
                   T=table(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,qA,qB); 
                else
                   Ttemp=table(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,qA,qB); 
                   T=[T;Ttemp];
                end
            end
        end
    end
end


SQ=sum(min(QM,0),2);

fnon=find(SQ>(-1.*NM));
save(['Country_VOC_' cFile '.mat']);
QM=QM(fnon,:);
QM=QM(:,fnon);

%%% Changed Republic of Ireland to Ireland to improve the visualization of
%%% the figure
t=strcmp(CountryM,'United Kingdom');
CountryM(t)={'U.K.'};
t=strcmp(CountryM,'Republic of Ireland');
CountryM(t)={'Ireland'};
t=strcmp(CountryM,'Czech Republic');
CountryM(t)={'Czechia'};


CountryM=CountryM(fnon);
CSR=CSR(fnon);
PlotQuarantineMatrix(CountryM,QM,CSR)

print(gcf,['Figure_Country_VOC_' cFile '_Full.png'],'-dpng','-r600');
end

writetable(T,['VOC_Hellewell_et_al_' cFile '.csv']);
end