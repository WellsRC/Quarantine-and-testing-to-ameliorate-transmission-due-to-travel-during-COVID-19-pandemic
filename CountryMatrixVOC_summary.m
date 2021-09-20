function CountryMatrixVOC_summary(cFile,CountryInclude,DateI,AL,AQ,IncubationP)

    load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);


NM=length(CountryM);

QM=-1.*ones(NM);
QMDeltaG478KV1=-1.*ones(NM);
QMAlpha20201201GRY=-1.*ones(NM);
QMGeneral=-1.*ones(NM);
QMAllVOC=-1.*ones(NM);
qR=[0:14];


[RAlpha20201201GRY,~,RDeltaG478KV1]=FactorIncreaseVOC;


for ii=1:NM
    if(sum(strcmp(CountryM(ii),CountryInclude))==1)
        for jj=(ii+1):NM
            if(sum(strcmp(CountryM(jj),CountryInclude))==1)
                [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,VOCDeltaG478KV1A,VOCDeltaG478KV1B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
                if(~isempty(VOCDeltaG478KV1A)&&~isempty(VOCDeltaG478KV1B)&&~isempty(VOCAlpha20201201GRYA)&&~isempty(VOCAlpha20201201GRYB))
                    if((VOCDeltaG478KV1A>=0)&&(VOCDeltaG478KV1B>=0)&&(VOCAlpha20201201GRYA>=0)&&(VOCAlpha20201201GRYB>=0))
                        
                        FVOCA=[max(1-VOCAlpha20201201GRYA-VOCDeltaG478KV1A,0) VOCDeltaG478KV1A VOCAlpha20201201GRYA];
                        FVOCB=[max(1-VOCDeltaG478KV1B-VOCAlpha20201201GRYB,0) VOCDeltaG478KV1B VOCAlpha20201201GRYB];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY];
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
                        
                        FVOCA=[0 VOCDeltaG478KV1A 0];
                        FVOCB=[0 VOCDeltaG478KV1B 0];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY];
                        REPSVOC=[0 0 0];
                        RNIVOC=[0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                        
                        if(~isempty(qA))
                            QMDeltaG478KV1(ii,jj)=qA;
                        else
                            QMDeltaG478KV1(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMDeltaG478KV1(jj,ii)=qB;
                        else
                            QMDeltaG478KV1(jj,ii)=15;           
                        end
                        
                        FVOCA=[0 0 VOCAlpha20201201GRYA];
                        FVOCB=[0 0 VOCAlpha20201201GRYB];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY];
                        REPSVOC=[0 0 0];
                        RNIVOC=[0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                        
                        if(~isempty(qA))
                            QMAlpha20201201GRY(ii,jj)=qA;
                        else
                            QMAlpha20201201GRY(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMAlpha20201201GRY(jj,ii)=qB;
                        else
                            QMAlpha20201201GRY(jj,ii)=15;           
                        end

                        FVOCA=[max(1-VOCAlpha20201201GRYA-VOCDeltaG478KV1A,0) 0 0];
                        FVOCB=[max(1-VOCDeltaG478KV1B-VOCAlpha20201201GRYB,0) 0 0];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY];
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

QMDeltaG478KV1=QMDeltaG478KV1(fnon,:);
QMDeltaG478KV1=QMDeltaG478KV1(:,fnon);

QMAlpha20201201GRY=QMAlpha20201201GRY(fnon,:);
QMAlpha20201201GRY=QMAlpha20201201GRY(:,fnon);

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

PlotQuarantineMatrixSummaryVOC(CountryM,QMDeltaG478KV1,CSR)
text(-1.25206258890469,14.65675675675677,'A','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Delta_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMAlpha20201201GRY,CSR)
text(-1.25206258890469,14.65675675675677,'B','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Alpha_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMGeneral,CSR)
text(-1.25206258890469,14.65675675675677,'C','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Genral_ONLY_Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');


PlotQuarantineMatrixSummaryVOC(CountryM,QM,CSR)
text(-1.25206258890469,14.65675675675677,'D','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_ALL_GENERAL__Summary_' cFile '_AL=' num2str(100*AL) '_AQ=' num2str(AQ*100) '_' DateI{1} '.eps'],'-depsc','-r600');
end