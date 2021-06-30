function CountryMatrixAdherence(cFile,AL)
    load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
    TT=[[1:31]' cstatusR];
    TEX=sortrows(TT,2);

    CountryM=CountryM(TEX(:,1));
    CSR=TEX(:,2);

    NM=length(CountryM);

    MinAdherence=-1.*ones(NM);

    qR=[0:14];
    
    for ii=1:NM
        for jj=1:NM
            [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),[],[]);
            if(~isempty(prevA))
                
                vAB=(VTAB./NA);
                vBA=(VTBA./NB);
            
                [qA,~] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,1,cFile);
                
                if(~isempty(qA))                    
                    tempQ=qA;
                    count=100;
                    while(tempQ==qA)&&(count>=0)
                        tempQ=DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,count./100,cFile);
                        MinAdherence(ii,jj)=count./100;
                        count=count-1;
                    end
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
    print(gcf,['Figure_Country_NoVOC_' cFile '_Adherence=' num2str(100*AL) '.png'],'-dpng','-r600');
    print(gcf,['Figure_Country_NoVOC_' cFile '_Adherence=' num2str(100*AL) '.eps'],'-depsc','-r600');
    
    SQ=sum(min(QM,0),2);
    fnon=find(SQ>(-1.*NM+6));

    QM=QM(fnon,:);
    QM=QM(:,fnon);

    CountryM=CountryM(fnon);
    CSR=CSR(fnon);

    PlotQuarantineMatrixSummary(CountryM,QM,CSR)
    text(-2.125802579686395,24.29232995658466,0,'G','Fontsize',32,'FontWeight','bold')
    print(gcf,['Figure_SummaryCountry_NoVOC_' cFile '_Adherence=' num2str(100*AL) '.eps'],'-depsc','-r600');

    save([cFile '_Country.mat']);
end
