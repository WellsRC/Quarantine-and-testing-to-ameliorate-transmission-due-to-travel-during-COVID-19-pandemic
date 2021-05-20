function [qt,prevMA,prevMB,prevA,prevB,vacMA,vacMB,vacupA,vacupB,proHMA,proHMB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,RA,RB,CAstatusR,CBstatusR,VacupALOA,VacupALOB,VOCB117A,VOCB117B,VOCP1A,VOCP1B,VOC501YV2A,VOC501YV2B,DemoA,DemoB] = CountryDataReturnHospitalization(Date,CountryA,CountryB,pA,cFile)

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
[VOCB117A,VOCP1A,VOC501YV2A] = VOCDataReturn(CountryA);
[VOCB117B,VOCP1B,VOC501YV2B] = VOCDataReturn(CountryB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Effective Reproductive number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

