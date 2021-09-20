%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Produces the maps for selected countries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
close all;
clear;
clc;
AL=1;
AQ=1;
CountrySS={'Poland','Czech Republic','Germany','Bulgaria','Italy','Finland','Greece','United Kingdom'};

IncubationP=5.723;
DateI={'August 8, 2021'};

for ccc=1:8
    load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'CountryM','cstatusR')
    TT=[[1:length(CountryM)]' cstatusR];
    TEX=sortrows(TT,2);

    CountryM=CountryM(TEX(:,1));
    CSR=TEX(:,2);

    cFile='Shorter_Incubation_Quarantine_RTPCR_Exit';


    NM=length(CountryM);

    QM=-1.*ones(1,NM);

    qR=[0:14];
    FVOCA=1;
    FVOCB=1;
    RVOC=0;
    REPSVOC=0;
    RNIVOC=0;


    tt=strcmp(CountrySS(ccc),CountryM);
    CSR=CSR(tt);

    for ii=1:NM
        [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,~,~] = DataReturnSim(CountrySS(ccc),CountryM(ii),AL,DateI,IncubationP);
        if(~isempty(prevA))
            vAB=(VTAB./NA);
            vBA=(VTBA./NB);

            [qA,qB] = DetermineQuarantine(qR,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
            if(~isempty(qA))
                QM(ii)=qA;
            else
                QM(ii)=15;           
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
    elseif(strcmp('Czech Republic',CountrySS(ccc)))
        QuarantineMap('Russian Federation',CountryM,QM,CSR,ccc)
    else
        QuarantineMap(CountrySS(ccc),CountryM,QM,CSR,ccc)
    end
    grid on
    grid off
    print(gcf,['TestMap-' num2str(ccc) '.eps'],'-depsc','-r600');
end