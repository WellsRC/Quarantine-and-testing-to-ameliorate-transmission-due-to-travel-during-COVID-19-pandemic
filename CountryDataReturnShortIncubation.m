function [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,CBstatusR,VacupALOA,VacupALOB,VOCBetaGH501YV2A,VOCBetaGH501YV2B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCDeltaG478KV1A,VOCDeltaG478KV1B,DemoA,DemoB] = CountryDataReturnShortIncubation(Date,CountryA,CountryB,pA,AL)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demographics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[DemoA] = AgeDemoCounty(CountryA);
[DemoB] = AgeDemoCounty(CountryB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Recovered population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

[recA,NA] = RecoveredPopulationSI(CountryA,DateN,DemoA,pA,AL);
[recB,NB] = RecoveredPopulationSI(CountryB,DateN,DemoB,pA,AL);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Vaccination Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Get the first stage of the calcualtion for the vaccine aquaired immunity
% and hospitaliation

[vacupA,tempHA,VacupALOA] = CountryVaccinationFirstStage(CountryA,DateN,NA,DemoA);
[vacupB,tempHB,VacupALOB] = CountryVaccinationFirstStage(CountryB,DateN,NB,DemoB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Infected population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Epidata
[cA,prevA,CAstatusR] = CountryEpiDataSI(CountryA,NA,DateN,DemoA,vacupA,recA,pA,AL);
[cB,prevB,CBstatusR] = CountryEpiDataSI(CountryB,NB,DateN,DemoB,vacupB,recB,pA,AL);
% % Prev under difference vaccine coverage
% [prevMA] = CountryEpiDataVacCov(CountryA,DateN,NA,DemoA,vacMA,recA,pA);
% [prevMB] = CountryEpiDataVacCov(CountryB,DateN,NB,DemoB,vacMB,recB,pA);
% Finsih calcualting vaccine immunity
[vacupA,proHA] = CountryVaccinationSecondStage(vacupA,tempHA,recA,prevA);
[vacupB,proHB] = CountryVaccinationSecondStage(vacupB,tempHB,recB,prevB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Travel Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Leaving country A and Entering Country B
[VTAB,avgdAB,pgeoAB]=TravelInformation(CountryA,CountryB);
%Leaving country B and Entering Country A
[VTBA,avgdBA,pgeoBA]=TravelInformation(CountryB,CountryA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOC  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[VOCBetaGH501YV2A,VOCAlpha20201201GRYA,VOCDeltaG478KV1A] = VOCDataReturn(CountryA);
[VOCBetaGH501YV2B,VOCAlpha20201201GRYB,VOCDeltaG478KV1B] = VOCDataReturn(CountryB);

end

