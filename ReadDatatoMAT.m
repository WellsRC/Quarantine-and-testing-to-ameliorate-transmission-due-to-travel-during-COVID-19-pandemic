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
VOCB117=-1.*ones(NM,1);
VOCP1=-1.*ones(NM,1);
VOC501YV2=-1.*ones(NM,1);
Demo=-1.*ones(NM,8);

avgABM=-1.*ones(NM,NM);
pgeoABM=-1.*ones(NM,NM);
VTABM=-1.*ones(NM,NM);

for ii=1:NM-1
    for jj=(ii+1):NM
        [~,prevMA,~,prevA,prevB,vacMA,~,vacupA,vacupB,proHMA,~,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,~,~,CAstatusR,~,VacupA,~,VOCB117A,~,VOCP1A,~,VOC501YV2A,~,DemoA,DemoB] = CountryDataReturnHospitalization({'April 12, 2021'},CountryM(ii),CountryM(jj),pA,cFile);
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
        if(~isempty(VOCB117A))
            VOCB117(ii)=VOCB117A;
        end
        if(~isempty(VOCP1A))
            VOCP1(ii)=VOCP1A;
        end
        if(~isempty(VOC501YV2A))
            VOC501YV2(ii)=VOC501YV2A;
        end
    end
end
% Need to record the last country's epiddemic profile
ii=NM;
jj=NM-1;
[~,prevMA,~,prevA,~,vacMA,~,vacupA,vacupB,proHMA,~,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,~,~,CAstatusR,~,VacupA,~,VOCB117A,~,VOCP1A,~,VOC501YV2A,~,DemoA,DemoB] = CountryDataReturnHospitalization({'April 12, 2021'},CountryM(ii),CountryM(jj),pA,cFile);
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
    if(~isempty(VOCB117A))
        VOCB117(ii)=VOCB117A;
    end
    if(~isempty(VOCP1A))
        VOCP1(ii)=VOCP1A;
    end
    if(~isempty(VOC501YV2A))
        VOC501YV2(ii)=VOC501YV2A;
    end
    if(~isempty(VOCB117A))
        VOCB117(ii)=VOCB117A;
    end
    if(~isempty(VOCP1A))
        VOCP1(ii)=VOCP1A;
    end
    if(~isempty(VOC501YV2A))
        VOC501YV2(ii)=VOC501YV2A;
    end
end

save('Country_Data_April_12_2021(TEST).mat','prev','rec','c','N','vac','proH','avgABM','pgeoABM','VTABM','CountryM','pA','cstatusR','Vacup','VOCB117','VOCP1','VOC501YV2','Demo','prevM','vacM','proHM')