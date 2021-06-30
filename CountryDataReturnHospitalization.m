function [prevMA,prevMB,prevA,prevB,vacMA,vacMB,vacupA,vacupB,proHMA,proHMB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,CBstatusR,VacupALOA,VacupALOB,VOCBetaGH501YV2A,VOCBetaGH501YV2B,VOCAlpha20201201GRYA,VOCAlpha20201201GRYB,VOCDeltaG478KV1A,VOCDeltaG478KV1B,DemoA,DemoB] = CountryDataReturnHospitalization(Date,CountryA,CountryB,pA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demographics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[DemoA] = AgeDemoCounty(CountryA);
[DemoB] = AgeDemoCounty(CountryB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Recovered population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

[recA,NA] = RecoveredPopulation(CountryA,DateN,DemoA);
[recB,NB] = RecoveredPopulation(CountryB,DateN,DemoB);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Vaccination Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Get the first stage of the calcualtion for the vaccine aquaired immunity
% and hospitaliation

[vacupA,tempHA,VacupALOA,vacMA,tempHMA] = CountryVaccinationFirstStage(CountryA,DateN,NA,DemoA);
[vacupB,tempHB,VacupALOB,vacMB,tempHMB] = CountryVaccinationFirstStage(CountryB,DateN,NB,DemoB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Infected population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Epidata
[cA,prevA,CAstatusR] = CountryEpiData(CountryA,NA,DateN,DemoA,vacupA,recA,pA);
[cB,prevB,CBstatusR] = CountryEpiData(CountryB,NB,DateN,DemoB,vacupB,recB,pA);
% Prev under difference vaccine coverage
[prevMA] = CountryEpiDataVacCov(CountryA,DateN,NA,DemoA,vacMA,recA,pA);
[prevMB] = CountryEpiDataVacCov(CountryB,DateN,NB,DemoB,vacMB,recB,pA);
% Finsih calcualting vaccine immunity
[vacupA,proHA,vacMA,proHMA] = CountryVaccinationSecondStage(DemoA,vacupA,tempHA,vacMA,tempHMA,recA,prevA,prevMA);
[vacupB,proHB,vacMB,proHMB] = CountryVaccinationSecondStage(DemoB,vacupB,tempHB,vacMB,tempHMB,recB,prevB,prevMB);

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

