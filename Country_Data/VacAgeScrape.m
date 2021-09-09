clear;
CC={'Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark','Estonia','Finland','France','Greece','Hungary','Republic of Ireland','Italy','Latvia','Lithuania','Luxembourg','Malta','Norway','Poland','Portugal','Romania','Slovakia','Slovenia','Spain','Sweden'};

for ii=1:length(CC)
    T=readtable([pwd '\ECDC-VaccineTracker_Cumulative number of first doses administered by age group in ' CC{ii} ' as of 2021-09-02\COVID-19_export_barchart.csv']);
    T.Country=repmat({CC{ii}},length(T.ReportingWeek),1);
    T.Dose=repmat({'First'},length(T.ReportingWeek),1);
    if(ii==1)        
        TV=T;
    else
        TV=[TV; T];
    end
    
end

for ii=1:length(CC)
    T=readtable([pwd '\ECDC-VaccineTracker_Cumulative number of full vaccinations administered by age group in  ' CC{ii} ' as of 2021-09-02\COVID-19_export_barchart.csv']);
    T.Country=repmat({CC{ii}},length(T.ReportingWeek),1);
    T.Dose=repmat({'Full'},length(T.ReportingWeek),1);
    
    TV=[TV; T];
    
end

writetable(TV,'VaccineDoses_Age_Country.csv');

% Edited file name such that it reads the start of the reporting week