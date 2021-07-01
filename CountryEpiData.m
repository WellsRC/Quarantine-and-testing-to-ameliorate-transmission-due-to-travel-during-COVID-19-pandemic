function [c,prev,CstatusR] = CountryEpiData(Country,N,DateN,Demo,vacup,rec,pA)

% Read the data
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
%Find the country name
t=strcmp(Country,T.location_name);
%Confert data to numbers
TDate=datenum(T.date);
% Find the date of interest
fDate=DateN==TDate;
% Fractional incidence 
c=T.confirmed_infections(t & fDate)./N; 

%%% Determine the age based prevalance 
findx=find(t&fDate);
% Temporary assumption to determine prportion susceptible to infection in different age classes 
PopIM=1-vacup.*(1-rec)-rec; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level

% Determine the age based prev based on asympotmtic proportion of the age
% class
prev=((1-pA).*Symptomatic+pA.*Asymptomatic)./(Demo.*N);


%%%
% Determines the EU colour statis of the country (i.e. total infections per
% 100000 for the last 2 weeks
CstatusR=sum(T.confirmed_infections((findx-13):(findx)))./N.*100000;


end

