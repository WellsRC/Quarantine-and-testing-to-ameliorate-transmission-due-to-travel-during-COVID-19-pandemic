close all;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
IncubationP=5.723;
DateI={'August 8, 2021'};
switch IncubationP
    case 5.723
        cFile={'Shorter_Incubation_Quarantine_RTPCR_Exit','Shorter_Incubation_Quarantine_BDVeritor_Exit','Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit','Shorter_Incubation_NoTest'};
    case 8.29
        cFile={'Quarantine_RTPCR_Exit','Quarantine_BDVeritor_Exit','Quarantine_BDVeritor_Entry_Exit','NoTest'};
    case 11.66
        cFile={'Longer_Incubation_Quarantine_RTPCR_Exit','Longer_Incubation_Quarantine_BDVeritor_Exit','Longer_Incubation_Quarantine_BDVeritor_Entry_Exit','Longer_Incubation_NoTest'};
end

DateInterV={'20-Jun-2021','27-Jun-2021',    '04-Jul-2021',    '11-Jul-2021',    '18-Jul-2021',    '25-Jul-2021',    '01-Aug-2021','August 8, 2021'};

for ii=1:4
    CountryMatrixNoVOC(cFile{ii},DateI,1,1,IncubationP);
        
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
DateI={'August 8, 2021'};
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
DateI={'August 8, 2021'};
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

