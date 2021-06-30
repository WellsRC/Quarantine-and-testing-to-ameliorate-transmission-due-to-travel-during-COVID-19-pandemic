function [q1,q2] = DetermineQuarantine(qr,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,cFile)
% Returns the quarantine for country A and country B

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
%AL - level of adherence to self-isolation after symptom oset
%cFile - file name to be called for testing scenario

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%q1 - quanantine for country A
%q2 - quanantine for country B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Allocate memory for the calculation of the different inequalities for the
% VOC
     RIEQA=zeros(length(FVOCA),length(qr)); % Country A
     RIEQB=zeros(length(FVOCA),length(qr)); % Country B
     
     % Cycle through all the quarantines to compute the inequality
    for ii=1:length(qr)
        % Compute the inequality for country A
        [RIEQA(:,ii)]=CalculateInequalityVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,pA,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,qr(ii),AL,cFile);
        % Compute the inequality for country B
        [RIEQB(:,ii)]=CalculateInequalityVOCAll(nageB,nageA,FVOCB,FVOCA,RVOC,REPSVOC,RNIVOC,pA,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,qr(ii),AL,cFile);
    end
    
    % We ran into issues of floating point percision error. This value was
    % claibrated such that generalized results made the most sense
    EPSQT=5.*10^(-19); % Sepcified by the error in the Dark Red and Dark Red case
    % Compute the minimum duration of the travel quarantine such that the
    % inequality is satisfied.
    for ii=1:length(FVOCA)
        q1=max([min(qr(RIEQA(ii,:)<=EPSQT))],-1); % Find the minimum quarnantine that satisfies the inequality
        q2=max([min(qr(RIEQB(ii,:)<=EPSQT))],-1); % Find the minimum quarnantine that satisfies the inequality
    end    
end
