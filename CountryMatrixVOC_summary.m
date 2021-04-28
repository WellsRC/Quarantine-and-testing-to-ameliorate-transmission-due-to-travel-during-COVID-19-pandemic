%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% B117 and 501YV2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;


load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

cFile={'Quarantine_RTPCR_Exit_Duration'};


NM=length(CountryM);

QM=-1.*ones(NM);
QMB117=-1.*ones(NM);
QM501YV2=-1.*ones(NM);
QMB117501YV2=-1.*ones(NM);
d=30;
qR=[0:14];

% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
%https://science.sciencemag.org/content/early/2021/03/03/science.abg3055 , https://www.nature.com/articles/s41586-021-03470-x
RB117=0.82;
% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
R501YV2=0.5;

VOCF=-1.*ones(NM,2);
CountryNotInlcude={'Serbia','Hungary','Russia','Denmark','Bulgaria','Finland','Estonia','Greece','Cyprus','Portugal','Norway'};
for ii=1:NM
    if(sum(strcmp(CountryM(ii),CountryNotInlcude))<1)
        for jj=(ii+1):NM
            if(sum(strcmp(CountryM(jj),CountryNotInlcude))<1)
                [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,RA,RB,~,VOCB117A,VOCB117B,~,~,VOC501YV2A,VOC501YV2B] = DataReturnSim(CountryM(ii),CountryM(jj),[],[],cFile);
                if(~isempty(VOCB117A)&&~isempty(VOCB117B)&&~isempty(VOC501YV2A)&&~isempty(VOC501YV2B))
                    if((VOCB117A>=0)&&(VOCB117B>=0)&&(VOC501YV2A>=0)&&(VOC501YV2B>=0))
                        VOCF(ii,:)=[VOCB117A VOC501YV2A];
                        VOCF(jj,:)=[VOCB117B VOC501YV2B];
                        vAB=(VTAB./NA);
                        vBA=(VTBA./NB);
                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1-VOC501YV2A-VOCB117A VOCB117A VOC501YV2A],[1-VOCB117B-VOC501YV2B VOCB117B VOC501YV2B],[0 RB117 R501YV2],[0 0 0],[0 0 0; 0 0 0; 0 0 0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
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

                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[0 VOCB117A 0],[0 VOCB117B 0],[0 RB117 R501YV2],[0 0 0],[0 0 0; 0 0 0; 0 0 0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
                        if(~isempty(qA))
                            QMB117(ii,jj)=qA;
                        else
                            QMB117(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMB117(jj,ii)=qB;
                        else
                            QMB117(jj,ii)=15;           
                        end

                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[0 0 VOC501YV2A],[0 0 VOC501YV2B],[0 RB117 R501YV2],[0 0 0],[0 0 0; 0 0 0; 0 0 0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
                        if(~isempty(qA))
                            QM501YV2(ii,jj)=qA;
                        else
                            QM501YV2(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QM501YV2(jj,ii)=qB;
                        else
                            QM501YV2(jj,ii)=15;           
                        end

                        [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[0 VOCB117A VOC501YV2A],[0 VOCB117B VOC501YV2B],[0 RB117 R501YV2],[0 0 0],[0 0 0; 0 0 0; 0 0 0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
                        if(~isempty(qA))
                            QMB117501YV2(ii,jj)=qA;
                        else
                            QMB117501YV2(ii,jj)=15;           
                        end

                        if(~isempty(qB))
                            QMB117501YV2(jj,ii)=qB;
                        else
                            QMB117501YV2(jj,ii)=15;           
                        end

                    end
                end
            end
        end
    end
end

SQ=sum(min(QM,0),2);

fnon=find(SQ>(-1.*NM+6));

QM=QM(fnon,:);
QM=QM(:,fnon);

QMB117=QMB117(fnon,:);
QMB117=QMB117(:,fnon);

QM501YV2=QM501YV2(fnon,:);
QM501YV2=QM501YV2(:,fnon);

QMB117501YV2=QMB117501YV2(fnon,:);
QMB117501YV2=QMB117501YV2(:,fnon);
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
PlotQuarantineMatrixSummaryVOC(CountryM,QM,CSR)
text(-1.119061166429583,13.411824324324336,'D','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_B117_501YV2_Summary.png'],'-dpng','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMB117,CSR)
text(-1.119061166429583,13.411824324324336,'A','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_B117_ONLY_Summary.png'],'-dpng','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QM501YV2,CSR)
text(-1.119061166429583,13.411824324324336,'B','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_501YV2_ONLY_Summary.png'],'-dpng','-r600');

PlotQuarantineMatrixSummaryVOC(CountryM,QMB117501YV2,CSR)
text(-1.119061166429583,13.411824324324336,'C','Fontsize',38,'FontWeight','bold');
print(gcf,['Figure_Country_VOC_B117_501YV2_ONLY_Summary.png'],'-dpng','-r600');
