function CountryMatrixNoVOC(cFile,AL)
    load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
    TT=[[1:31]' cstatusR];
    TEX=sortrows(TT,2);

    CountryM=CountryM(TEX(:,1));
    CSR=TEX(:,2);

    NM=length(CountryM);

    QM=-1.*ones(NM);

    VAC=-1.*ones(NM);
    PREV=-1.*ones(NM);
    REC=-1.*ones(NM);
    CC=-1.*ones(NM);
    N=-1.*ones(NM);
    VAB=-1.*ones(NM);
    DAB=-1.*ones(NM);
    PHI=-1.*ones(NM);

    d=30;
    qR=[0:14];
    
    for ii=1:NM
        for jj=(ii+1):NM
            [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,RA,RB,~,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),[],[],AL,cFile);
            if(~isempty(prevA))
                VAC(ii,jj)=sum(nageB.*vacB)./sum(nageA.*vacA);
                PREV(ii,jj)=sum(nageB.*prevB)./sum(nageA.*prevA);
                REC(ii,jj)=sum(nageB.*recB)./sum(nageA.*recA);
                N(ii,jj)=NB./NA;
                VAB(ii,jj)=VTBA./VTAB;
                DAB(ii,jj)=dBA./dAB;
                PHI(ii,jj)=(sum(nageB.*vacB)+sum(nageB.*recB))./((sum(nageA.*vacA)+sum(nageA.*recA)));

                VAC(jj,ii)=1./VAC(ii,jj);
                PREV(jj,ii)=1./PREV(ii,jj);
                REC(jj,ii)=1./REC(ii,jj);
                CC(jj,ii)=1./CC(ii,jj);
                N(jj,ii)=1./N(ii,jj);
                VAB(jj,ii)=1./VAB(ii,jj);
                DAB(jj,ii)=1./DAB(ii,jj);
                PHI(jj,ii)=1./PHI(ii,jj);

                vAB=(VTAB./NA);
                vBA=(VTBA./NB);

                CC(ii,jj)=(vBA.*dBA)./(dAB.*vAB);
                CC(jj,ii)=1./CC(ii,jj);

                [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile);
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

    % %%% Changed Republic of Ireland to Ireland to improve the visualization of
    % %%% the figure
    t=strcmp(CountryM,'United Kingdom');
    CountryM(t)={'U.K.'};
    t=strcmp(CountryM,'Republic of Ireland');
    CountryM(t)={'Ireland'};
    t=strcmp(CountryM,'Czech Republic');
    CountryM(t)={'Czechia'};
    PlotQuarantineMatrix(CountryM,QM,CSR)
    print(gcf,['Figure_Country_NoVOC_' cFile '.png'],'-dpng','-r600');
    print(gcf,['Figure_Country_NoVOC_' cFile '.eps'],'-depsc','-r600');
    
    SQ=sum(min(QM,0),2);
    fnon=find(SQ>(-1.*NM+6));

    QM=QM(fnon,:);
    QM=QM(:,fnon);

    CountryM=CountryM(fnon);
    CSR=CSR(fnon);

    PlotQuarantineMatrixSummary(CountryM,QM,CSR)
    text(-2.125802579686395,24.29232995658466,0,'G','Fontsize',32,'FontWeight','bold')
    print(gcf,['Figure_SummaryCountry_NoVOC_' cFile '.eps'],'-depsc','-r600');

    save([cFile '_Country.mat']);
end
