function [prevA,prevB,vacupA,vacupB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,CAstatusR,CBstatusR,VacupALOA,VacupALOB,VOCOmincronA,VOCOmincronB,VOCDeltaA,VOCDeltaB,DemoA,DemoB] = CountryDataReturnIncubationAirline(Date,CountryA,CountryB,pA,AL,IncubationP)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demographics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[DemoA] = AgeDemoCounty(CountryA);
[DemoB] = AgeDemoCounty(CountryB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Recovered population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

[recA,NA] = RecoveredPopulation(CountryA,DateN,DemoA,pA,AL,IncubationP);
[recB,NB] = RecoveredPopulation(CountryB,DateN,DemoB,pA,AL,IncubationP);
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
[cA,prevA,CAstatusR] = CountryEpiData(CountryA,NA,DateN,DemoA,vacupA,recA,pA,AL,IncubationP);
[cB,prevB,CBstatusR] = CountryEpiData(CountryB,NB,DateN,DemoB,vacupB,recB,pA,AL,IncubationP);
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
[VTAB,avgdAB,pgeoAB]=AirlineTravelInformation(CountryA,CountryB);
%Leaving country B and Entering Country A
[VTBA,avgdBA,pgeoBA]=AirlineTravelInformation(CountryB,CountryA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOC  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[VOCOmincronA,VOCDeltaA] = VOCDataReturn(CountryA);
[VOCOmincronB,VOCDeltaB] = VOCDataReturn(CountryB);

end


