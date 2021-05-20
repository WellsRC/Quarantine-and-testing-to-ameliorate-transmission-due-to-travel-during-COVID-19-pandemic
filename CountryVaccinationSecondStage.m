function [vacup,proH,vacM,proHM] = CountryVaccinationSecondStage(Demo,vacup,tempH,vacM,tempHM,rec,prev,prevM)

h = HospitalRate;

% Dtermine the vaccine uptake based on the estimated prev
vacup=vacup.*(1-prev-rec); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER
% Detemrine the proportion of the population susceptile to infection
PopAS=1-vacup-prev-rec;

% proportino of the population suscptible to hospitalization
proH=1+(tempH).*(1-prev-rec)-rec-prev; % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
% proportiog of popualtino suscpetible to hospitalization
proH=h.*proH./PopAS;


proHM=zeros(length(vacM(:,1)),length(Demo));

for vvv=1:length(vacM(:,1))
    % Need to correct the vaccine uptake based on prev
    vacM(vvv,:)=vacM(vvv,:).*(1-prevM(vvv,:)-rec); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER
    % Detemrine the proportion of the population susceptile to infection
    PopAS=1-vacM(vvv,:)-prevM(vvv,:)-rec;
    % proportino of the population suscptible to hospitalization          
    proHM(vvv,:)=1+(tempHM(vvv,:)).*(1-prevM(vvv,:)-rec)-rec-prevM(vvv,:); % NEED TO SCALE VAC UPTAKE HERE TO NOT COUNT THOSE ALREADY VACCINATED OR THAT WOULD BE INFECTED. THIS WAS NOT DONE EARLIER. Then need to remove recovered and those already infected
    % proportiog of popualtino suscpetible to hospitalization
    proHM(vvv,:)=h.*proHM(vvv,:)./PopAS;
end

end

