function [vacupA,vacupB,proHA,proHB,prevA,prevB] = Vaccination_Hospital_Vary(Date,CountryA,CountryB,VA,VB,DemoA,DemoB,recA,recB,NA,NB,pA)

DateN=datenum(Date);
epsvT1=[32 32 32 30 30 30 26 26]./100;
epsvT2=[94 94 94 90 90 90 95 95]./100;

epsvH1=[33 33 33 70 70 70 57 57]./100;
epsvH2=[87 87 87 87 87 87 87 87]./100;

h=[0.1 0.5 1.1 1.4 2.9 5.8 9.3 26.2]./100;



load('Vaccination_Data.mat');
tA=strcmp(CountryA,T.location);
tB=strcmp(CountryB,T.location);

TDate=datenum(T.date);
fDate=DateN==TDate;


tp=~isnan(T.people_vaccinated)&~isnan(T.people_fully_vaccinated);

if(sum(tA&fDate&tp)>0)
    vacup1temp=(T.people_vaccinated(tA&fDate))./NA;
    vacup2temp=(T.people_fully_vaccinated(tA&fDate))./NA;
    lagV=vacup1temp-vacup2temp;
    VA2=max(VA-lagV,0);
    
    agep=flip(DemoA);
    ccvac=cumsum(agep);
    ccvac=flip([0 ccvac(1:end-1)]);
    vacupA=zeros(size(epsvT1));
    tempHA=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(VA-ccvac(aa),0)./DemoA(aa),1);
        pvac2=min(max(VA2-ccvac(aa),0)./DemoA(aa),1);
        pvac1=pvac1-pvac2;
        
        vacupA(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2).*(1-recA(aa)); % Do not want to scale by prevalence as we need to weigh later by immunity
        tempHA(aa)=1-(pvac1+pvac2).*(1-recA(aa))-recA(aa)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2).*(1-recA(aa)); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
elseif(sum(tA&tp)>0)
    PeopleVaccinated=pchip(TDate(tA&tp),T.people_vaccinated(tA&tp),DateN);
    PeopleFullyVaccinated=pchip(TDate(tA&tp),T.people_fully_vaccinated(tA&tp),DateN);       


    vacup1temp=(PeopleVaccinated)./NA;
    vacup2temp=(PeopleFullyVaccinated)./NA;
    lagV=vacup1temp-vacup2temp;
    VA2=max(VA-lagV,0);
    
    agep=flip(DemoA);
    ccvac=cumsum(agep);
    ccvac=flip([0 ccvac(1:end-1)]);
    vacupA=zeros(size(epsvT1));
    tempHA=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(VA-ccvac(aa),0)./DemoA(aa),1);
        pvac2=min(max(VA2-ccvac(aa),0)./DemoA(aa),1);
        pvac1=pvac1-pvac2;
        
        vacupA(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2).*(1-recA(aa)); % Do not want to scale by prevalence as we need to weigh later by immunity
        tempHA(aa)=1-(pvac1+pvac2).*(1-recA(aa))-recA(aa)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2).*(1-recA(aa)); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
else
    vacupA=[];
end

if(sum(tB&fDate&tp)>0)       
    vacup1temp=(T.people_vaccinated(tB&fDate))./NB;
    vacup2temp=(T.people_fully_vaccinated(tB&fDate))./NB;
    
    
    lagV=vacup1temp-vacup2temp;
    VB2=max(VB-lagV,0);
    
    
    agep=flip(DemoB);
    ccvac=cumsum(agep);
    ccvac=flip([0 ccvac(1:end-1)]);
    vacupB=zeros(size(epsvT1));
    tempHB=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(VB-ccvac(aa),0)./DemoB(aa),1);
        pvac2=min(max(VB2-ccvac(aa),0)./DemoB(aa),1);
        pvac1=pvac1-pvac2;
        
        vacupB(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2).*(1-recB(aa)); % Do not want to scale by prevalence as we need to weigh later by immunity
        tempHB(aa)=1-(pvac1+pvac2).*(1-recB(aa))-recB(aa)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2).*(1-recB(aa)); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
    
elseif(sum(tB&tp)>0)
    PeopleVaccinated=pchip(TDate(tB&tp),T.people_vaccinated(tB&tp),DateN);
    PeopleFullyVaccinated=pchip(TDate(tB&tp),T.people_fully_vaccinated(tB&tp),DateN);      


    vacup1temp=(PeopleVaccinated)./NB;
    vacup2temp=(PeopleFullyVaccinated)./NB;
    
    
    lagV=vacup1temp-vacup2temp;
    VB2=max(VB-lagV,0);
    
    
    agep=flip(DemoB);
    ccvac=cumsum(agep);
    ccvac=flip([0 ccvac(1:end-1)]);
    vacupB=zeros(size(epsvT1));
    tempHB=zeros(size(epsvT1));
    for aa=1:length(recA)
        pvac1=min(max(VB-ccvac(aa),0)./DemoB(aa),1);
        pvac2=min(max(VB2-ccvac(aa),0)./DemoB(aa),1);
        pvac1=pvac1-pvac2;
        
        vacupB(aa)=(epsvT1(aa).*pvac1+epsvT2(aa).*pvac2).*(1-recB(aa)); % Do not want to scale by prevalence as we need to weigh later by immunity
        tempHB(aa)=1-(pvac1+pvac2).*(1-recB(aa))-recB(aa)+((1-epsvT1(aa)).*(1-epsvH1(aa)).*pvac1+(1-epsvT2(aa)).*(1-epsvH2(aa)).*pvac2).*(1-recB(aa)); % Subtract prevalence later prevalence as we need to weigh later by immunity
    end
else
    vacupB=[];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Infections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Infected population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
DateN=datenum(Date);

load('IHME_Data.mat');
tA=strcmp(CountryA,T.location_name);
tB=strcmp(CountryB,T.location_name);

TDate=datenum(T.date);
fDate=DateN==TDate;
NA=T.total_pop(tA & fDate);
NB=T.total_pop(tB & fDate);

findx=find(tA&fDate);
PopAIM=1-vacupA-recA;
Symptomatic=sum(T.est_infections_mean((findx-7):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.est_infections_mean((findx-27):(findx))).*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM)); % Distribute the number of infections over this past time based on immunity level

prevA=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoA.*NA);

PopAS=1-vacupA-prevA-recA;
                
proHA=tempHA-prevA;
proHA=h.*proHA./PopAS;


findx=find(tB&fDate);
PopAIM=1-vacupB-recB;
Symptomatic=sum(T.est_infections_mean((findx-7):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level
Asymptomatic=sum(T.est_infections_mean((findx-27):(findx))).*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM)); % Distribute the number of infections over this past time based on immunity level

prevB=((1-pA).*Symptomatic+pA.*Asymptomatic)./(DemoB.*NB);

PopAS=1-vacupB-prevB-recB;
                
proHB=tempHB-prevB;
proHB=h.*proHB./PopAS;
end

