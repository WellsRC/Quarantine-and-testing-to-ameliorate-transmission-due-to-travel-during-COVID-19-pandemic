function [Demo] = AgeDemoCounty(Country)
% T=readtable([pwd '\Country_Data\Age_Population.csv']);
load('Country_Age_Population.mat');

% Note: The csv file is population per thousand. This scale is not an issue
% since we are normalizing to obtain the proportion of the population in
% the age group. There is a separate file that provides the population size
tA=strcmp(Country,T.Region_Subregion_CountryOrArea_);

%age=[19 29 39 49 59 69 79 100];
Test=[T.age0(tA)+T.age5(tA)+T.age10(tA)+T.age15(tA) T.age20(tA)+T.age25(tA) T.age30(tA)+T.age35(tA) T.age40(tA)+T.age45(tA) T.age50(tA)+T.age55(tA) T.age60(tA)+T.age65(tA) T.age70(tA)+T.age75(tA) T.age80(tA)+T.age85(tA)+T.age90(tA)+T.age95(tA)+T.age100(tA)];
if(~isempty(Test))
    Demo=Test./sum(Test);
else
    Demo=[];
end

end

