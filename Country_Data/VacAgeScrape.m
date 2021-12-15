clear;
CC={'Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark','Estonia','Finland','France','Greece','Hungary','Republic of Ireland','Italy','Latvia','Lithuania','Luxembourg','Malta','Norway','Poland','Portugal','Romania','Slovakia','Slovenia','Spain','Sweden'};
% Unzip all the files
% for ii=1:length(CC)
%     unzip([pwd '\ECDC-VaccineTracker_Cumulative number of first doses administered by age group in ' CC{ii} ' as of 2021-12-10'],[pwd '\ECDC-VaccineTracker_Cumulative number of first doses administered by age group in ' CC{ii} ' as of 2021-12-10']);
% end
% 
% for ii=1:length(CC)
%     unzip([pwd '\ECDC-VaccineTracker_Cumulative number of full vaccinations administered by age group in  ' CC{ii} ' as of 2021-12-10'],[pwd '\ECDC-VaccineTracker_Cumulative number of full vaccinations administered by age group in  ' CC{ii} ' as of 2021-12-10'])   
% end

% Edited file name such that it reads the start of the reporting week

%December 6 is week 50
DateRef=datenum('December 6, 2020');
Y=2020;
W=50;
for ii=1:length(CC)
    T=readtable([pwd '\ECDC-VaccineTracker_Cumulative number of first doses administered by age group in ' CC{ii} ' as of 2021-12-10\COVID-19_export_barchart.csv']);
    T.Country=repmat({CC{ii}},length(T.ReportingWeek),1);
    T.Dose=repmat({'First'},length(T.ReportingWeek),1);
    T.ReportingWeek=flip(T.ReportingWeek); % the dates have been flipped wrt to the reporting week
    test=T.ReportingWeek;
    
    for jj=1:length(test)
        temp=test{jj};
        Wd=str2num(temp(end-1:end));
        Yd=str2num(temp(1:4));
        test{jj}=datestr(DateRef+7.*(Wd+53.*(Yd-Y)-W),'mmmm dd, yyyy');
    end
    T.ReportingWeek=test;
    if(ii==1)        
        TV=T;
    else
        TV=[TV; T];
    end
    
end

for ii=1:length(CC)
    T=readtable([pwd '\ECDC-VaccineTracker_Cumulative number of full vaccinations administered by age group in  ' CC{ii} ' as of 2021-12-10\COVID-19_export_barchart.csv']);
    T.Country=repmat({CC{ii}},length(T.ReportingWeek),1);
    T.Dose=repmat({'Full'},length(T.ReportingWeek),1);
    
    T.ReportingWeek=flip(T.ReportingWeek); % the dates have been flipped wrt to the reporting week
    test=T.ReportingWeek;
    
    for jj=1:length(test)
        temp=test{jj};
        Wd=str2num(temp(end-1:end));
        Yd=str2num(temp(1:4));
        test{jj}=datestr(DateRef+7.*(Wd+53.*(Yd-Y)-W),'mmmm dd, yyyy');
    end
    T.ReportingWeek=test;
    
    TV=[TV; T];
    
end

writetable(TV,'VaccineDoses_Age_Country.csv');