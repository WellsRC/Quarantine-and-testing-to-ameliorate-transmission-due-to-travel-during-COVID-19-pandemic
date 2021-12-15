clear;
%https://www.england.nhs.uk/statistics/statistical-work-areas/covid-19-vaccinations/covid-19-vaccinations-archive/
% Demographics for UK locations
%https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland
%0-4; 5-9; ....85-89; 90+
England=[3239447,3539458,3435579,3115871,3472522,3771493,3824652,3738209,3476303,3638639,3875351,3761782,3196813,2784300,2814128,2009992,1449189,885343,521067];
Wales=[161341,182178,184437,173821,206557,208114,196672,185873,172930,192465,216970,222222,197416,179955,181886,131023,90566,54400,30760];
Scotland=[263806,297903,298081,282120,341755,377204,374069,355666,324366,349924,393113,399344,352569,300433,285830,198210,143296,84562,43749];
NorthernIreland=[117736,127874,127017,111868,112324,119819,126582,124352,117944,122939,130583,127503,109020,90693,82062,64534,43172,25561,13927];

%
%age=[0-19 20-29 30-39 40-49 50-59 60-69 70-79 80-100];


% Age 16 -24			Age 25 - 34			Age 35 - 49			Age 50 - 59			Age 60 - 64			Age 65 - 69			Age 70 - 74			Age 75 - 79			Age 80+		
T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES England','Range','A6:AY52');
V1England=[(sum(England(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio))+England(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio)./(sum(England(1:4)))  (England(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio+England(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1)./sum(England(5:6)) (England(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1+England(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(England(7:8)) (England(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2+England(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(England(9:10)) (England(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+England(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3)./sum(England(11:12)) (England(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4+England(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_5+England(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_6+England(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7+sum(England(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7)./sum(England(13:19))]./100;

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Wales','Range','A9:AY55');
V1Wales=[(sum(Wales(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio))+Wales(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio)./(sum(Wales(1:4)))  (Wales(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio+Wales(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1)./sum(Wales(5:6)) (Wales(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1+Wales(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(Wales(7:8)) (Wales(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2+Wales(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(Wales(9:10)) (Wales(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+Wales(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3)./sum(Wales(11:12)) (Wales(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4+Wales(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_5+Wales(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_6+Wales(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7+sum(Wales(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7)./sum(Wales(13:19))]./100;

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Scotland','Range','A9:AY55');
V1Scotland=[(sum(Scotland(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio))+Scotland(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio)./(sum(Scotland(1:4)))  (Scotland(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio+Scotland(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1)./sum(Scotland(5:6)) (Scotland(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1+Scotland(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(Scotland(7:8)) (Scotland(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2+Scotland(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(Scotland(9:10)) (Scotland(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+Scotland(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3)./sum(Scotland(11:12)) (Scotland(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4+Scotland(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_5+Scotland(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_6+Scotland(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7+sum(Scotland(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_7)./sum(Scotland(13:19))]./100;

%Age 16 -24			Age 25 - 34			Age 35 - 49			Age 50 - 69			Age 70+		

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Northern Ireland','Range','A9:AY55');
V1NorthernIreland=[(sum(NorthernIreland(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio))+NorthernIreland(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio)./(sum(NorthernIreland(1:4)))  (NorthernIreland(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio+NorthernIreland(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1)./sum(NorthernIreland(5:6)) (NorthernIreland(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_1+NorthernIreland(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(NorthernIreland(7:8)) (NorthernIreland(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2+NorthernIreland(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_2)./sum(NorthernIreland(9:10)) (NorthernIreland(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+NorthernIreland(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3)./sum(NorthernIreland(11:12)) (NorthernIreland(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+NorthernIreland(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_3+NorthernIreland(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4+NorthernIreland(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4+sum(NorthernIreland(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived1OrMoreVaccinatio_4)./sum(NorthernIreland(13:19))]./100;


% Age 16 -24			Age 25 - 34			Age 35 - 49			Age 50 - 59			Age 60 - 64			Age 65 - 69			Age 70 - 74			Age 75 - 79			Age 80+		
T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES England','Range','A6:AY52');
V2England=[(sum(England(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio))+England(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio)./(sum(England(1:4)))  (England(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio+England(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1)./sum(England(5:6)) (England(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1+England(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(England(7:8)) (England(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2+England(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(England(9:10)) (England(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+England(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3)./sum(England(11:12)) (England(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4+England(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_5+England(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_6+England(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7+sum(England(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7)./sum(England(13:19))]./100;

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Wales','Range','A9:AY55');
V2Wales=[(sum(Wales(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio))+Wales(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio)./(sum(Wales(1:4)))  (Wales(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio+Wales(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1)./sum(Wales(5:6)) (Wales(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1+Wales(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(Wales(7:8)) (Wales(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2+Wales(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(Wales(9:10)) (Wales(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+Wales(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3)./sum(Wales(11:12)) (Wales(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4+Wales(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_5+Wales(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_6+Wales(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7+sum(Wales(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7)./sum(Wales(13:19))]./100;

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Scotland','Range','A9:AY55');
V2Scotland=[(sum(Scotland(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio))+Scotland(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio)./(sum(Scotland(1:4)))  (Scotland(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio+Scotland(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1)./sum(Scotland(5:6)) (Scotland(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1+Scotland(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(Scotland(7:8)) (Scotland(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2+Scotland(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(Scotland(9:10)) (Scotland(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+Scotland(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3)./sum(Scotland(11:12)) (Scotland(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4+Scotland(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_5+Scotland(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_6+Scotland(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7+sum(Scotland(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_7)./sum(Scotland(13:19))]./100;

%Age 16 -24			Age 25 - 34			Age 35 - 49			Age 50 - 69			Age 70+		

T=readtable('20211208covid19infectionsurveydatasets_UK.xlsx','Sheet','VACCINES Northern Ireland','Range','A9:AY55');
V2NorthernIreland=[(sum(NorthernIreland(1:3)).*zeros(size(T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio))+NorthernIreland(4).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio)./(sum(NorthernIreland(1:4)))  (NorthernIreland(5).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio+NorthernIreland(6).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1)./sum(NorthernIreland(5:6)) (NorthernIreland(7).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_1+NorthernIreland(8).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(NorthernIreland(7:8)) (NorthernIreland(9).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2+NorthernIreland(10).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_2)./sum(NorthernIreland(9:10)) (NorthernIreland(11).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+NorthernIreland(12).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3)./sum(NorthernIreland(11:12)) (NorthernIreland(13).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+NorthernIreland(14).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_3+NorthernIreland(15).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4+NorthernIreland(16).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4+sum(NorthernIreland(17:19)).*T.Modelled_OfAdultsWhoHaveReportedToHaveReceived2OrMoreVaccinatio_4)./sum(NorthernIreland(13:19))]./100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Pad top with zeros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% V2England=[zeros(9,length(V2England(1,:))); V2England];
% V2Wales=[zeros(9,length(V2Wales(1,:))); V2Wales];
% V2Scotland=[zeros(9,length(V2Scotland(1,:))); V2Scotland];
% V2NorthernIreland=[zeros(9,length(V2NorthernIreland(1,:))); V2NorthernIreland];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Weight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WE=[ sum(England(1:4)) sum(England(5:6)) sum(England(7:8)) sum(England(9:10)) sum(England(11:12)) sum(England(13:19))];
WW=[ sum(Wales(1:4)) sum(Wales(5:6)) sum(Wales(7:8)) sum(Wales(9:10)) sum(Wales(11:12)) sum(Wales(13:19))];
WS=[ sum(Scotland(1:4)) sum(Scotland(5:6)) sum(Scotland(7:8)) sum(Scotland(9:10)) sum(Scotland(11:12)) sum(Scotland(13:19))];
WI=[ sum(NorthernIreland(1:4)) sum(NorthernIreland(5:6)) sum(NorthernIreland(7:8)) sum(NorthernIreland(9:10)) sum(NorthernIreland(11:12)) sum(NorthernIreland(13:19))];

N=WE+WW+WS+WI;

WE=repmat(WE./N,length(V2England(:,1)),1);
WW=repmat(WW./N,length(V2Wales(:,1)),1);
WS=repmat(WS./N,length(V2Scotland(:,1)),1);
WI=repmat(WI./N,length(V2NorthernIreland(:,1)),1);


V1=WE.*V1England+WW.*V1Wales+WS.*V1Scotland+WI.*V1NorthernIreland;
V2=WE.*V2England+WW.*V2Wales+WS.*V2Scotland+WI.*V2NorthernIreland;
VTot=sum(V1.*repmat(N,length(V1(:,1)),1),2)./sum(N);
DateWeek=[datenum('December 21, 2020'):7:datenum('November 1, 2021')]';


save('20211208covid19infectionsurveydatasets_UK.mat','DateWeek','V1','V2','VTot');