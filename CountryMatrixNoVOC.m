function CountryMatrixNoVOC(cFile,DateI,AL,AQ,IncubationP)

    load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
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

    qR=[0:14];
    for ii=1:NM
        for jj=(ii+1):NM
            [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
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

                [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
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
                
%                 if(isempty(T))
%                    T=table(nageA,nageB,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,qA,qB); 
%                 else
%                    Ttemp=table(nageA,nageB,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,qA,qB); 
%                    T=[T;Ttemp];
%                 end
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
    
    save(['Country_NO_VOC_Quarantine_' cFile '_AL=' num2str(AL*100) '_AQ=' num2str(100*AQ) '_' DateI{1} '.mat']);
    
    PlotQuarantineMatrix(CountryM,QM,CSR)
    print(gcf,['Figure_Country_NoVOC_' cFile '_Adherence=' num2str(100*AL) '_AQ=' num2str(100*AQ) '_' DateI{1} '.png'],'-dpng','-r600');
    
    if((AL==1)&&(AQ==1)&&(strcmp(cFile,'Shorter_Incubation_Quarantine_RTPCR_Exit')))
%         SQ=sum(min(QM,0),2);
        CountryMSummary={'Austria';'Belgium';'Bulgaria';'Cyprus';'Czechia';'Estonia';'Finland';'Germany';'Greece';'Hungary';'Italy';'Luxembourg';'Poland';'Portugal';'Romania';'Slovakia';'Slovenia';'U.K.'};
%         fnon=find(SQ>(-1.*NM+7));
        fnon=[];
        for kk=1:NM
            if(sum(strcmp(CountryM(kk),CountryMSummary))==1)
                fnon=[fnon;kk];
            end
        end
        QM=QM(fnon,:);
        QM=QM(:,fnon);

        CountryM=CountryM(fnon);
        CSR=CSR(fnon);

        PlotQuarantineMatrixSummary(CountryM,QM,CSR)
        text(-1.884495208337297,21.91316931982633,'I','Fontsize',32,'FontWeight','bold')
        print(gcf,['Figure_1G_' DateI{1} '.eps'],'-depsc','-r600');
    end
% end

%     writetable(T,['No_VOC_Hellewell_et_al_' cFile '.csv']);
end
