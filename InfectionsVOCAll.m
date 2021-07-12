function [InfectionsA]=InfectionsVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevAw,prevBw,vacAw,vacBw,recAw,recBw,cAw,vAB,vBA,dAB,dBA,NA,NB,qAI,AL,AQ,cFile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%qr - quarnatine durations (range for 0-14 days)
%nageA - age demographics of country A
%nageB - age demographics of country B
%FVOCA - frequency of VOC in country A
%FVOCB  - frequency of VOC in country B
%RVOC - Relative increase in transmission for different variants
%REPSVOC - Relative decrease in vaccine immunity for different variants
%RNIVOC - Relative decrease in natural immunity for different variants
%pA - age specified proportion of asymptomatic infection
%prevA - age-dependent prevalence for country A
%prevB - age-dependent prevalence for country B
%vacA - age dependent vaccine immunity for country A
%vacB - age dependent vaccine immunity for country B
%recA - age dependent natural immunity for country A
%recB - age dependent natural immunity for country B
%cA - fractional incidence for countyr A
%cB - fractional incidence for countyr B
%vAB - proportion of the population of A that travels daily
%vBA - proportion of the population of B that travels daily
%dAB - duration of stay in B for those from A going to B
%dBA - duration of stay in A for those from B going to A
%NA - population size of country A
%NB - population size of country B
%qAI - the sepcified quarantine we are interested in
%AL - level of adherence to self-isolation after symptom oset
%cFile - file name to be called for testing scenario

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RIEQA - values of the inequality

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(qAI>=0)
    if(contains(cFile,'Shorter_Incubation'))    
        % Testing and quanraitne: Post-quarantine transmission
        load([cFile '.mat'],'qA','RQA','RQS','RQSN');
        RQwtemp=(1-pA).*((1-AL).*RQSN(qA==qAI)+AL.*RQS(qA==qAI))+pA.*RQA(qA==qAI);

        % No test: Post-quarantine transmission
        load(['Shorter_Incubation_NoTest.mat'],'qA','RQA','RQS','RQSN');
        RVw=(1-pA).*((1-AL).*RQSN(qA==0)+AL.*RQS(qA==0))+pA.*RQA(qA==0);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Account for the lack of adehrence to quarantine measure 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        RQw=AQ.*RQwtemp+(1-AQ).*RVw;

        % Effective reproductive number
        load(['Shorter_Incubation_Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');
        RAw=(1-pA).*((1-AL).*RQSN+AL.*RQS)+pA.*RQA;
    elseif(contains(cFile,'Longer_Incubation'))    
        % Testing and quanraitne: Post-quarantine transmission
        load([cFile '.mat'],'qA','RQA','RQS','RQSN');
        RQwtemp=(1-pA).*((1-AL).*RQSN(qA==qAI)+AL.*RQS(qA==qAI))+pA.*RQA(qA==qAI);

        % No test: Post-quarantine transmission
        load(['Longer_Incubation_NoTest.mat'],'qA','RQA','RQS','RQSN');
        RVw=(1-pA).*((1-AL).*RQSN(qA==0)+AL.*RQS(qA==0))+pA.*RQA(qA==0);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Account for the lack of adehrence to quarantine measure 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        RQw=AQ.*RQwtemp+(1-AQ).*RVw;

        % Effective reproductive number
        load(['Longer_Incubation_Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');
        RAw=(1-pA).*((1-AL).*RQSN+AL.*RQS)+pA.*RQA;
    else     
        % Testing and quanraitne: Post-quarantine transmission
        load([cFile '.mat'],'qA','RQA','RQS','RQSN');
        RQwtemp=(1-pA).*((1-AL).*RQSN(qA==qAI)+AL.*RQS(qA==qAI))+pA.*RQA(qA==qAI);

        % No test: Post-quarantine transmission
        load(['NoTest.mat'],'qA','RQA','RQS','RQSN');
        RVw=(1-pA).*((1-AL).*RQSN(qA==0)+AL.*RQS(qA==0))+pA.*RQA(qA==0);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Account for the lack of adehrence to quarantine measure 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        RQw=AQ.*RQwtemp+(1-AQ).*RVw;

        % Effective reproductive number
        load(['Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');
        RAw=(1-pA).*((1-AL).*RQSN+AL.*RQS)+pA.*RQA;
    end


    InfectionsA=zeros(size(nageA));
    for jj=1:length(FVOCA)
        
        
        RA=RAw.*(1+RVOC(jj)); % Effective reproductive number with the increased transmission
        RQ=RQw.*(1+RVOC(jj)); % Post-quarantine transmission for the testing with the increased transmission
        RV=RVw.*(1+RVOC(jj)); % The infections to be discounted due to travel

        cA=cAw.*FVOCA(jj); % Fractional incidence for the variant of concern
        prevA=prevAw.*FVOCA(jj); % Prevlaence for the variant of concern in coutnry A
        prevB=prevBw.*FVOCB(jj); % Prevlaence for the variant of concern in coutnry B

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % THE CODE HAS NOT BEEN SET UP PROPERLY TO ACCOUNT FOR THIS YET; AS WE
        % ASSUMED THE VOC HAD NO IMPACT ON IMMUNITY
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        vacA=vacAw.*(1-REPSVOC(jj)); % Vaccine immunity in country A for VOC
        vacB=vacBw.*(1-REPSVOC(jj)); % Vaccine immunity in country B for VOC
        recA=recAw.*(1-RNIVOC(jj,1)); % Natural immunity in country A for VOC
        recB=recBw.*(1-RNIVOC(jj,1)); % Natural immunity in country B for VOC



        phiA =sum(nageA.*(prevAw+vacA+recA)); % The population level immunity in country A
        phiAw=prevAw+vacA+recA; % age specified immunity in A
        phiBw=prevBw+vacB+recB; % age specified immunity in B
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate the inequality
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        T2A=sum(NA.*(1-(qAI.*AQ+dAB).*vAB).*(cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(nageA.*(1-phiAw));

        T3A=sum(NB.*dBA.*vBA.*(cA.*(nageB.*(1-phiBw)./(1-phiA))).*RA).*(nageA.*(1-phiAw));

        T4A=sum(NA.*vAB.*nageA.*prevA.*RV).*(nageA.*(1-phiAw));

        T5A=sum(NA.*vAB.*nageA.*prevB.*((1-phiAw)./(1-phiBw)).*RQ).*(nageA.*(1-phiAw));

        T6A=sum(NB.*vBA.*nageB.*prevB.*RQ).*(nageA.*(1-phiAw));

        T7A=sum(NB.*vBA.*nageB.*prevA.*((1-phiBw)./(1-phiAw)).*RV).*(nageA.*(1-phiAw));

        InfectionsA=InfectionsA+((T2A+T3A+T5A+T6A)-(T4A+T7A)); % The minus is suppose to be there!

    end
else
    
    InfectionsA=zeros(size(nageA));
    
    % Effective reproductive number
    
    if(contains(cFile,'Shorter_Incubation'))  
        load(['Shorter_Incubation_Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');        
    elseif(contains(cFile,'Longer_Incubation'))  
        load(['Longer_Incubation_Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');        
    else
        load(['Effective_Reproductive_Number.mat'],'RQA','RQS','RQSN');
    end
    RAw=(1-pA).*((1-AL).*RQSN+AL.*RQS)+pA.*RQA;
    for jj=1:length(FVOCA)

        RA=RAw.*(1+RVOC(jj));

        cA=cAw.*FVOCA(jj);
        vacA=vacAw.*(1-REPSVOC(jj));
        recA=recAw.*(1-RNIVOC(jj,1));



        phiA =sum(nageA.*(prevAw+vacA+recA));
        
        phiAw=prevAw+vacA+recA;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate the inequality
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        T1A=sum(NA.*(cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(nageA.*(1-phiAw));
        InfectionsA=InfectionsA+T1A; 

    end
end

end

