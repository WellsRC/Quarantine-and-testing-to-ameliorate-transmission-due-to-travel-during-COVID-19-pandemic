close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit

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

CountryMatrixVOC(cFile{1},DateI,1,1,IncubationP);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Summary for main text
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
CountryInlcude={'United Kingdom','Germany','Belgium','Denmark','Italy','Netherlands','Portugal','Slovakia','Czech Republic','Slovenia','Spain','Republic of Ireland'};

CountryMatrixVOC_summary(cFile{1},CountryInlcude,DateI,1,1,IncubationP);