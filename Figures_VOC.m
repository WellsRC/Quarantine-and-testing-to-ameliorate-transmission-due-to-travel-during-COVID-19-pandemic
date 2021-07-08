close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 100% Adherence
% RT-PCR on Exit
CountryMatrixVOC('Quarantine_RTPCR_Exit',1,1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Summary for main text
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
CountryInlcude={'United Kingdom','Germany','Belgium','Denmark','Italy','Netherlands','Poland','Norway','Slovakia','Czech Republic','France'};

CountryMatrixVOC_summary('Quarantine_RTPCR_Exit',CountryInlcude,1,1)