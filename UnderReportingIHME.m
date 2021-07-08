function [UR] = UnderReportingIHME(Country,DateN)

% Read the data
% T=readtable([pwd '\Country_Data\reference_hospitalization_all_locs.csv']);
load('IHME_Data.mat');
%Find the country name
t=strcmp(Country,T.location_name);
%Confert data to numbers
TDate=datenum(T.date);
% Find the date of interest
fDate=DateN==TDate;


% Determine the multiplying factor to correct for under-repprting
fDatePTW=(DateN-15)==TDate;

findx=find(t & fDate);

X=(T.confirmed_infections((findx-13):findx));
EstX=(T.inf_cuml_mean(t&fDate)-T.inf_cuml_mean(t&fDatePTW));
if(sum(isnan(X))==14) % No recorded incidence at all for the week of interest; thus rely soley on estimated incidence to determine status
    UR=NaN;  
elseif((sum(isnan(X))<14)&&(sum(isnan(X))>=1)) % fill any NaN with the average number of infections
    avgX=mean(X(~isnan(X)));
    X(isnan(X))=avgX;
    UR=EstX./sum(X)-1;
else    % no days missing reported infections    
    UR=EstX./sum(X)-1;
end
end

