function CountryMatrixVOC(cFile,AL)

load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
TT=[[1:31]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

NM=length(CountryM);

QM=-1.*ones(NM);
d=30;
qR=[0:14];

% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
%https://science.sciencemag.org/content/early/2021/03/03/science.abg3055 , https://www.nature.com/articles/s41586-021-03470-x
RAlpha20201201GRY=0.82;
% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
RBetaGH501YV2=0.5;

for ii=1:NM
    for jj=(ii+1):NM
        [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,RA,RB,~,VOCDeltaG478KV1A,VOCDeltaG478KV1B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCBetaGH501YV2A,VOCBetaGH501YV2B] = DataReturnSim(CountryM(ii),CountryM(jj),[],[],AL,cFile);
        if(~isempty(VOCDeltaG478KV1A)&&~isempty(VOCDeltaG478KV1B)&&~isempty(VOCBetaGH501YV2A)&&~isempty(VOCBetaGH501YV2B)&&~isempty(VOCAlpha20201201GRYA)&&~isempty(VOCAlpha20201201GRYB))
            if((VOCDeltaG478KV1A>=0)&&(VOCDeltaG478KV1B>=0)&&(VOCBetaGH501YV2A>=0)&&(VOCBetaGH501YV2B>=0)&&(VOCAlpha20201201GRYA>=0)&&(VOCAlpha20201201GRYB>=0))
                vAB=(VTAB./NA);
                vBA=(VTBA./NB);
                [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1-VOCBetaGH501YV2A-VOCAlpha20201201GRYA-VOCDeltaG478KV1A VOCDeltaG478KV1A VOCAlpha20201201GRYA VOCBetaGH501YV2A],[1-VOCDeltaG478KV1B-VOCAlpha20201201GRYB-VOCBetaGH501YV2B VOCDeltaG478KV1B VOCAlpha20201201GRYB VOCBetaGH501YV2B],[0 RDeltaG478KV1 RAlpha20201201GRY RBetaGH501YV2],[0 0 0 0],zeros(4,4),RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
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