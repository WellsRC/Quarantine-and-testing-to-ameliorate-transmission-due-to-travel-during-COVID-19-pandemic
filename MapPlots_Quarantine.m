close all;
clear;
clc;

CountrySS={'United Kingdom','Portugal','Belgium','Italy','Cyprus','Hungary'};
for ccc=1:6
    load('Country_Data_April_12_2021.mat','CountryM','cstatusR')
    TT=[[1:31]' cstatusR];
    TEX=sortrows(TT,2);

    CountryM=CountryM(TEX(:,1));
    CSR=TEX(:,2);

    cFile={'Quarantine_RTPCR_Exit_Duration'};


    NM=length(CountryM);

    QM=-1.*ones(1,NM);

    d=30;
    qR=[0:14];
    FVOCA=1;
    FVOCB=1;
    RVOC=0;
    REPSVOC=0;
    RNIVOC=0;


    tt=strcmp(CountrySS(ccc),CountryM);
    CSR=CSR(tt);

    for jj=1:NM
        [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,RA,RB,~,~,~,~,~,~,~] = DataReturnSim(CountrySS(ccc),CountryM(jj),[],[],cFile);
        if(~isempty(prevA))
            vAB=(VTAB./NA);
            vBA=(VTBA./NB);

            [qA,~] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile);
            if(~isempty(qA))
                QM(jj)=qA;
            else
                QM(jj)=15;           
            end

        end
    end


    t=strcmp(CountryM,'Republic of Ireland');
    CountryM(t)={'Ireland'};
    t=strcmp(CountryM,'Czech Republic');
    CountryM(t)={'Czechia'};
    t=strcmp(CountryM,'Russia');
    CountryM(t)={'Russian Federation'};
    t=strcmp(CountryM,'Slovakia');
    CountryM(t)={'Slovak Republic'};
%     figure('units','normalized','outerposition',[0.0 0.025 0.9 1]);
    if(strcmp('Czech Republic',CountrySS(ccc)))
        QuarantineMap('Czechia',CountryM,QM,CSR,ccc)
    else
        QuarantineMap(CountrySS(ccc),CountryM,QM,CSR,ccc)
    end
    print(gcf,['TestMap-' num2str(ccc) '.png'],'-dpng','-r600');
end