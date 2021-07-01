function [rec,N] = RecoveredPopulation(Country,DateN,Demo,pA,AL)
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
tA=strcmp(Country,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;

% Population size
N=T.total_pop(tA & fDate);
% Assumes uniform recovery among the different age classes
rec=T.inf_cuml_mean(tA & fDate).*ones(size(Demo));

%%% Determine active infections to discount from those that are recovered
findx=find(tA&fDate);
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))); % Distribute the number of infections over this past time based on immunity level
SymptomaticNoIsolation=sum(T.confirmed_infections((findx-27):(findx))); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))); % Distribute the number of infections over this past time based on immunity level

ActiveI=(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic);

% Compute proportion of population that is recovered
rec=(rec-ActiveI)./N;


end

