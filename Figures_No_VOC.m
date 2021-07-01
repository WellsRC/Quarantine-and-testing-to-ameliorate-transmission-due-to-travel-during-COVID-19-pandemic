close all;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',1)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',1)

%% 75% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.75)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',0.75)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',0.75)

%% 50% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.50)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',0.50)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',0.50)

%% 25% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0.25)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',0.25)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',0.25)

%% 0% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',0)
% RA test on Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Exit',0)
% RA test on Entry and Exit
CountryMatrixNoVOC('Quarantine_BDVeritor_Entry_Exit',0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wells et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',1)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',1)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',1)

%% 75% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',0.75)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',0.75)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',0.75)

%% 50% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',0.50)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',0.50)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',0.50)

%% 25% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',0.25)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',0.25)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',0.25)

%% 0% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('NatComm-Quarantine_RTPCR_Exit',0)
% RA test on Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Exit',0)
% RA test on Entry and Exit
CountryMatrixNoVOC('NatComm-Quarantine_BDVeritor_Entry_Exit',0)
