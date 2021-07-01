function [rec,N] = RecoveredPopulation(Country,DateN,Demo)
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
tA=strcmp(Country,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;

% Population size
N=T.total_pop(tA & fDate);
% Assumes uniform recovery among the different age classes
rec=T.inf_cuml_mean(tA & fDate).*ones(size(Demo));

rec=rec./N;


end

