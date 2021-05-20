function [rec,N] = RecoveredPopulation(Country,DateN,Demo)
T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
tA=strcmp(Country,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;
% Assumes uniform recovery among the different age classes
rec=T.seroprev_mean(tA & fDate).*ones(size(Demo));
% Population size
N=T.total_pop(tA & fDate);


end

