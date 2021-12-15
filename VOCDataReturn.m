function [VOCOmincron,VOCDelta] = VOCDataReturn(CountryA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Omicron
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\countrySubmissionCount-Omicron.csv']);


tA=strcmp(CountryA,T.Country);

VOCOmincron=T.Percentage(tA)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delta VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\countrySubmissionCount-Delta.csv']);

tA=strcmp(CountryA,T.Country);

VOCDelta=T.Percentage(tA)./100;


end

