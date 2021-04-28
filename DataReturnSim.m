function [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,pgeoAB,VTAB,dAB,pgeoBA,VTBA,dBA,pA,RA,RB,qt,VOCB117A,VOCB117B,VOCP1A,VOCP1B,VOC501YV2A,VOC501YV2B] = DataReturnSim(CountryA,CountryB,vacupA,vacupB,cFile)
load('Country_Data_April_12_2021.mat','prev','rec','c','N','vac','proH','pgeoABM','VTABM','CountryM','pA','avgABM','Demo','VOCB117','VOCP1','VOC501YV2','vacM','prevM','proHM')
tA=strcmp(CountryA,CountryM);
tB=strcmp(CountryB,CountryM);


VacVec=[0:0.01:1];

if(sum(tA)+sum(tB)==2)
    if(VTABM(tA,tB)>0)
        if(isempty(vacupA))
            prevA=prev(tA,:);
            vacA=vac(tA,:);
            proHA=proH(tA,:);
        else
            
            fvacA=((vacupA>=(VacVec-5.*10^(-6))) & (vacupA<=(VacVec+5.*10^(-6))));
            prevA=squeeze(prevM(tA,fvacA,:))';
            vacA=squeeze(vacM(tA,fvacA,:))';
            proHA=squeeze(proHM(tA,fvacA,:))';
        end
        recA=rec(tA,:);
        cA=c(tA);
        NA=N(tA);
        pgeoAB=pgeoABM(tA,tB);
        VTAB=VTABM(tA,tB);
        dAB=avgABM(tA,tB);
        nageA=Demo(tA,:);
        VOCB117A=VOCB117(tA);
        VOCP1A=VOCP1(tA);
        VOC501YV2A=VOC501YV2(tA);
        
        
        if(isempty(vacupB))
            prevB=prev(tB,:);
            vacB=vac(tB,:);
            proHB=proH(tB,:);
        else
            
            fvacB=((vacupB>=(VacVec-5.*10^(-6))) & (vacupB<=(VacVec+5.*10^(-6))));
            prevB=squeeze(prevM(tB,fvacB,:))';
            vacB=squeeze(vacM(tB,fvacB,:))';
            proHB=squeeze(proHM(tB,fvacB,:))';
        end
        recB=rec(tB,:);
        cB=c(tB);
        NB=N(tB);
        pgeoBA=pgeoABM(tB,tA);
        VTBA=VTABM(tB,tA);
        dBA=avgABM(tB,tA);
        nageB=Demo(tB,:);
        
        VOCB117B=VOCB117(tB);
        VOCP1B=VOCP1(tB);
        VOC501YV2B=VOC501YV2(tB);
        
    else        
        prevA=[];
        vacA=[];
        proHA=[];
        recA=[];
        cA=[];
        NA=[];
        pgeoAB=[];
        VTAB=[];
        dAB=[];
        nageA=[];
        VOCB117A=[];
        VOCP1A=[];
        VOC501YV2A=[];


        prevB=[];
        vacB=[];
        proHB=[];
        recB=[];
        cB=[];
        NB=[];
        pgeoBA=[];
        VTBA=[];
        dBA=[];
        nageB=[];
        VOCB117B=[];
        VOCP1B=[];
        VOC501YV2B=[];
    end
else
    prevA=[];
    vacA=[];
    proHA=[];
    recA=[];
    cA=[];
    NA=[];
    pgeoAB=[];
    VTAB=[];
    dAB=[];
        VOCB117A=[];
        VOCP1A=[];
        VOC501YV2A=[];
    
    
    prevB=[];
    vacB=[];
    proHB=[];
    recB=[];
    cB=[];
    NB=[];
    pgeoBA=[];
    dBA=[];
        VOCB117B=[];
        VOCP1B=[];
        VOC501YV2B=[];
end


load([cFile{1} '=30.mat'],'R0','qt');
R0cA=R0;
R0cB=R0;

ts=8.29;
tL=2.9;
td=ts+20;
SelfIsolate=1;
RA=zeros(size(pA));
RB=zeros(size(pA));
for aa=1:length(pA)
    RA(aa)=integral(@(t)InfectiousnessfromInfection(t,R0cA,R0cA,pA(aa),ts,tL,td,SelfIsolate),0,td);
    RB(aa)=integral(@(t)InfectiousnessfromInfection(t,R0cB,R0cB,pA(aa),ts,tL,td,SelfIsolate),0,td);
end
end

