function [nageA,nageB,prevA,prevB,vacA,vacB,proHA,proHB,recA,recB,cA,cB,NA,NB,pgeoAB,VTAB,dAB,pgeoBA,VTBA,dBA,pA,VOCDeltaA,VOCDeltaB,VOCOmincronA,VOCOmincronB] = DataReturnSim(CountryA,CountryB,AL,DateI,IncubationP)
load(['Country_Data_' DateI{1} '_Incubation=' num2str(IncubationP) '_Adherence_Level_' num2str(AL*100) '.mat'],'prev','rec','c','N','vac','proH','pgeoABM','VTABM','CountryM','pA','avgABM','Demo','VOCOmincron','VOCDelta');
tA=strcmp(CountryA,CountryM);
tB=strcmp(CountryB,CountryM);


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
        VOCDeltaA=VOCDelta(tA);
        VOCOmincronA=VOCOmincron(tA);
        
        
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
        
        VOCDeltaB=VOCDelta(tB);
        VOCOmincronB=VOCOmincron(tB);
        
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
        VOCDeltaA=[];
        VOCOmincronA=[];


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
        VOCDeltaB=[];
        VOCOmincronB=[];
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
        VOCDeltaA=[];
        VOCOmincronA=[];
    
    
    prevB=[];
    vacB=[];
    proHB=[];
    recB=[];
    cB=[];
    NB=[];
    pgeoBA=[];
    dBA=[];
        VOCDeltaB=[];
        VOCOmincronB=[];
end

end

