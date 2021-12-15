function CountryMatrixVOC_summary(cFile,CountryInclude,DateI,AL,AQ,IncubationP)

    load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);


NM=length(CountryM);

QM=-1.*ones(NM);
QMDelta=-1.*ones(NM);
QMOmicron=-1.*ones(NM);
QMGeneral=-1.*ones(NM);
qR=[0:14];


[RDelta,ROmicron]=FactorIncreaseVOC;


for ii=1:NM
    if(sum(strcmp(CountryM(ii),CountryInclude))==1)
        for jj=(ii+1):NM
            if(sum(strcmp(CountryM(jj),CountryInclude))==1)
                [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,VOCDeltaA,VOCDeltaB,VOCOmincronA,VOCOmincronB] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
                if(~isempty(VOCDeltaA)&&~isempty(VOCDeltaB)&&~isempty(VOCOmincronA)&&~isempty(VOCOmincronB))
                    if((VOCDeltaA>=0)&&(VOCDeltaB>=0)&&(VOCOmincronA>=0)&&(VOCOmincronB>=0))
                        
                        FVOCA=[max(1-VOCOmincronA-VOCDeltaA,0) VOCDeltaA VOCOmincronA];
                        FVOCB=[max(1-VOCDeltaB-VOCOmincronB,0) VOCDeltaB VOCOmincronB];
                        RVOC=[0 RDelta ROmicron];
                        REPSVOC=[0 0 0];
                        RNIVOC=[0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
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
                        
                        FVOCA=[0 VOCDeltaA 0];
                        FVOCB=[0 VOCDeltaB 0];
                        RVOC=[0 RDelta ROmicron];
                        REPSVOC=[0 0 0];
                        RNIVOC=[0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                        
                        if(~isempty(qA))
                            QMDelta(ii,jj)=qA;
                        else
                            QMDelta(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMDelta(jj,ii)=qB;
                        else
                            QMDelta(jj,ii)=15;           
                        end
                        
                        FVOCA=[0 0 VOCOmincronA];
                        FVOCB=[0 0 VOCOmincronB];
                        RVOC=[0 RDelta ROmicron];
                        REPSVOC=[0 0 0];
                        RNIVOC=[0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                        
                        if(~isempty(qA))
                            QMOmicron(ii,jj)=qA;
                        else
                            QMOmicron(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMOmicron(jj,ii)=qB;
                        else
                            QMOmicron(jj,ii)=15;           
                        end

                        FVOCA=[max(1-VOCOmincronA-VOCDeltaA,0) 0 0];
                        FVOCB=[max(1-VOCDeltaB-VOCOmincronB,0) 0 0];
                        RVOC=[0 RDelta ROmicron];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                        
                        if(~isempty(qA))
                            QMGeneral(ii,jj)=qA;
                        else
                            QMGeneral(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMGeneral(jj,ii)=qB;
                        else
                            QMGeneral(jj,ii)=15;           
                        end
                    end
                end
            end
        end
    end
end

SQ=sum(min(QM,0),2);

fnon=find(SQ>(-1.*NM+5));

QM=QM(fnon,:);
QM=QM(:,fnon);

QMDelta=QMDelta(fnon,:);
QMDelta=QMDelta(:,fnon);

QMOmicron=QMOmicron(fnon,:);
QMOmicron=QMOmicron(:,fnon);

QMGeneral=QMGeneral(fnon,:);
QMGeneral=QMGeneral(:,fnon);

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

PlotQuarantineMatrixSummaryVOC(CountryM,QMDelta,CSR)
text(-1.102702702702699,13.332432432432444,0,'A','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Delta_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMOmicron,CSR)
text(-1.102702702702699,13.332432432432444,0,'B','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Omicron_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMGeneral,CSR)
text(-1.102702702702699,13.332432432432444,0,'C','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Genral_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');


PlotQuarantineMatrixSummaryVOC(CountryM,QM,CSR)
text(-1.102702702702699,13.332432432432444,0,'D','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_ALL_GENERAL__Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');
end