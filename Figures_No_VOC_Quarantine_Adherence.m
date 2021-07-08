close all;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,1)
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.75)
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.5)
CountryMatrixNoVOC('Quarantine_RTPCR_Exit',1,0.25)