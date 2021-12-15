function CountryMatrixVOC(cFile,DateI,AL,AQ,IncubationP)

    load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

NM=length(CountryM);

QM=-1.*ones(NM);
qR=[0:14];

[RDelta,ROmicron]=FactorIncreaseVOC;

for ii=1:NM
    for jj=(ii+1):NM
        [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,VOCDeltaA,VOCDeltaB,VOCOmincronA,VOCOmincronB] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
        if(~isempty(VOCDeltaA)&&~isempty(VOCDeltaB)&&~isempty(VOCOmincronA)&&~isempty(VOCOmincronB))
              if((VOCDeltaA>=0)&&(VOCDeltaB>=0)&&(VOCOmincronA>=0)&&(VOCOmincronB>=0))
                vAB=(VTAB./NA);
                vBA=(VTBA./NB);
                FVOCA=[max(1-VOCOmincronA-VOCDeltaA,0) VOCDeltaA VOCOmincronA ];
                FVOCB=[max(1-VOCDeltaB-VOCOmincronB,0) VOCDeltaB VOCOmincronB ];
                RVOC=[0 RDelta ROmicron];
                REPSVOC=[0 0 0];
                RNIVOC=[0 0 0];
                [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                if(~isempty(qA))
                    QM(ii,jj)=qA;
                else
                    QM(ii,jj)=15;   
                end

                if(~isempty(qB))
                    QM(jj,ii)=qB;
                else
                    QM(jj,ii)=15;  
                end
                
            end
        end
    end
end


save(['Country_VOC_Quarantine_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_' DateI{1} '.mat']);

SQ=sum(min(QM,0),2);

fnon=find(SQ>(-1.*NM));
% save(['Country_VOC_' cFile '.mat']);
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

print(gcf,['Figure_Country_VOC_' cFile '_Full_' DateI{1} '.png'],'-dpng','-r600');

% writetable(T,['VOC_Hellewell_et_al_' cFile '.csv']);
end