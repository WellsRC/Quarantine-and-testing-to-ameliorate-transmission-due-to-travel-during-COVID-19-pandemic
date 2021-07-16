close all;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
CountryMatrixNoVOC('NoTest',1,1)

% RT-PCR on Exit
CountryMatrix_Hospital('Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
CountryMatrix_Hospital('Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
CountryMatrix_Hospital('Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
CountryMatrix_Hospital('NoTest',1,1)

%Not test
CountryMatrix_Hospital_NoTravel('NoTest',1,1)


%% 100% Adherence
% RT-PCR on Exit
TrafficLightAnalysis('Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
TrafficLightAnalysis('Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
TrafficLightAnalysis('Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
TrafficLightAnalysis('NoTest',1,1)

%% 75% Adherence to self isolation
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.75,1)

%% 50% Adherenceto self isolation
% RT-PCR on Exit 
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.50,1)

%% 25% Adherenceto self isolation
% RT-PCR on Exit 
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.25,1)


%% 75% Adherence to Quaratnine
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.75)
%% 50% Adherence to Quaratnine
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.5)
%% 25% Adherence to Quaratnine
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.25)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wells et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',1,1)


%% 100% Adherence
% RT-PCR on Exit
TrafficLightAnalysis('NatComm-Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
TrafficLightAnalysis('NatComm-Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
TrafficLightAnalysis('NatComm-Quarantine_BDVeritor_Entry_Exit',1,1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shorter incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RT-PCR on Exit
CountryMatrixNoVOC('Shorter_Incubation_Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
CountryMatrixNoVOC('Shorter_Incubation_Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
CountryMatrixNoVOC('Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
CountryMatrixNoVOC('Shorter_Incubation_NoTest',1,1)

% RT-PCR on Exit
TrafficLightAnalysis('Shorter_Incubation_Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
TrafficLightAnalysis('Shorter_Incubation_Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
TrafficLightAnalysis('Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
TrafficLightAnalysis('Shorter_Incubation_NoTest',1,1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Longer incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% RT-PCR on Exit
CountryMatrixNoVOC('Longer_Incubation_Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
CountryMatrixNoVOC('Longer_Incubation_Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
CountryMatrixNoVOC('Longer_Incubation_Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
CountryMatrixNoVOC('Longer_Incubation_NoTest',1,1)

% RT-PCR on Exit
TrafficLightAnalysis('Longer_Incubation_Quarantine_RTPCR_Exit',1,1)
% RA test on Exit
TrafficLightAnalysis('Longer_Incubation_Quarantine_BDVeritor_Exit',1,1)
% RA test on Entry and Exit
TrafficLightAnalysis('Longer_Incubation_Quarantine_BDVeritor_Entry_Exit',1,1)
% NoTest
TrafficLightAnalysis('Longer_Incubation_NoTest',1,1)
