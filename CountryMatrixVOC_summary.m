function CountryMatrixVOC_summary(cFile,CountryInclude,AL)

load('Country_Data_June_9_2021.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);


NM=length(CountryM);

QM=-1.*ones(NM);
QMDeltaG478KV1=-1.*ones(NM);
QMAlpha20201201GRY=-1.*ones(NM);
QMBetaGH501YV2=-1.*ones(NM);
QMAllVOC=-1.*ones(NM);
qR=[0:14];


[RAlpha20201201GRY,RBetaGH501YV2,RDeltaG478KV1]=FactorIncreaseVOC;


for ii=1:NM
    if(sum(strcmp(CountryM(ii),CountryInclude))==1)
        for jj=(ii+1):NM
            if(sum(strcmp(CountryM(jj),CountryInclude))==1)
                [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,VOCDeltaG478KV1A,VOCDeltaG478KV1B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCBetaGH501YV2A,VOCBetaGH501YV2B] = DataReturnSim(CountryM(ii),CountryM(jj),AL);
                if(~isempty(VOCDeltaG478KV1A)&&~isempty(VOCDeltaG478KV1B)&&~isempty(VOCBetaGH501YV2A)&&~isempty(VOCBetaGH501YV2B)&&~isempty(VOCAlpha20201201GRYA)&&~isempty(VOCAlpha20201201GRYB))
                    if((VOCDeltaG478KV1A>=0)&&(VOCDeltaG478KV1B>=0)&&(VOCBetaGH501YV2A>=0)&&(VOCBetaGH501YV2B>=0)&&(VOCAlpha20201201GRYA>=0)&&(VOCAlpha20201201GRYB>=0))
                        
                        FVOCA=[1-VOCBetaGH501YV2A-VOCAlpha20201201GRYA-VOCDeltaG478KV1A VOCDeltaG478KV1A VOCAlpha20201201GRYA VOCBetaGH501YV2A];
                        FVOCB=[1-VOCDeltaG478KV1B-VOCAlpha20201201GRYB-VOCBetaGH501YV2B VOCDeltaG478KV1B VOCAlpha20201201GRYB VOCBetaGH501YV2B];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                        
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
                        
                        FVOCA=[0 VOCDeltaG478KV1A 0 0];
                        FVOCB=[0 VOCDeltaG478KV1B 0 0];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                        
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
                        
                        FVOCA=[0 0 VOCAlpha20201201GRYA 0];
                        FVOCB=[0 0 VOCAlpha20201201GRYB 0];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                        
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

                        FVOCA=[0 0 0 VOCBetaGH501YV2A];
                        FVOCB=[0 0 0 VOCBetaGH501YV2B];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                        
                        if(~isempty(qA))
                            QMBetaGH501YV2(ii,jj)=qA;
                        else
                            QMBetaGH501YV2(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMBetaGH501YV2(jj,ii)=qB;
                        else
                            QMBetaGH501YV2(jj,ii)=15;           
                        end

                        FVOCA=[0 VOCDeltaG478KV1A VOCAlpha20201201GRYA VOCBetaGH501YV2A];
                        FVOCB=[0 VOCDeltaG478KV1B VOCAlpha20201201GRYB VOCBetaGH501YV2B];
                        RVOC=[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2];
                        REPSVOC=[0 0 0 0];
                        RNIVOC=[0 0 0 0];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
                        
                        if(~isempty(qA))
                            QMAllVOC(ii,jj)=qA;
                        else
                            QMAllVOC(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMAllVOC(jj,ii)=qB;
                        else
                            QMAllVOC(jj,ii)=15;           
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

QMBetaGH501YV2=QMBetaGH501YV2(fnon,:);
QMBetaGH501YV2=QMBetaGH501YV2(:,fnon);

QMAllVOC=QMAllVOC(fnon,:);
QMAllVOC=QMAllVOC(:,fnon);
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
PlotQuarantineMatrixSummaryVOC(CountryM,QMAllVOC,CSR)
text(-1.119061166429583,13.411824324324336,'D','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_ONLY_Summary.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMDeltaG478KV1,CSR)
text(-1.119061166429583,13.411824324324336,'A','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Delta_ONLY_Summary.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMAlpha20201201GRY,CSR)
text(-1.119061166429583,13.411824324324336,'B','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Alpha_ONLY_Summary.eps'],'-depsc','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMBetaGH501YV2,CSR)
text(-1.119061166429583,13.411824324324336,'C','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_Beta_ONLY_Summary.eps'],'-depsc','-r600');
end