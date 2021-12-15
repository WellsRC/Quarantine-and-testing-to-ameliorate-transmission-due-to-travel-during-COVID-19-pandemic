function [vacup,tempH,VacupALO] = CountryVaccinationFirstStage(Country,DateN,N,Demo)
DateNShift=DateN-14; % Need to shift the date for the extent of vaccine immunity
% Return the vaccine efficacy
[epsvT1,epsvT2,epsvH1,epsvH2] = VaccineEfficacy;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Returns the first set of the calculation for the level of vaccine
% immunity and the effects of hosptualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

% Load the vaccination data
% T=readtable([pwd '\Country_Data\VaccinationData.csv']);
load('Vaccination_Data.mat');
tA=strcmp(T.Country,Country);
if(sum(tA)>0)
    fDate=datenum(T.ReportingWeek)<=DateNShift & datenum(T.ReportingWeek)>DateNShift-7 ;
    
    % Need vaccine uptake and NOT immunity
    fDateV=datenum(T.ReportingWeek)<=DateN & datenum(T.ReportingWeek)>DateN-7 ;
    
    %age=[0-19 20-29 30-39 40-49 50-59 60-69 70-79 80-100];
    V=[T.x_18Years./(N.*Demo(1)) (T.x18_24Years+T.x25_49Years)./sum(N.*Demo(2:4)) (T.x18_24Years+T.x25_49Years)./sum(N.*Demo(2:4)) (T.x18_24Years+T.x25_49Years)./sum(N.*Demo(2:4)) T.x50_59Years./(N.*Demo(5)) T.x60_Years./(N.*Demo(6))];
    Vtot=[T.x_18Years+T.x18_24Years+T.x25_49Years+T.x50_59Years+T.x60_Years];
    tfirst=strcmp(T.Dose,'First');
    tfull=strcmp(T.Dose,'Full');
    
    VacupALO=0; %Vtot(tA&fDateV&tfirst)./N; % MADE SUCH THAT CAN RUN MORE RELEVANT TIME [NOT IMPORTANT]
    if(sum(tA&fDate)>0)
            pvac1=V(tA&fDate&tfirst,:); % proportion of the age class to receive at least one dose
            pvac1(pvac1>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
            pvac2=V(tA&fDate&tfull,:); % proportion of the age class fully immunized
            pvac2(pvac2>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized
            pvac1(pvac1<0)=0; % As people may have been vaccinated with J&J (one dose for a full vaccine)
            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacup=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempH=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
elseif(strcmp('United Kingdom',Country))
    load([pwd '\Country_Data\20211208covid19infectionsurveydatasets_UK.mat'])
    
    fDate=DateWeek<=DateNShift & DateWeek>DateNShift-7 ;    
    
    % Need vaccine uptake and NOT immunity
    fDateV=DateWeek<=DateN & DateWeek>DateN-7 ;
    
    if(sum(fDate)>0)
        VacupALO=0;%VTot(fDateV); % MADE SUCH THAT CAN RUN MORE RELEVANT TIME [NOT IMPORTANT]
            pvac1=V1(fDate,:); % proportion of the age class to receive at least one dose
            pvac1(pvac1>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
            pvac2=V2(fDate,:); % proportion of the age class fully immunized
            pvac2(pvac2>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
            pvac1=pvac1-pvac2; % the proprition of the population partially immunized
            pvac1(pvac1<0)=0; % As people may have been vaccinated with J&J (one dose for a full vaccine)
            % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
            vacup=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
            % Temp variable for determining hospitalization. Other components
            % will be added later
            tempH=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
elseif(strcmp('Germany',Country))
    %age=[0-19 20-29 30-39 40-49 50-59 60-69 70-79 80-100];
    
    load([pwd '\Country_Data\Germany_Age_Vaccination.mat'])
    fDate=Date==DateNShift;
    
    % Need vaccine uptake and NOT immunity
    fDateV=Date==DateN;
    
    Vone=[VFirstC(fDate,1)./(N.*Demo(1)) VFirstC(fDate,2)./(N.*sum(Demo(2:5))) VFirstC(fDate,2)./(N.*sum(Demo(2:5))) VFirstC(fDate,2)./(N.*sum(Demo(2:5))) VFirstC(fDate,2)./(N.*sum(Demo(2:5))) VFirstC(fDate,3)./(N.*sum(Demo(6:end)))];
    Vsecond=[VTwoC(fDate,1)./(N.*Demo(1)) VTwoC(fDate,2)./(N.*sum(Demo(2:5))) VTwoC(fDate,2)./(N.*sum(Demo(2:5))) VTwoC(fDate,2)./(N.*sum(Demo(2:5))) VTwoC(fDate,2)./(N.*sum(Demo(2:5))) VTwoC(fDate,3)./(N.*sum(Demo(6:end)))];
    
    VacupALO=0;%sum(VFirstC(fDateV,1:3))./N; % MADE SUCH THAT CAN RUN MORE RELEVANT TIME [NOT IMPORTANT]
    if(sum(fDate)>0)
        pvac1=Vone; % proportion of the age class to receive at least one dose
        pvac1(pvac1>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
        pvac2=Vsecond; % proportion of the age class fully immunized
        pvac2(pvac2>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        pvac1(pvac1<0)=0; % As people may have been vaccinated with J&J (one dose for a full vaccine)
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacup=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempH=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
elseif(strcmp('Netherlands',Country))
    load([pwd '\Country_Data\Vaccination_Netherlands.mat'],'V1','V2','Date')
    fDate=Date<=DateNShift & Date>DateNShift-7 ;
    
    % Need vaccine uptake and NOT immunity
    fDateV=Date<=DateN & Date>DateN-7 ;
    
    if(sum(fDate)>0)
        VacupALO=0;%sum(V1(fDateV,:).*Demo); % MADE SUCH THAT CAN RUN MORE RELEVANT TIME [NOT IMPORTANT]
        pvac1=V1(fDate,:); % proportion of the age class to receive at least one dose
        pvac1(pvac1>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
        pvac2=V2(fDate,:); % proportion of the age class fully immunized
        pvac2(pvac2>1)=1; % Need to adjust to ensure that the coverage not exceed 100%
        pvac1=pvac1-pvac2; % the proprition of the population partially immunized
        pvac1(pvac1<0)=0; % As people may have been vaccinated with J&J (one dose for a full vaccine)
        
        % Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
        vacup=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
        % Temp variable for determining hospitalization. Other components
        % will be added later
        tempH=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
else
    vacup=[];
    tempH=[];
    VacupALO=[];
end

