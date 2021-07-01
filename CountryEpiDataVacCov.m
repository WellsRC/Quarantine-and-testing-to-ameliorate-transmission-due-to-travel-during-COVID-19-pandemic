function [prevM] = CountryEpiDataVacCov(Country,DateN,N,Demo,vacM,rec,pA)

% Read the data
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
%Find the country name
t=strcmp(Country,T.location_name);
%Confert data to numbers
TDate=datenum(T.date);
% Find the date of interest
fDate=DateN==TDate;

%%% Determine the age based prevalance 
findx=find(t&fDate);

prevM=zeros(size(vacM));
for vvv=1:length(vacM(:,1))    
    % Temporary assumption to determine prportion susceptible to infection in different age classes 
    PopIM=1-vacM(vvv,:).*(1-rec)-rec; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
    Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level
    Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(Demo.*PopIM)./(sum(Demo.*PopIM)); % Distribute the number of infections over this past time based on immunity level

    % Determine the age based prev based on asympotmtic proportion of the age
    % class
    prevM(vvv,:)=((1-pA).*Symptomatic+pA.*Asymptomatic)./(Demo.*N);
end

end

