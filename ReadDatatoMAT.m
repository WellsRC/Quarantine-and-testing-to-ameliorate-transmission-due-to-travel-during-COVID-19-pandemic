clear;
clc;
T=readtable([pwd '\Country_Data\Age_Population.csv']);
save('Country_Age_Population.mat');
clear;
clc;
T=readtable([pwd '\Country_Data\VaccineDoses_Age_Country.csv']);
save('Vaccination_Data.mat');
clear;
clc;
T=readtable([pwd '\Country_Data\data_download_file_reference_2021.csv']);
save('IHME_Data.mat');
clear;
clc;

IncubationP=5.723;
DateInter={'November 21, 2021'};

% Use european average for 60+ pA
w60to79=0.200053552;
w80p=0.052621047;
wT=w60to79+w80p;
w60to79=w60to79./wT;
w80p=w80p./wT;

pA=[81.91 77.59 77.59 69.46 69.46 (64.54.*w60to79+35.44.*w80p)]./100;
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
    VOCOmincron=-1.*ones(NM,1);
    VOCDeltaG478KV1=-1.*ones(NM,1);
    Demo=-1.*ones(NM,length(pA));

    avgABM=-1.*ones(NM,NM);
    pgeoABM=-1.*ones(NM,NM);
    VTABM=-1.*ones(NM,NM);

    for ii=1:NM-1
        for jj=(ii+1):NM        
            [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,~,VacupA,~,VOCOmincronA,~,VOCDeltaA,~,DemoA,DemoB] = CountryDataReturnIncubation(DateInter,CountryM(ii),CountryM(jj),pA,AL,IncubationP);
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
            if(~isempty(VOCOmincronA))
                VOCOmincron(ii)=VOCOmincronA;
            end
            if(~isempty(VOCDeltaA))
                VOCDelta(ii)=VOCDeltaA;
            end
        end
    end
    % Need to record the last country's epiddemic profile
    ii=NM;
    jj=NM-1;
    [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,~,VacupA,~,VOCOmincronA,~,VOCDeltaA,~,DemoA,DemoB] = CountryDataReturnIncubation(DateInter,CountryM(ii),CountryM(jj),pA,AL,IncubationP);
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
            if(~isempty(VOCOmincronA))
                VOCOmincron(ii)=VOCOmincronA;
            end
            if(~isempty(VOCDeltaA))
                VOCDelta(ii)=VOCDeltaA;
            end
    end

    save(['Country_Data_' DateInter{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(nn*25) '.mat'],'prev','rec','c','N','vac','proH','avgABM','pgeoABM','VTABM','CountryM','pA','cstatusR','Vacup','VOCOmincron','VOCDelta','Demo')
end