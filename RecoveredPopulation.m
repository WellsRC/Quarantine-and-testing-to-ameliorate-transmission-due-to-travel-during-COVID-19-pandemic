function [rec,N] = RecoveredPopulation(Country,DateN,Demo,pA,AL,IncubationP)
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
t=strcmp(Country,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;

% Population size
N=T.population(t & fDate);
% Assumes uniform recovery among the different age classes
rec=T.inf_cuml_mean(t & fDate).*ones(size(Demo));

% %%% Determine active infections to discount from those that are recovered
findx=find(t&fDate);

tindix=round(IncubationP);

Symptomatic=sum(T.inf_mean((findx-(tindix-1)):(findx))); % Distribute the number of infections over this past time based on immunity level
SymptomaticNoIsolation=sum(T.inf_mean((findx-(20+tindix-1)):(findx))); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.inf_mean((findx-(20+tindix-1)):(findx))); % Distribute the number of infections over this past time based on immunity level

ActiveI=sum(Demo.*(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic));

% Compute proportion of population that is recovered
rec=(rec-ActiveI)./N;


end

