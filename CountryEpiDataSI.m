function [c,prev,CstatusR] = CountryEpiDataSI(Country,N,DateN,Demo,vacup,rec,pA,AL)

% Read the data
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
%Find the country name
t=strcmp(Country,T.location_name);
%Confert data to numbers
TDate=datenum(T.date);


% % If want to use the estimated cumulative infections to determine
% fractional incidence and prevelance to correct for under-reporting
% % Find the date of interest
% fDate=DateN==TDate;
% fDatePrev=(DateN-1)==(TDate);
% 
% % Fractional incidence 
% c=(T.inf_cuml_mean(t & fDate)-T.inf_cuml_mean(t & fDatePrev))./N; 

% %%% Determine the age based prevalance 
% fDateInc=(DateN-8)==TDate;
% 
% fDateInfD=(DateN-28)==TDate;
% 
% % Temporary assumption to determine prportion susceptible to infection in different age classes 
% PopIM=1-vacup.*(1-rec)-rec; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
% Symptomatic=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t & fDateInc)).*(Demo.*PopIM)./(sum(Demo.*PopIM)); %sum(T.confirmed_infections((findx-7):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
% SymptomaticNoIsolation=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDateInfD)).*(Demo.*PopIM)./(sum(Demo.*PopIM)); %sum(T.confirmed_infections((findx-27):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
% Asymptomatic=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDateInfD)).*(Demo.*PopIM)./(sum(Demo.*PopIM)); %sum(T.confirmed_infections((findx-27):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level


fDate=DateN==TDate;
findx=find(t&fDate);

c=mean(T.confirmed_infections((findx-13):findx))./N; % Daily fractional incidence
PopIM=1-vacup.*(1-rec)-rec; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.confirmed_infections((findx-5):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
SymptomaticNoIsolation=sum(T.confirmed_infections((findx-25):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-25):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
% Determine the age based prev based on asympotmtic proportion of the age
% class
prev=(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic)./(Demo.*N);

%%%
% Determines the EU colour statis of the country (i.e. total infections per
% 100000 for the last 2 weeks


X=(T.confirmed_infections((findx-13):findx));
if((sum(isnan(X))<14)&&(sum(isnan(X))>=1)) % fill any NaN with the average number of infections
    avgX=mean(X(~isnan(X)));
    X(isnan(X))=avgX;
    CstatusR=(sum(X))./N.*100000;
else    % no days missing reported infections
    CstatusR=(sum(X))./N.*100000;
end

end

