function [VOCB117,VOCP1,VOC501YV2] = VOCDataReturn(CountryA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B117 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\VOC_Country_B117.xlsx'],'Range','A3:D110');

tA=strcmp(CountryA,T.Country);
VOCB117=T.x_VUI202012_01GR_501Y_V1_B_1_1_7_InPast4Weeks_1(tA)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P1 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\VOC_Country_P1.xlsx'],'Range','A3:D33');


tA=strcmp(CountryA,T.Country);

VOCP1=T.x_GR_501Y_V3_P_1_InPast4Weeks_1(tA)./100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 501YV2 VOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
T=readtable([pwd '\Country_Data\VOC_Country_501YV2.xlsx'],'Range','A3:D68');

tA=strcmp(CountryA,T.Country);

VOC501YV2=T.x_GH_501Y_V2_B_1_351_InPast4Weeks_1(tA)./100;


end

