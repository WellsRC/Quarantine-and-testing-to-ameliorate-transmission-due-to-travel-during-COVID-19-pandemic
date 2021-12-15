clear;

%December 6 is week 50
DateRef=datenum('December 6, 2020');
Y=2020;
W=50;

    T=readtable([pwd '\ECDC-VaccineTracker_Median cumulative uptake (%) of at least one vaccine dose by age group in EU_EEA countries as of 2021-12-10\COVID-19_export_linechart.csv']);
    T=flip(T);
    test=T.ReportingWeek;
    
    for jj=1:length(test)
        temp=test{jj};
        Wd=str2num(temp(end-1:end));
        Yd=str2num(temp(1:4));
        test{jj}=datestr(DateRef+7.*(Wd+53.*(Yd-Y)-W),'mmmm dd, yyyy');
    end
    T.ReportingWeek=test;
    
    Date_One=T;
writetable(Date_One,'VaccineDoses_Age_Europe_At_least_one.csv');

 T=readtable([pwd '\ECDC-VaccineTracker_Median cumulative uptake (%) of full vaccination by age group in EU_EEA countries as of 2021-12-10\COVID-19_export_linechart.csv']);
    T=flip(T);
    test=T.ReportingWeek;
    
    for jj=1:length(test)
        temp=test{jj};
        Wd=str2num(temp(end-1:end));
        Yd=str2num(temp(1:4));
        test{jj}=datestr(DateRef+7.*(Wd+53.*(Yd-Y)-W),'mmmm dd, yyyy');
    end
    T.ReportingWeek=test;
    
    Date_Full=T;

writetable(Date_Full,'VaccineDoses_Age_Europe_Full.csv');