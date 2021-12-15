function CountryMatrixNoVOCTimeVary(cFile,DateIv,AL,AQ,IncubationP)

    load(['Country_Data_' DateIv{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
    TEX=sortrows(TT,2);

    CountryM=CountryM(TEX(:,1));

    NM=length(CountryM);

    QM=-1.*ones(NM,NM,length(DateIv));
    
    for dd=1:length(DateIv)
        DateI={DateIv{dd}};
        qR=[0:14];
        for ii=1:NM
            for jj=(ii+1):NM
                [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
                if(~isempty(prevA))

                    vAB=(VTAB./NA);
                    vBA=(VTBA./NB);

                    [qA,qB] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                    if(~isempty(qA))
                        QM(ii,jj,dd)=qA;
                    else
                        QM(ii,jj,dd)=15;  
                    end

                    if(~isempty(qB))
                        QM(jj,ii,dd)=qB;
                    else
                        QM(jj,ii,dd)=15; 
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
    end
    Qtemp=ones(NM*NM,length(DateIv));
    deltaQ=ones(NM*NM,length(DateIv));
    for dd=1:length(DateIv)
        for ii=1:NM
           for jj=1:NM
               deltaQ(jj+NM.*(ii-1),dd)=QM(jj,ii,dd)-QM(jj,ii,1);
               if(QM(jj,ii,dd)>QM(jj,ii,1))
                   Qtemp(jj+NM.*(ii-1),dd)=0;
               end
           end
        end
        if(dd>1)
            Qtemp(:,dd)=prod(Qtemp(:,1:dd),2);
        end
    end
    
    save('Compare_Time_Quarantine.mat');
end
