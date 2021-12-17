close all;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
IncubationP=5.723;
DateI={'November 21, 2021'};
switch IncubationP
    case 5.723
        cFile={'Shorter_Incubation_Quarantine_RTPCR_Exit','Shorter_Incubation_Quarantine_BDVeritor_Exit','Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit','Shorter_Incubation_NoTest'};
    case 8.29
        cFile={'Quarantine_RTPCR_Exit','Quarantine_BDVeritor_Exit','Quarantine_BDVeritor_Entry_Exit','NoTest'};
    case 11.66
        cFile={'Longer_Incubation_Quarantine_RTPCR_Exit','Longer_Incubation_Quarantine_BDVeritor_Exit','Longer_Incubation_Quarantine_BDVeritor_Entry_Exit','Longer_Incubation_NoTest'};
end

DateInterV={'October 3, 2021','October 10, 2021', 'October 17, 2021',    'October 24, 2021',    'October 31, 2021',    'November 7, 2021',    'November 14, 2021' ,'November 21, 2021'};
DateIEarly={'August 8, 2021'};
for ii=1:4
    CountryMatrixNoVOC(cFile{ii},DateI,1,1,IncubationP);
    
    CountryMatrixNoVOC_Early(cFile{ii},DateIEarly,1,1,IncubationP);
        
    TrafficLightAnalysis(cFile{ii},DateI,1,1,IncubationP);
    
    AIRLINETrafficLightAnalysis(cFile{ii},DateI,1,1,IncubationP);
    
    CountryMatrixNoVOCAirline(cFile{ii},DateI,1,1,IncubationP);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % Alternative Dates
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


CountryMatrixNoVOCTimeVary(cFile{1},DateInterV,1,1,IncubationP)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Adherence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for ii=3:-1:1
    CountryMatrixNoVOC(cFile{1},DateI,0.25*ii,1,IncubationP);
    CountryMatrixNoVOC(cFile{1},DateI,1,0.25*ii,IncubationP);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Incubation Period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
IncubationP=8.29;
DateI={'November 21, 2021'};
switch IncubationP
    case 5.723
        cFile={'Shorter_Incubation_Quarantine_RTPCR_Exit','Shorter_Incubation_Quarantine_BDVeritor_Exit','Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit','Shorter_Incubation_NoTest'};
    case 8.29
        cFile={'Quarantine_RTPCR_Exit','Quarantine_BDVeritor_Exit','Quarantine_BDVeritor_Entry_Exit','NoTest'};
    case 11.66
        cFile={'Longer_Incubation_Quarantine_RTPCR_Exit','Longer_Incubation_Quarantine_BDVeritor_Exit','Longer_Incubation_Quarantine_BDVeritor_Entry_Exit','Longer_Incubation_NoTest'};
end

for ii=1:4
    CountryMatrixNoVOC(cFile{ii},DateI,1,1,IncubationP);
    TrafficLightAnalysis(cFile{ii},DateI,1,1,IncubationP);
end

IncubationP=11.66;
DateI={'November 21, 2021'};
switch IncubationP
    case 5.723
        cFile={'Shorter_Incubation_Quarantine_RTPCR_Exit','Shorter_Incubation_Quarantine_BDVeritor_Exit','Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit','Shorter_Incubation_NoTest'};
    case 8.29
        cFile={'Quarantine_RTPCR_Exit','Quarantine_BDVeritor_Exit','Quarantine_BDVeritor_Entry_Exit','NoTest'};
    case 11.66
        cFile={'Longer_Incubation_Quarantine_RTPCR_Exit','Longer_Incubation_Quarantine_BDVeritor_Exit','Longer_Incubation_Quarantine_BDVeritor_Entry_Exit','Longer_Incubation_NoTest'};
end

for ii=1:4
    CountryMatrixNoVOC(cFile{ii},DateI,1,1,IncubationP);
    TrafficLightAnalysis(cFile{ii},DateI,1,1,IncubationP);
end

