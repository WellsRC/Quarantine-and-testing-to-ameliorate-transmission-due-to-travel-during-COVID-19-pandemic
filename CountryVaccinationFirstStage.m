function [vacup,tempH,VacupALO,vacM,tempHM] = CountryVaccinationFirstStage(Country,DateN,N,Demo)

% Return the vaccine efficacy
[epsvT1,epsvT2,epsvH1,epsvH2] = VaccineEfficacy;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Returns the first set of the calculation for the level of vaccine
% immunity and the effects of hosptualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

% Load the vaccination data
T=readtable([pwd '\Country_Data\VaccinationData.csv']);
%Find the country of interest
tA=strcmp(Country,T.location);
% Transform the date
TDate=datenum(T.date);
% Find the date of interets
fDate=DateN==TDate;
% Determine in the entry is NaN
tp=~isnan(T.people_vaccinated)&~isnan(T.people_fully_vaccinated);

if(sum(tA&fDate&tp)>0)
    % If we have data for that specified date
    vacup1=(T.people_vaccinated(tA&fDate))./N; % Proportion of the population that have received at least one dose
    vacup2=(T.people_fully_vaccinated(tA&fDate))./N; % Proportion of the population fully immunized
    VacupALO=T.people_vaccinated(tA&fDate)./N; % Proportion of the population that have received at least one dose
    
    agep=flip(Demo); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacup=zeros(size(epsvT1));
    tempH=zeros(size(epsvT1));
    for aa=1:length(epsvT1)
        pvac1=min(max(vacup1-ccvac(aa),0)./Demo(aa),1); % proportion of the age class to receive at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./Demo(aa),1); % proportion of the age class fully immunized
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacup(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempH(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    agep=flip(Demo); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacM=zeros(101,length(epsvT1));
    tempHM=zeros(101,length(epsvT1));
    for vvv=1:101
        for aa=1:length(epsvT1)
            VA=(vvv-1)./100; % proportion of the populationto receive at least one dose
            VA2=max(VA-lagV,0); % proportion of the population fully vaccinated
            pvac1=min(max(VA-ccvac(aa),0)./Demo(aa),1); % proportion of the age class to receive at least one dose
            pvac2=min(max(VA2-ccvac(aa),0)./Demo(aa),1); % proportion of the age class fully immunized
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized

            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacM(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHM(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
    
elseif(sum(tA&tp)>0)
    
    % If we have NO data for that specified date
    PeopleVaccinated=pchip(TDate(tA&tp),T.people_vaccinated(tA&tp),DateN); % Inteprolate the number of people who have received at least one dose
    PeopleFullyVaccinated=pchip(TDate(tA&tp),T.people_fully_vaccinated(tA&tp),DateN); %Inteprolate the number of people who are fully immunized     


    vacup1=(PeopleVaccinated)./N; % proportion to receive at least one dose
    vacup2=(PeopleFullyVaccinated)./N; % proportion fully immunized
    VacupALO=PeopleVaccinated./N; % proportion to receive at least one dose
    
    
    agep=flip(Demo); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacup=zeros(size(epsvT1));
    tempH=zeros(size(epsvT1));
    for aa=1:length(epsvT1)
        pvac1=min(max(vacup1-ccvac(aa),0)./Demo(aa),1); % proportion of the age class to receive at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./Demo(aa),1); % proportion of the age class fully immunized
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacup(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempH(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    agep=flip(Demo); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacM=zeros(101,length(epsvT1));
    tempHM=zeros(101,length(epsvT1));
    for vvv=1:101
        for aa=1:length(epsvT1)
            VA=(vvv-1)./100; % proportion of the populationto receive at least one dose
            VA2=max(VA-lagV,0); % proportion of the population fully vaccinated
            pvac1=min(max(VA-ccvac(aa),0)./Demo(aa),1); % proportion of the age class to receive at least one dose
            pvac2=min(max(VA2-ccvac(aa),0)./Demo(aa),1); % proportion of the age class fully immunized
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized

            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacM(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHM(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
else
    % There is no data
    vacup=[];
    vacM=[];
    VacupALO=[];
end

end

