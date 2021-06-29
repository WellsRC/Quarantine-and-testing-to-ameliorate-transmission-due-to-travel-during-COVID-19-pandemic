function [VOCBetaGH501YV2,VOCAlpha20201201GRY,VOCDeltaG478KV1] = VOCDataReturn(CountryA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B117 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\Beta GH501YV2 (B1351).csv']);

tA=strcmp(CountryA,T.Country);
VOCBetaGH501YV2=T.Percentage(tA)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P1 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\Alpha 20201201 GRY (B117).csv']);


tA=strcmp(CountryA,T.Country);

VOCAlpha20201201GRY=T.Percentage(tA)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 501YV2 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\Delta G478KV1 (B16172+AY1+AY2).csv']);

tA=strcmp(CountryA,T.Country);

VOCDeltaG478KV1=T.Percentage(tA)./100;


end

