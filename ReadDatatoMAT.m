clear;
clc;
T=readtable([pwd '\Country_Data\Age_Population.csv']);
save('Country_Age_Population.mat');
clear;
clc;
T=readtable([pwd '\Country_Data\VaccineDoses_Age_Country_Adjusted.csv']);
save('Vaccination_Data.mat');
clear;
clc;
T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
save('IHME_Data.mat');
clear;
clc;

IncubationP=5.723;
DateInter={'August 8, 2021'};
pA=[81.91 77.59 77.59 69.46 69.46 64.54 64.54 35.44]./100;
for nn=4:-1:0
    AL=nn./4;


    CountryM={'Austria';'Belgium';'Bulgaria';'Cyprus';'Czech Republic';'Denmark';'Estonia';'Finland';'France';'Germany';'Greece';'Hungary';'Republic of Ireland';'Italy';'Lithuania';'Luxembourg';'Malta';'Netherlands';'Norway';'Poland';'Portugal';'Romania';'Slovakia';'Slovenia';'Spain';'United Kingdom'};
    NM=length(CountryM);


    prev=-1.*ones(NM,length(pA));
    prevM=-1.*ones(NM,101,length(pA));
    rec=-1.*ones(NM,length(pA));
    c=-1.*ones(NM,1);
    N=-1.*ones(NM,1);
    vac=-1.*ones(NM,length(pA));
    vacM=-1.*ones(NM,101,length(pA));
    proH=-1.*ones(NM,length(pA));
    proHM=-1.*ones(NM,101,length(pA));
    cstatusR=-1.*ones(NM,1);
    Vacup=-1.*ones(NM,1);
    VOCBetaGH501YV2=-1.*ones(NM,1);
    VOCAlpha20201201GRY=-1.*ones(NM,1);
    VOCDeltaG478KV1=-1.*ones(NM,1);
    Demo=-1.*ones(NM,length(pA));

    avgABM=-1.*ones(NM,NM);
    pgeoABM=-1.*ones(NM,NM);
    VTABM=-1.*ones(NM,NM);

    for ii=1:NM-1
        for jj=(ii+1):NM        
            [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,~,VacupA,~,VOCBetaGH501YV2A,~,VOCAlpha20201201GRYA,~,VOCDeltaG478KV1A,~,DemoA,DemoB] = CountryDataReturnIncubation(DateInter,CountryM(ii),CountryM(jj),pA,AL,IncubationP);
            if(~isempty(prevA)&&~isempty(vacupA)&&~isempty(proHA)&&~isempty(recA)&&~isempty(cA)&&~isempty(NA))
                if(~isempty(prevA)&&~isempty(vacupA)&&~isempty(proHA)&&~isempty(recA)&&~isempty(cA)&&~isempty(NA)&&~isempty(pgeoAB)&&~isempty(VTAB)&&~isempty(DemoA)&&~isempty(DemoB)&&~isempty(prevB)&&~isempty(vacupB)&&~isempty(proHB)&&~isempty(recB)&&~isempty(cB)&&~isempty(NB)&&~isempty(pgeoBA)&&~isempty(VTBA))
                    avgABM(ii,jj)=avgdAB;
                    avgABM(jj,ii)=avgdBA;
                    pgeoABM(ii,jj)=pgeoAB;
                    pgeoABM(jj,ii)=pgeoBA;
                    VTABM(ii,jj)=VTAB;
                    VTABM(jj,ii)=VTBA;
                end
            else
                break;
            end
        end
        if(~isempty(prevA)&&~isempty(vacupA)&&~isempty(proHA)&&~isempty(recA)&&~isempty(cA)&&~isempty(NA)&&~isempty(DemoA))
            prev(ii,:)=prevA;
            Demo(ii,:)=DemoA;
            rec(ii,:)=recA;
            c(ii)=cA;
            N(ii)=NA;
            vac(ii,:)=vacupA;
            proH(ii,:)=proHA;
            cstatusR(ii)=CAstatusR;
            Vacup(ii)=VacupA;
            if(~isempty(VOCBetaGH501YV2A))
                VOCBetaGH501YV2(ii)=VOCBetaGH501YV2A;
            end
            if(~isempty(VOCAlpha20201201GRYA))
                VOCAlpha20201201GRY(ii)=VOCAlpha20201201GRYA;
            end
            if(~isempty(VOCDeltaG478KV1A))
                VOCDeltaG478KV1(ii)=VOCDeltaG478KV1A;
            end
        end
    end
    % Need to record the last country's epiddemic profile
    ii=NM;
    jj=NM-1;
    [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,~,VacupA,~,VOCBetaGH501YV2A,~,VOCAlpha20201201GRYA,~,VOCDeltaG478KV1A,~,DemoA,DemoB] = CountryDataReturnIncubation(DateInter,CountryM(ii),CountryM(jj),pA,AL,IncubationP);
    if(~isempty(prevA)&&~isempty(vacupA)&&~isempty(proHA)&&~isempty(recA)&&~isempty(cA)&&~isempty(NA))
        prev(ii,:)=prevA;
        Demo(ii,:)=DemoA;
        rec(ii,:)=recA;
        c(ii)=cA;
        N(ii)=NA;
        vac(ii,:)=vacupA;
        proH(ii,:)=proHA;
        cstatusR(ii)=CAstatusR;
        Vacup(ii)=VacupA;
        if(~isempty(VOCBetaGH501YV2A))
            VOCBetaGH501YV2(ii)=VOCBetaGH501YV2A;
        end
        if(~isempty(VOCAlpha20201201GRYA))
            VOCAlpha20201201GRY(ii)=VOCAlpha20201201GRYA;
        end
        if(~isempty(VOCDeltaG478KV1A))
            VOCDeltaG478KV1(ii)=VOCDeltaG478KV1A;
        end
    end

    save(['Country_Data_' DateInter{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(nn*25) '.mat'],'prev','rec','c','N','vac','proH','avgABM','pgeoABM','VTABM','CountryM','pA','cstatusR','Vacup','VOCBetaGH501YV2','VOCAlpha20201201GRY','VOCDeltaG478KV1','Demo')
end