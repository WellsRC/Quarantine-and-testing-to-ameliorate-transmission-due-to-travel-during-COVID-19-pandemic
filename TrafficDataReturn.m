function [prevA,prevB,vacupA,vacupB,recA,recB,NA,NB,cA,cB,proHA,proHB,DemoA,DemoB] = TrafficDataReturn(StatusA,StatusB,vacA,vacB,recA,recB,NA,NB,pA)

Demo=[0.210888011 0.11534318 0.141457647 0.139470807 0.140165756 0.121345549 0.078708003 0.052621047];
h=[0.1 0.5 1.1 1.4 2.9 5.8 9.3 26.2]./100;
epsT=[50 50 50 48 48 48 47 47]./100;
epsH=[50 50 50 74 74 74 57 57]./100;


DemoA=Demo;
DemoB=Demo;

recA=recA.*ones(size(pA));
recB=recB.*ones(size(pA));

cA=(StatusA./100000)/14;
cB=(StatusB./100000)/14;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Set-up first part of vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
agep=flip(DemoA);
ccvac=cumsum(agep);
ccvac=flip([0 ccvac(1:end-1)]);
vacupA=zeros(size(epsT));
tempHA=zeros(size(epsT));
for aa=1:length(recA)
    pvac=min(max(vacA-ccvac(aa),0)./DemoA(aa),1);

    vacupA(aa)=epsT(aa).*pvac; % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
    tempHA(aa)=-(pvac)+((1-epsT(aa)).*(1-epsH(aa)).*pvac); % Subtract prevalence later prevalence as we need to weigh later by immunity
end

agep=flip(DemoB);
ccvac=cumsum(agep);
ccvac=flip([0 ccvac(1:end-1)]);
vacupB=zeros(size(epsT));
tempHB=zeros(size(epsT));
for aa=1:length(recB)
    pvac=min(max(vacB-ccvac(aa),0)./DemoB(aa),1);

    vacupB(aa)=epsT(aa).*pvac; % Do not want to scale by prevalence or seroprevlance as we need to weigh later by immunity
    tempHB(aa)=-(pvac)+((1-epsT(aa)).*(1-epsH(aa)).*pvac); % Subtract prevalence later prevalence as we need to weigh later by immunity
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Set-up prevalence and remaining vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
PopAIM=1-vacupA.*(1-recA)-recA;
Symptomatic=8.29.*cA.*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM));
Asymptomatic=28.29.*cA.*(DemoA.*PopAIM)./(sum(DemoA.*PopAIM));

prevA=((1-pA).*Symptomatic+pA.*Asymptomatic); %Do not need to divide to obtain prevalence as we adjusted fraction incidence above to be cases per person

vacupA=vacupA.*(1-prevA-recA); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

PopAS=1-vacupA-prevA-recA;
                
proHA=1+(tempHA).*(1-prevA-recA)-recA-prevA; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHA=h.*proHA./PopAS;


PopAIM=1-vacupB.*(1-recB)-recB;
Symptomatic=8.29.*cB.*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM));
Asymptomatic=28.29.*cB.*(DemoB.*PopAIM)./(sum(DemoB.*PopAIM));

prevB=((1-pA).*Symptomatic+pA.*Asymptomatic); %Do not need to divide to obtain prevalence as we adjusted fraction incidence above to be cases per person

vacupB=vacupB.*(1-prevB-recB); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER

PopAS=1-vacupB-prevB-recB;
                
proHB=1+(tempHB).*(1-prevB-recB)-recB-prevB; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
proHB=h.*proHB./PopAS;
end

