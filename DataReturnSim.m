function [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,pgeoAB,VTAB,dAB,pgeoBA,VTBA,dBA,pA,VOCDeltaG478KV1A,VOCDeltaG478KV1B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCBetaGH501YV2A,VOCBetaGH501YV2B] = DataReturnSim(CountryA,CountryB,AL,cFile)
if(contains(cFile,'Shorter_Incubation'))
    load(['Shorter_Incubation_Country_Data_June_27_2021_Adherence_Level_' num2str(AL*100) '.mat'],'prev','rec','c','N','vac','proH','pgeoABM','VTABM','CountryM','pA','avgABM','Demo','VOCDeltaG478KV1','VOCAlpha20201201GRY','VOCBetaGH501YV2')
else
    load(['Country_Data_June_27_2021_Adherence_Level_' num2str(AL*100) '.mat'],'prev','rec','c','N','vac','proH','pgeoABM','VTABM','CountryM','pA','avgABM','Demo','VOCDeltaG478KV1','VOCAlpha20201201GRY','VOCBetaGH501YV2')
end
tA=strcmp(CountryA,CountryM);
tB=strcmp(CountryB,CountryM);


VacVec=[0:0.01:1];

if(sum(tA)+sum(tB)==2)
    if(VTABM(tA,tB)>0)
%         if(isempty(vacupA))
            prevA=prev(tA,:);
            vacA=vac(tA,:);
            proHA=proH(tA,:);
%         else
%             % for a specified vaccine coverage for the country
%             fvacA=((vacupA>=(VacVec-5.*10^(-6))) & (vacupA<=(VacVec+5.*10^(-6))));
%             prevA=squeeze(prevM(tA,fvacA,:))';
%             vacA=squeeze(vacM(tA,fvacA,:))';
%             proHA=squeeze(proHM(tA,fvacA,:))';
%         end
        recA=rec(tA,:);
        cA=c(tA);
        NA=N(tA);
        pgeoAB=pgeoABM(tA,tB);
        VTAB=VTABM(tA,tB);
        dAB=avgABM(tA,tB);
        nageA=Demo(tA,:);
        VOCDeltaG478KV1A=VOCDeltaG478KV1(tA);
        VOCAlpha20201201GRYA=VOCAlpha20201201GRY(tA);
        VOCBetaGH501YV2A=VOCBetaGH501YV2(tA);
        
        
%         if(isempty(vacupB))
            prevB=prev(tB,:);
            vacB=vac(tB,:);
            proHB=proH(tB,:);
%         else
%             
%             fvacB=((vacupB>=(VacVec-5.*10^(-6))) & (vacupB<=(VacVec+5.*10^(-6))));
%             prevB=squeeze(prevM(tB,fvacB,:))';
%             vacB=squeeze(vacM(tB,fvacB,:))';
%             proHB=squeeze(proHM(tB,fvacB,:))';
%         end
        recB=rec(tB,:);
        cB=c(tB);
        NB=N(tB);
        pgeoBA=pgeoABM(tB,tA);
        VTBA=VTABM(tB,tA);
        dBA=avgABM(tB,tA);
        nageB=Demo(tB,:);
        
        VOCDeltaG478KV1B=VOCDeltaG478KV1(tB);
        VOCAlpha20201201GRYB=VOCAlpha20201201GRY(tB);
        VOCBetaGH501YV2B=VOCBetaGH501YV2(tB);
        
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
        VOCDeltaG478KV1A=[];
        VOCAlpha20201201GRYA=[];
        VOCBetaGH501YV2A=[];


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
        VOCDeltaG478KV1B=[];
        VOCAlpha20201201GRYB=[];
        VOCBetaGH501YV2B=[];
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
        VOCDeltaG478KV1A=[];
        VOCAlpha20201201GRYA=[];
        VOCBetaGH501YV2A=[];
    
    
    prevB=[];
    vacB=[];
    proHB=[];
    recB=[];
    cB=[];
    NB=[];
    pgeoBA=[];
    dBA=[];
        VOCDeltaG478KV1B=[];
        VOCAlpha20201201GRYB=[];
        VOCBetaGH501YV2B=[];
end

end

