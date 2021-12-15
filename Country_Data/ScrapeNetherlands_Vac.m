clear;
% https://www.rivm.nl/en/covid-19-vaccination/figures-vaccination-programme
Date=[datenum('January 4,2021'):7:datenum('November 29 ,2021')]';
T=readtable('cumulative-turnout-for-at-least-one-covid-19-vaccination-by-birth-year-and-week-Netherlands.csv');
Age={[num2str(2021-2009) '-' num2str(2021-2004)],[num2str(2021-2003) '-' num2str(2021-1996)],[num2str(2021-1995) '-' num2str(2021-1991)],[num2str(2021-1990) '-' num2str(2021-1986)],[num2str(2021-1985) '-' num2str(2021-1981)],[num2str(2021-1980) '-' num2str(2021-1976)],[num2str(2021-1975) '-' num2str(2021-1971)]  ,[num2str(2021-1970) '-' num2str(2021-1966)],[num2str(2021-1965) '-' num2str(2021-1961)],[num2str(2021-1960) '-' num2str(2021-1956)],[num2str(2021-1955) '-' num2str(2021-1951)],[num2str(2021-1950) '-' num2str(2021-1946)],[num2str(2021-1945) '-' num2str(2021-1941)],[num2str(2021-1940) '-' num2str(2021-1936)],[num2str(2021-1935) '-' num2str(2021-1931)],['Over ' num2str(2021-1931)]};

V1temp=table2array(T(:,2:17))./100;

T=readtable('cumulative-vaccination-coverage-for-full-covid-19-vaccination-by-birth-year-and-week-Netherlands.csv');


V2temp=table2array(T(:,2:17))./100;

% Need to adjust based on the age demographics of model
load('Country_Age_Population.mat');

% Note: The csv file is population per thousand. This scale is not an issue
% since we are normalizing to obtain the proportion of the population in
% the age group. There is a separate file that provides the population size
tA=strcmp('Netherlands',T.Region_Subregion_CountryOrArea_);

Test=[T.age0(tA)+T.age5(tA)+T.age10(tA)+T.age15(tA) T.age20(tA)+T.age25(tA) T.age30(tA)+T.age35(tA) T.age40(tA)+T.age45(tA) T.age50(tA)+T.age55(tA) T.age60(tA)+T.age65(tA)+T.age70(tA)+T.age75(tA)+T.age80(tA)+T.age85(tA)+T.age90(tA)+T.age95(tA)+T.age100(tA)];

%age=[0-19 20-29 30-39 40-49 50-59 60-100];

V1=zeros(length(V1temp(:,1)),6);
V2=zeros(length(V1temp(:,1)),6);
% 0-19
V1(:,1)=V1temp(:,1).*(T.age10(tA)+T.age15(tA))./Test(1);
V2(:,1)=V2temp(:,1).*(T.age10(tA)+T.age15(tA))./Test(1);

% 20-29
V1(:,2)=(V1temp(:,2).* T.age20(tA)+V1temp(:,3).* T.age25(tA))./Test(2);
V2(:,2)=(V2temp(:,2).* T.age20(tA)+V2temp(:,3).* T.age25(tA))./Test(2);

% 30-39
V1(:,3)=(V1temp(:,4).* T.age30(tA)+V1temp(:,5).* T.age35(tA))./Test(3);
V2(:,3)=(V2temp(:,4).* T.age30(tA)+V2temp(:,5).* T.age35(tA))./Test(3);

% 40-49
V1(:,4)=(V1temp(:,6).* T.age40(tA)+V1temp(:,7).* T.age45(tA))./Test(4);
V2(:,4)=(V2temp(:,6).* T.age40(tA)+V2temp(:,7).* T.age45(tA))./Test(4);

% 50-59
V1(:,5)=(V1temp(:,8).* T.age50(tA)+V1temp(:,9).* T.age55(tA))./Test(5);
V2(:,5)=(V2temp(:,8).* T.age50(tA)+V2temp(:,9).* T.age55(tA))./Test(5);


% 60-100
V1(:,6)=(V1temp(:,10).* T.age60(tA)+V1temp(:,11).* T.age65(tA)+V1temp(:,12).* T.age70(tA)+V1temp(:,13).* T.age75(tA)+V1temp(:,14).* T.age80(tA)+V1temp(:,15).* T.age85(tA)+V1temp(:,16).* (T.age90(tA)+T.age95(tA)+T.age100(tA)))./Test(6);
V2(:,6)=(V2temp(:,10).* T.age60(tA)+V2temp(:,11).* T.age65(tA)+V2temp(:,12).* T.age70(tA)+V2temp(:,13).* T.age75(tA)+V2temp(:,14).* T.age80(tA)+V2temp(:,15).* T.age85(tA)+V2temp(:,16).* (T.age90(tA)+T.age95(tA)+T.age100(tA)))./Test(6);

save('Vaccination_Netherlands.mat','V1','V2','Age','Date');