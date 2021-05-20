function [qt,prevMA,prevMB,prevA,prevB,vacMA,vacMB,vacupA,vacupB,proHMA,proHMB,proHA,proHB,recA,recB,cA,cB,NA,NB,avgdAB,pgeoAB,VTAB,avgdBA,pgeoBA,VTBA,RA,RB,CAstatusR,CBstatusR,VacupALOA,VacupALOB,VOCB117A,VOCB117B,VOCP1A,VOCP1B,VOC501YV2A,VOC501YV2B,DemoA,DemoB] = CountryDataReturnHospitalization(Date,CountryA,CountryB,pA,cFile)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demographics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=readtable('Age_Population.csv');

tA=strcmp(CountryA,T.Region_Subregion_CountryOrArea_);
tB=strcmp(CountryB,T.Region_Subregion_CountryOrArea_);

%age=[19 29 39 49 59 69 79 100];
Test=[T.age0(tA)+T.age5(tA)+T.age10(tA)+T.age15(tA) T.age20(tA)+T.age25(tA) T.age30(tA)+T.age35(tA) T.age40(tA)+T.age45(tA) T.age50(tA)+T.age55(tA) T.age60(tA)+T.age65(tA) T.age70(tA)+T.age75(tA) T.age80(tA)+T.age85(tA)+T.age90(tA)+T.age95(tA)+T.age100(tA)];
if(~isempty(Test))
    DemoA=Test./sum(Test);
else
    DemoA=[];
end

Test=[T.age0(tB)+T.age5(tB)+T.age10(tB)+T.age15(tB) T.age20(tB)+T.age25(tB) T.age30(tB)+T.age35(tB) T.age40(tB)+T.age45(tB) T.age50(tB)+T.age55(tB) T.age60(tB)+T.age65(tB) T.age70(tB)+T.age75(tB) T.age80(tB)+T.age85(tB)+T.age90(tB)+T.age95(tB)+T.age100(tB)];
if(~isempty(Test))
    DemoB=Test./sum(Test);
else
    DemoB=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Recovered population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

T=readtable('reference_hospitalization_all_locs.csv');
tA=strcmp(CountryA,T.location_name);
tB=strcmp(CountryB,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;
% Assumes uniform recovery among the different age classes
recA=T.seroprev_mean(tA & fDate).*ones(size(DemoA));
recB=T.seroprev_mean(tB & fDate).*ones(size(DemoB));
% Population size
NA=T.total_pop(tA & fDate);
NB=T.total_pop(tB & fDate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Vaccination Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Vaccine efficacy for transmission
epsvT1=[32 32 32 30 30 30 26 26]./100; % First dose
epsvT2=[94 94 94 90 90 90 95 95]./100; % Second dose

% Vaccine efficacy for hospitalization
epsvH1=[33 33 33 70 70 70 51 51]./100; %First dose
epsvH2=[87 87 87 87 87 87 87 87]./100; % Second dose

% Hospitalization rate
h=[0.1 0.5 1.1 1.4 2.9 5.8 9.3 26.2]./100;

% Load the vaccination data
T=readtable('VaccinationData.csv');
tA=strcmp(CountryA,T.location);
tB=strcmp(CountryB,T.location);

TDate=datenum(T.date);
fDate=DateN==TDate;


tp=~isnan(T.people_vaccinated)&~isnan(T.people_fully_vaccinated);

if(sum(tA&fDate&tp)>0)
    % If we have data for that specified date
    vacup1=(T.people_vaccinated(tA&fDate))./NA; % Proportion of the population that have received at least one dose
    vacup2=(T.people_fully_vaccinated(tA&fDate))./NA; % Proportion of the population fully immunized
    VacupALOA=T.people_vaccinated(tA&fDate)./NA; % Proportion of the population that have received at least one dose
    
    agep=flip(DemoA); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacupA=zeros(size(epsvT1));
    tempHA=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(vacup1-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class to receive at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class fully immunized
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacupA(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempHA(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    agep=flip(DemoA); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacMA=zeros(101,length(epsvT1));
    tempHMA=zeros(101,length(epsvT1));
    for vvv=1:101
        for aa=1:length(recA)
            VA=(vvv-1)./100; % proportion of the populationto receive at least one dose
            VA2=max(VA-lagV,0); % proportion of the population fully vaccinated
            pvac1=min(max(VA-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class to receive at least one dose
            pvac2=min(max(VA2-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class fully immunized
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized

            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacMA(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHMA(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
    
elseif(sum(tA&tp)>0)
    
    % If we have NO data for that specified date
    PeopleVaccinated=pchip(TDate(tA&tp),T.people_vaccinated(tA&tp),DateN); % Inteprolate the number of people who have received at least one dose
    PeopleFullyVaccinated=pchip(TDate(tA&tp),T.people_fully_vaccinated(tA&tp),DateN); %Inteprolate the number of people who are fully immunized     


    vacup1=(PeopleVaccinated)./NA; % proportion to receive at least one dose
    vacup2=(PeopleFullyVaccinated)./NA; % proportion fully immunized
    VacupALOA=PeopleVaccinated./NA; % proportion to receive at least one dose
    
    
    agep=flip(DemoA); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacupA=zeros(size(epsvT1));
    tempHA=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(vacup1-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class to receive at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class fully immunized
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacupA(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempHA(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    agep=flip(DemoA); % needs to flip the age demographics as we prioritize the elderly
    ccvac=cumsum(agep); % cumulative sum to determine when other age classes become prioritized
    ccvac=flip([0 ccvac(1:end-1)]); % The first threshold should be zero as no one is yet vaccinated. We flip this as we will loop through the lower age class first
    vacMA=zeros(101,length(epsvT1));
    tempHMA=zeros(101,length(epsvT1));
    for vvv=1:101
        for aa=1:length(recA)
            VA=(vvv-1)./100; % proportion of the populationto receive at least one dose
            VA2=max(VA-lagV,0); % proportion of the population fully vaccinated
            pvac1=min(max(VA-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class to receive at least one dose
            pvac2=min(max(VA2-ccvac(aa),0)./DemoA(aa),1); % proportion of the age class fully immunized
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized

            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacMA(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHMA(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
else
    % There is no data
    vacupA=[];
    vacMA=[];
    VacupALOA=[];
end

if(sum(tB&fDate&tp)>0)       
    % If we have data for the specific date
    vacup1=(T.people_vaccinated(tB&fDate))./NB; % proportion to have at least one dose
    vacup2=(T.people_fully_vaccinated(tB&fDate))./NB; % proportion fully immunized
    VacupALOB=T.people_vaccinated(tB&fDate)./NB; % proportion to have one dose
    
    
    agep=flip(DemoB); % need to flip as we priortize eldery
    ccvac=cumsum(agep); % determine the trehsold for th edifferent age classes
    ccvac=flip([0 ccvac(1:end-1)]); % initial threshold is zero since no one has been vaccinated
    vacupB=zeros(size(epsvT1));
    tempHB=zeros(size(epsvT1));
    for aa=1:length(recB)
        pvac1=min(max(vacup1-ccvac(aa),0)./DemoB(aa),1); % proportion age class to have at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./DemoB(aa),1); % proportion age class fully immunized
        pvac1=pvac1-pvac2; % proportion population partiall immuniozed
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacupB(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempHB(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    
    
    agep=flip(DemoB); % need to flip as we priortize eldery
    ccvac=cumsum(agep); % determine the trehsold for th edifferent age classes
    ccvac=flip([0 ccvac(1:end-1)]); % initial threshold is zero since no one has been vaccinated  
    vacMB=zeros(101,length(epsvT1));
    tempHMB=zeros(101,length(epsvT1));
    
    for vvv=1:101
        for aa=1:length(recB)
            VB=(vvv-1)./100; % proportino to receive at least one dose
            VB2=max(VB-lagV,0); % proportion to be fully immunized
            pvac1=min(max(VB-ccvac(aa),0)./DemoB(aa),1); % proportion of age class to receive at least one dose
            pvac2=min(max(VB2-ccvac(aa),0)./DemoB(aa),1); % proportion of age class to be fully immunized
            pvac1=pvac1-pvac2; % proportion partiall immunized 
            
            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacMB(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHMB(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
    
elseif(sum(tB&tp)>0)
    % No data for the date of interest
    PeopleVaccinated=pchip(TDate(tB&tp),T.people_vaccinated(tB&tp),DateN); % interpolate the number people receive at least one dose
    PeopleFullyVaccinated=pchip(TDate(tB&tp),T.people_fully_vaccinated(tB&tp),DateN);      % interpolate the number people fully immunized 


    vacup1=(PeopleVaccinated)./NB; % proportion to receive at least one dose
    vacup2=(PeopleFullyVaccinated)./NB; % proportion fully immunized
    VacupALOB=PeopleVaccinated./NB; % proportion to receive at least one dose
    
    agep=flip(DemoB); % need to flip as we priortize eldery
    ccvac=cumsum(agep); % determine the trehsold for th edifferent age classes
    ccvac=flip([0 ccvac(1:end-1)]); % initial threshold is zero since no one has been vaccinated
    vacupB=zeros(size(epsvT1));
    tempHB=zeros(size(epsvT1));
    for aa=1:length(recB)
        pvac1=min(max(vacup1-ccvac(aa),0)./DemoB(aa),1); % proportion age class to have at least one dose
        pvac2=min(max(vacup2-ccvac(aa),0)./DemoB(aa),1); % proportion age class fully immunized
        pvac1=pvac1-pvac2; % proportion population partiall immuniozed
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacupB(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempHB(aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
    
    % Determine the lag between the different coverage in case we want to
    % "project" coverage for the different countries
    lagV=vacup1-vacup2;
    
    
    agep=flip(DemoB); % need to flip as we priortize eldery
    ccvac=cumsum(agep); % determine the trehsold for th edifferent age classes
    ccvac=flip([0 ccvac(1:end-1)]); % initial threshold is zero since no one has been vaccinated  
    vacMB=zeros(101,length(epsvT1));
    tempHMB=zeros(101,length(epsvT1));
    
    for vvv=1:101
        for aa=1:length(recB)
            VB=(vvv-1)./100; % proportino to receive at least one dose
            VB2=max(VB-lagV,0); % proportion to be fully immunized
            pvac1=min(max(VB-ccvac(aa),0)./DemoB(aa),1); % proportion of age class to receive at least one dose
            pvac2=min(max(VB2-ccvac(aa),0)./DemoB(aa),1); % proportion of age class to be fully immunized
            pvac1=pvac1-pvac2; % proportion partiall immunized 
            
            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacMB(vvv,aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2); % Do not want to scale by prevalence as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempHMB(vvv,aa)=-(pvac1+pvac2)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
        end
    end
else
    % No data
    vacupB=[];
    vacMB=[];
    VacupALOB=[];    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Infected population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

T=readtable('reference_hospitalization_all_locs.csv');
tA=strcmp(CountryA,T.location_name);
tB=strcmp(CountryB,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;
NA=T.total_pop(tA & fDate);
NB=T.total_pop(tB & fDate);
% Fractional incidence 
cA=T.confirmed_infections(tA & fDate)./NA; 
cB=T.confirmed_infections(tB & fDate)./NB;


%%% Determine the age based prevalance 
findx=find(tA&fDate);
% Temporary assumption to determine prportion susceptible to infection in different age classes 
PopAIM=1-vacupA.*(1-recA)-recA; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level

% Determine the age based prev based on asympotmtic proportion of the age
% class
prevA=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoA.*NA);
% Dtermine the vaccine uptake based on the estimated prev
vacupA=vacupA.*(1-prevA-recA); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER
% Detemrine the proportion of the population susceptile to infection
PopAS=1-vacupA-prevA-recA;

% proportino of the population suscptible to hospitalization
proHA=1+(tempHA).*(1-prevA-recA)-recA-prevA; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
% proportiog of popualtino suscpetible to hospitalization
proHA=h.*proHA./PopAS;

%%% Determine for given vaccine uptake levels
proHMA=zeros(101,length(DemoA));
prevMA=zeros(101,length(DemoA));

for vvv=1:101
    
% Temporary assumption to determine prportion susceptible to infection in different age classes 
PopAIM=1-vacMA(vvv,:).*(1-recA)-recA; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level

% Determine the age based prev based on asympotmtic proportion of the age
% class
prevMA(vvv,:)=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoA.*NA);
% Need to correct the vaccine uptake based on prev
vacMA(vvv,:)=vacMA(vvv,:).*(1-prevMA(vvv,:)-recA); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER
% Detemrine the proportion of the population susceptile to infection
PopAS=1-vacMA(vvv,:)-prevMA(vvv,:)-recA;
% proportino of the population suscptible to hospitalization          
proHMA(vvv,:)=1+(tempHMA(vvv,:)).*(1-prevMA(vvv,:)-recA)-recA-prevMA(vvv,:); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
% proportiog of popualtino suscpetible to hospitalization
proHMA(vvv,:)=h.*proHMA(vvv,:)./PopAS;
end
%%%
% Determines the EU colour statis of the country (i.e. total infections per
% 100000 for the last 2 weeks
CAstatusR=sum(T.confirmed_infections((findx-13):(findx)))./NA.*100000;

findx=find(tB&fDate);
% Temporary assumption to determine prportion susceptible to infection in different age classes 
PopAIM=1-vacupB.*(1-recB)-recB; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
% Determine the age based prev based on asympotmtic proportion of the age
% class
prevB=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoB.*NB);
% Update vaccine uptake based on age base dprev
vacupB=vacupB.*(1-prevB-recB); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

% Detemrine the proportion of the population susceptile  to infection
PopAS=1-vacupB-prevB-recB;

% proportino of the population suscptible to hospitalization                    
proHB=1+(tempHB).*(1-prevB-recB)-recB-prevB; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHB=h.*proHB./PopAS;

%%%
proHMB=zeros(101,length(DemoB));
prevMB=zeros(101,length(DemoB));

for vvv=1:101
    
% Temporary assumption to determine prportion susceptible to infection in different age classes 
PopAIM=1-vacMB(vvv,:).*(1-recB)-recB;
Symptomatic=sum(T.confirmed_infections((findx-7):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.confirmed_infections((findx-27):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
% Determine the age based prev
prevMB(vvv,:)=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoB.*NB);
% Update vaccine uptake based on age base dprev
vacMB(vvv,:)=vacMB(vvv,:).*(1-prevMB(vvv,:)-recB); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

% Detemrine the proportion of the population susceptile to infection
PopAS=1-vacMB(vvv,:)-prevMB(vvv,:)-recB;
 % proportino of the population suscptible to hospitalization                
proHMB(vvv,:)=1+(tempHMB(vvv,:)).*(1-prevMB(vvv,:)-recB)-recB-prevMB(vvv,:); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHMB(vvv,:)=h.*proHMB(vvv,:)./PopAS;
end
%%%
% Determines the EU colour statis of the country (i.e. total infections per
% 100000 for the last 2 weeks
CBstatusR=sum(T.confirmed_infections((findx-13):(findx)))./NB.*100000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Travel Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(strcmp(CountryB,'United Kingdom'))
    % Country A data (i.e. entering the UK)
    T=readtable('Travel_Into_UK.xlsx','Sheet','2.10','Range','A13:M77');
    T=T(:,[1 13]);
    tA=strcmp(CountryA,T.Var1);
    VTAB=1000*T.Var13(tA)./365; % Divide by 365 since the number is annual
    
    T=readtable('Travel_Into_UK.xlsx','Sheet','2.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tA=strcmp(CountryA,T.Var1);
    avgdAB=T.Var25(tA);
    x=[1:30];
    if(~isempty(avgdAB))
        pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
    else
        pgeoAB=[];
    end
    
    % Country B data (i.e. leaving the UK for country A)
    T=readtable('Travel_Leaving_UK.xlsx','Sheet','3.10','Range','A13:M77');
    T=T(:,[1 13]);
    tB=strcmp(CountryA,T.Var1);
    VTBA=1000*T.Var13(tB)./365; % Divide by 365 since the number is annual
    
    T=readtable('Travel_Leaving_UK.xlsx','Sheet','3.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tB=strcmp(CountryA,T.Var1);
    avgdBA=T.Var25(tB);
    x=[1:30];
    if(~isempty(avgdBA))
        pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
    else
        pgeoBA=[];
    end
elseif(strcmp(CountryA,'United Kingdom'))
    % Country A Data (i.e. leaving the UK for country B)
    T=readtable('Travel_Leaving_UK.xlsx','Sheet','3.10','Range','A13:M77');
    T=T(:,[1 13]);
    tA=strcmp(CountryB,T.Var1);
    VTAB=1000*T.Var13(tA)./365; % Divide by 365 since the number is annual
    
    T=readtable('Travel_Leaving_UK.xlsx','Sheet','3.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tA=strcmp(CountryB,T.Var1);
    avgdAB=T.Var25(tA);
    x=[1:30];
    if(~isempty(avgdAB))
        pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
    else
        pgeoAB=[];
    end
    
    % Country B data (i.e. entering the UK)
    T=readtable('Travel_Into_UK.xlsx','Sheet','2.10','Range','A13:M77');
    T=T(:,[1 13]);
    tB=strcmp(CountryB,T.Var1);
    VTBA=1000*T.Var13(tB)./365; % Divide by 365 since the number is annual
    
    T=readtable('Travel_Into_UK.xlsx','Sheet','2.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tB=strcmp(CountryB,T.Var1);
    avgdBA=T.Var25(tB);
    x=[1:30];
    if(~isempty(avgdBA))
        pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
    else
       pgeoBA=[]; 
    end
else    
    if(strcmp(CountryA,'Italy'))
        % Country B entering Italy
        T=readtable('Italy_Tourism.xlsx','Range','A9:N70');
        tB=strcmp(CountryB,T.CountryOfResidenceOfGuests);
        VTBA=T.arrivals_3(tB)./365; % Divide by 365 since the number is annual
        avgdBA=T.nightsSpent_3(tB)./T.arrivals_3(tB);
        x=[1:30];
        if(~isempty(avgdBA))
            pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
        else
            pgeoBA=[];
        end
    elseif(strcmp(CountryA,'Turkey'))
        % Country B entering Turkey
        avgdBA=9.9; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
        T=readtable('Destination_Turkey.xls','Range','A4:V123');
        tB=strcmp(CountryB,T.Milliyet_Nationality);
        VTBA=T.x2019(tB)./365; % Divide by 365 since the number is annual       
    
    elseif(strcmp(CountryA,'Greece'))
        % Country B entering Greece
        T=readtable('Greece_Arrivals.xlsx','Range','A5:G56');
        tB=strcmp(CountryB,T.COUNTRYOFRESIDENCE);
        VTBA=T.Total(tB)./365; % Divide by 365 since the number is annual
        avgdBA=T.Total_Bed(tB)./T.Total(tB);
        x=[1:30];
        if(~isempty(avgdBA))
            pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
        else
            pgeoBA=[];
        end     
    elseif(strcmp(CountryA,'Norway'))
        % Country B entering Norway
        avgdBA=4.253182605; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
        T=readtable('Norway_GuestNights.xlsx','Range','A4:N75');
        tB=strcmp(CountryB,T.Var1);
        VTBA=(T.Y2019(tB)./365)./avgdBA; % Divide by 365 since the number is annual   
    elseif(exist(['Destination_' CountryA{1} '-2019.xlsx'],'file'))
        % Country B entering Country A
       T=readtable(['Destination_' CountryA{1} '-2019.xlsx'],'Range','A7:J100');
       tB=strcmp(CountryB,T.Var1);
        VTBA=T.x2019(tB)./365; % Divide by 365 since the number is annual
        avgdBA=T.x2019_1(tB)./T.x2019(tB); % Bed days divided by total travellers
        x=[1:30];
        if((~isempty(avgdBA))&&(~isnan(avgdBA)))
            pgeoBA=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdBA).^2,1./avgdBA,[],[],[],[],0,1);
        else
            pgeoBA=[];
        end
       
   else
       VTBA=[];
       avgdBA=[];
       pgeoBA=[];
    end
   
    
    if(strcmp(CountryB,'Italy'))
        % Country A entering Italy
        T=readtable('Italy_Tourism.xlsx','Range','A9:N70');
        tA=strcmp(CountryA,T.CountryOfResidenceOfGuests);
        VTAB=T.arrivals_3(tA)./365; % Divide by 365 since the number is annual
        avgdAB=T.nightsSpent_3(tA)./T.arrivals_3(tA);
        x=[1:30];
        if(~isempty(avgdAB))
            pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
        else
            pgeoAB=[];
        end
    elseif(strcmp(CountryB,'Turkey'))
        % Country A entering Turkey
        avgdAB=9.9; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
        T=readtable('Destination_Turkey.xls','Range','A4:V123');
        tA=strcmp(CountryA,T.Milliyet_Nationality);
        VTAB=T.x2019(tA)./365; % Divide by 365 since the number is annual
    elseif(strcmp(CountryB,'Greece'))
        % Country A entering Greece
        T=readtable('Greece_Arrivals.xlsx','Range','A5:G56');
        tA=strcmp(CountryA,T.COUNTRYOFRESIDENCE);
        VTAB=T.Total(tA)./365; % Divide by 365 since the number is annual
        avgdAB=T.Total_Bed(tA)./T.Total(tA);
        x=[1:30];
        if(~isempty(avgdAB))
            pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
        else
            pgeoAB=[];
        end
    elseif(strcmp(CountryB,'Norway'))
        % Country A entering Norway
        avgdAB=4.253182605; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
        T=readtable('Norway_GuestNights.xlsx','Range','A4:N75');
        tA=strcmp(CountryA,T.Var1);
        VTAB=(T.Y2019(tA)./365)./avgdAB; % Divide by 365 since the number is annual        
    elseif(exist(['Destination_' CountryB{1} '-2019.xlsx'],'file'))
        % Country A entering Country B
       T=readtable(['Destination_' CountryB{1} '-2019.xlsx'],'Range','A7:J100');
       tA=strcmp(CountryA,T.Var1);
        VTAB=T.x2019(tA)./365; % Divide by 365 since the number is annual
        avgdAB=T.x2019_1(tA)./T.x2019(tA); % Bed days divided by total travellers
        x=[1:30];
        if((~isempty(avgdAB))&&(~isnan(avgdAB)))
            pgeoAB=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-avgdAB).^2,1./avgdAB,[],[],[],[],0,1);
        else
            pgeoAB=[];
        end       
   else
       VTAB=[];
       avgdAB=[];
       pgeoAB=[];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B117 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable('VOC_Country_B117.xlsx','Range','A3:D110');

tA=strcmp(CountryA,T.Country);
tB=strcmp(CountryB,T.Country);
VOCB117A=T.x_VUI202012_01GR_501Y_V1_B_1_1_7_InPast4Weeks_1(tA)./100;
VOCB117B=T.x_VUI202012_01GR_501Y_V1_B_1_1_7_InPast4Weeks_1(tB)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P1 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable('VOC_Country_P1.xlsx','Range','A3:D33');


tA=strcmp(CountryA,T.Country);
tB=strcmp(CountryB,T.Country);

VOCP1A=T.x_GR_501Y_V3_P_1_InPast4Weeks_1(tA)./100;
VOCP1B=T.x_GR_501Y_V3_P_1_InPast4Weeks_1(tB)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 501YV2 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable('VOC_Country_501YV2.xlsx','Range','A3:D68');


tA=strcmp(CountryA,T.Country);
tB=strcmp(CountryB,T.Country);

VOC501YV2A=T.x_GH_501Y_V2_B_1_351_InPast4Weeks_1(tA)./100;
VOC501YV2B=T.x_GH_501Y_V2_B_1_351_InPast4Weeks_1(tB)./100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Effective Reproductive number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load([cFile{1} '=30.mat'],'R0','qt');
R0cA=R0;
R0cB=R0;

ts=8.29;
tL=2.9;
td=ts+20;
SelfIsolate=1;
RA=zeros(size(pA));
RB=zeros(size(pA));
for aa=1:length(pA)
    RA(aa)=integral(@(t)InfectiousnessfromInfection(t,R0cA,R0cA,pA(aa),ts,tL,td,SelfIsolate),0,td);
    RB(aa)=integral(@(t)InfectiousnessfromInfection(t,R0cB,R0cB,pA(aa),ts,tL,td,SelfIsolate),0,td);
end


end

