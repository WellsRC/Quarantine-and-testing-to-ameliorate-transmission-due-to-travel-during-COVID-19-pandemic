function [rec,N] = RecoveredPopulationSI(Country,DateN,Demo,pA,AL)
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
t=strcmp(Country,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;

% Population size
N=T.total_pop(t & fDate);
% Assumes uniform recovery among the different age classes
rec=T.inf_cuml_mean(t & fDate).*ones(size(Demo));


% If using the cumualtive infections to estimate prev
% %%% Determine the age based prevalance 
% 
% fDateInc=(DateN-8)==(TDate);
% 
% fDateInfD=(DateN-28)==(TDate);
% 
% Symptomatic=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDateInc));%
% SymptomaticNoIsolation=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDateInfD));
% Asymptomatic=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDateInfD));

% %%% Determine active infections to discount from those that are recovered
findx=find(t&fDate);
Symptomatic=sum(T.confirmed_infections((findx-5):(findx))); % Distribute the number of infections over this past time based on immunity level
SymptomaticNoIsolation=sum(T.confirmed_infections((findx-25):(findx))); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-25):(findx))); % Distribute the number of infections over this past time based on immunity level

ActiveI=sum(Demo.*(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic));

% Compute proportion of population that is recovered
rec=(rec-ActiveI)./N;


end

