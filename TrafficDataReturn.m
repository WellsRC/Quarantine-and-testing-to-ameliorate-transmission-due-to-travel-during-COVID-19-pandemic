function [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,DemoA,DemoB] = TrafficDataReturn(StatusA,StatusB,recA,recB,NA,NB,pA,AL,Date,Incubation)

Demo=[0.210888011 0.11534318 0.141457647 0.139470807 0.140165756 0.121345549+0.078708003+0.052621047];
h = HospitalRate;



[epsvT1,epsvT2,epsvH1,epsvH2] = VaccineEfficacy;


DemoA=Demo;
DemoB=Demo;

recA=recA.*ones(size(pA));
recB=recB.*ones(size(pA));

cA=((StatusA./100000)/14);
cB=((StatusB./100000)/14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Set-up first part of vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55fDate=datenum(T.ReportingWeek)<=DateN & datenum(T.ReportingWeek)>DateN-7 ;
%age=[0-19 20-29 30-39 40-49 50-59 60-100];
DateNShift=datenum(Date)-14; % Need to shift based on the vaccine immunite

%0-4 5-9 10-14 15-19 to construct the wieght for under 18
DemoTemp=[0.249998029 0.258931456 0.252217613 0.238852901];

Tt=readtable([pwd '\Country_Data\VaccineDoses_Age_Europe_At_least_one.csv']);

T=[DemoTemp(1).*Tt.x0_4Years+DemoTemp(2).*Tt.x5_9Years+DemoTemp(3).*Tt.x10_14Years+DemoTemp(4).*Tt.x15_17Years  Tt.x18_24Years Tt.x25_49Years Tt.x50_59Years Tt.x60_Years];

DateV=Tt.ReportingWeek;
fDate=datenum(DateV)<=DateNShift & datenum(DateV)>DateNShift-7 ;

T=T(fDate,:);
% [20-24 25-49]
WDV=[39710692 256376663]; % Age demographics for 20-49 age group across Europe
V1=[T(1) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) T(4) T(5)];

Tt=readtable([pwd '\Country_Data\VaccineDoses_Age_Europe_Full.csv']);

T=[DemoTemp(1).*Tt.x0_4Years+DemoTemp(2).*Tt.x5_9Years+DemoTemp(3).*Tt.x10_14Years+DemoTemp(4).*Tt.x15_17Years  Tt.x18_24Years Tt.x25_49Years Tt.x50_59Years Tt.x60_Years];

DateV=Tt.ReportingWeek;
fDate=datenum(DateV)<=DateNShift & datenum(DateV)>DateNShift-7 ;

T=T(fDate,:);

V2=[T(1) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) (T(2).*WDV(1)+T(3).*WDV(2))./sum(WDV) T(4) T(5)];


pvac1=V1; % proportion of the age class to receive at least one dose
pvac2=V2; % proportion of the age class fully immunized
pvac1=pvac1-pvac2; % the proprition of the population partially immunized

% Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
vacupA=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
% Temp variable for determining hospitalization. Other components
% will be added later
tempHA=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity

% Vaccine coverage based on age-dose-specific efficacy (Note: have notyet removed prev. or recovery)
vacupB=(epsvT1.*pvac1+epsvT2.*pvac2); % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
% Temp variable for determining hospitalization. Other components
% will be added later
tempHB=-(pvac1+pvac2)+((1-epsvT1).*(1-epsvH1).*pvac1+(1-epsvT2).*(1-epsvH2).*pvac2); % Subtract prevalence later prevalence as we need to weigh later by immunity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Set-up prevalence and remaining vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
PopAIM=1-vacupA.*(1-recA)-recA;
Symptomatic=(Incubation).*cA.*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM));
SymptomaticNoIsolation=(20+Incubation).*cA.*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM));
Asymptomatic=(20+Incubation).*cA.*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM));

prevA=(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic); %Do not need to divide to obtain prevalence as we adjusted fraction incidence above to be cases per person

vacupA=vacupA.*(1-prevA-recA); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

PopAS=1-vacupA-prevA-recA;
                
proHA=1+(tempHA).*(1-prevA-recA)-recA-prevA; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHA=h.*proHA./PopAS;


PopAIM=1-vacupB.*(1-recB)-recB;
Symptomatic=(Incubation).*cB.*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM));
SymptomaticNoIsolation=(20+Incubation).*cB.*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM));
Asymptomatic=(20+Incubation).*cB.*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM));

prevB=(AL.*(1-pA).*Symptomatic+(1-AL).*(1-pA).*SymptomaticNoIsolation+pA.*Asymptomatic); %Do not need to divide to obtain prevalence as we adjusted fraction incidence above to be cases per person

vacupB=vacupB.*(1-prevB-recB); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

PopAS=1-vacupB-prevB-recB;
                
proHB=1+(tempHB).*(1-prevB-recB)-recB-prevB; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHB=h.*proHB./PopAS;
end

