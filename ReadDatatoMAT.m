clear;
clc;
pA=[81.91 77.59 77.59 69.46 69.46 64.54 64.54 35.44]./100;



% Vaccinatino Data: Swaped name of Ireland for Republic of Ireland
cFile={'Quarantine_RTPCR_Exit_Duration'};

CountryM={'Austria';'Belgium';'Bulgaria';'Cyprus';'Czech Republic';'Denmark';'Estonia';'Finland';'France';'Germany';'Greece';'Hungary';'Republic of Ireland';'Italy';'Lithuania';'Luxembourg';'Malta';'Netherlands';'Norway';'Poland';'Portugal';'Romania';'Russia';'Serbia';'Slovakia';'Slovenia';'Spain';'Sweden';'Switzerland';'Turkey';'United Kingdom'};
NM=length(CountryM);
QM=-1.*ones(NM);

prev=-1.*ones(NM,8);
prevM=-1.*ones(NM,101,8);
rec=-1.*ones(NM,8);
c=-1.*ones(NM,1);
N=-1.*ones(NM,1);
vac=-1.*ones(NM,8);
vacM=-1.*ones(NM,101,8);
proH=-1.*ones(NM,8);
proHM=-1.*ones(NM,101,8);
cstatusR=-1.*ones(NM,1);
Vacup=-1.*ones(NM,1);
VOCBetaGH501YV2=-1.*ones(NM,1);
VOCAlpha20201201GRY=-1.*ones(NM,1);
VOCDeltaG478KV1=-1.*ones(NM,1);
Demo=-1.*ones(NM,8);

avgABM=-1.*ones(NM,NM);
pgeoABM=-1.*ones(NM,NM);
VTABM=-1.*ones(NM,NM);

for ii=1:NM-1
    for jj=(ii+1):NM
        [~,prevMA,~,prevA,prevB,vacMA,~,vacupA,vacupB,proHMA,~,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,~,~,CAstatusR,~,VacupA,~,VOCBetaGH501YV2A,~,VOCAlpha20201201GRYA,~,VOCDeltaG478KV1A,~,DemoA,DemoB] = CountryDataReturnHospitalization({'June 9, 2021'},CountryM(ii),CountryM(jj),pA,cFile);
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
        prevM(ii,:,:)=prevMA;
        Demo(ii,:)=DemoA;
        rec(ii,:)=recA;
        c(ii)=cA;
        N(ii)=NA;
        vac(ii,:)=vacupA;
        vacM(ii,:,:)=vacMA;
        proH(ii,:)=proHA;
        proHM(ii,:,:)=proHMA;
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
[~,prevMA,~,prevA,~,vacMA,~,vacupA,vacupB,proHMA,~,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,~,~,CAstatusR,~,VacupA,~,VOCBetaGH501YV2A,~,VOCAlpha20201201GRYA,~,VOCDeltaG478KV1A,~,DemoA,DemoB] = CountryDataReturnHospitalization({'April 12, 2021'},CountryM(ii),CountryM(jj),pA,cFile);
if(~isempty(prevA)&&~isempty(vacupA)&&~isempty(proHA)&&~isempty(recA)&&~isempty(cA)&&~isempty(NA))
    prev(ii,:)=prevA;
    prevM(ii,:,:)=prevMA;
    Demo(ii,:)=DemoA;
    rec(ii,:)=recA;
    c(ii)=cA;
    N(ii)=NA;
    vac(ii,:)=vacupA;
    vacM(ii,:,:)=vacMA;
    proH(ii,:)=proHA;
    proHM(ii,:,:)=proHMA;
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

save('Country_Data_June_9_2021.mat','prev','rec','c','N','vac','proH','avgABM','pgeoABM','VTABM','CountryM','pA','cstatusR','Vacup','VOCB117','VOCP1','VOC501YV2','Demo','prevM','vacM','proHM')