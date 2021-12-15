function [c,prev,CstatusR] = CountryEpiData(Country,N,DateN,Demo,vacup,rec,pA,AL,IncubationP)

% Read the data
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
%Find the country name
t=strcmp(Country,T.location_name);
%Confert data to numbers
TDate=datenum(T.date);

fDate=DateN==TDate;
findx=find(t&fDate);


tindix=round(IncubationP);


c=mean(T.inf_mean((findx-13):findx))./N; % Daily fractional incidence
PopIM=1-vacup.*(1-rec)-rec; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.inf_mean((findx-(tindix-1)):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
SymptomaticNoIsolation=sum(T.inf_mean((findx-(20+tindix-1)):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.inf_mean((findx-(20+tindix-1)):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
% Determine the age based prev based on asympotmtic proportion of the age
% class
prev=(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic)./(Demo.*N);

%%%
% Determines the EU colour statis of the country (i.e. total infections per
% 100000 for the last 2 weeks


X=(T.inf_mean((findx-13):findx));
if((sum(isnan(X))<14)&&(sum(isnan(X))>=1)) % fill any NaN with the average number of infections
    avgX=mean(X(~isnan(X)));
    X(isnan(X))=avgX;
    CstatusR=(sum(X))./N.*100000;
else    % no days missing reported infections
    CstatusR=(sum(X))./N.*100000;
end

end

