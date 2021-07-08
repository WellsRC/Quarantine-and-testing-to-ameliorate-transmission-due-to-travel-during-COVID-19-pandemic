CountryM={'Austria';'Belgium';'Bulgaria';'Cyprus';'Czech Republic';'Denmark';'Estonia';'Finland';'France';'Germany';'Greece';'Hungary';'Republic of Ireland';'Italy';'Lithuania';'Luxembourg';'Malta';'Netherlands';'Norway';'Poland';'Portugal';'Romania';'Russia';'Serbia';'Slovakia';'Slovenia';'Spain';'Sweden';'Switzerland';'Turkey';'United Kingdom'};
NM=length(CountryM);
UR=zeros(NM,1);
for ii=1:NM
    [UR(ii)] = UnderReportingIHME(CountryM(ii),datenum('June 28, 2021'));
end
save('Under-Reporting-June_28_2021.mat');