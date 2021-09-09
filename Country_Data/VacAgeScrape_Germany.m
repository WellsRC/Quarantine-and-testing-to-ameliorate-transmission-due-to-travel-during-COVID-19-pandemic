clear;

    T=readtable([pwd '\Germany_Vaccination.xlsx']);
    TDate=datenum(T.VaccinationDate);
    Age=unique(T.AgeGroup);
    Date=unique(TDate);
    
    VFirst=zeros(length(Date),length(Age));
    VTwo=zeros(length(Date),length(Age));
    VThree=zeros(length(Date),length(Age));
    
    for jj=1:length(Age)
        tf=strcmp(Age{jj},T.AgeGroup);
        for kk=1:length(Date)            
            td=TDate==Date(kk);
            tfirst=T.VaccinationProtection==1;
            VFirst(kk,jj)=sum(T.number(tfirst&td&tf));
            ttwo=T.VaccinationProtection==2;
            VTwo(kk,jj)=sum(T.number(ttwo&td&tf));
            
            tthree=T.VaccinationProtection==3;
            VThree(kk,jj)=sum(T.number(tthree&td&tf));
        end
    end
    
    VFirstC=cumsum(VFirst,1);
    VTwoC=cumsum(VTwo,1);
    VThreeC=cumsum(VThree,1);
    
    save('Germany_Age_Vaccination.mat','Date','Age','VFirst','VFirstC','VTwo','VTwoC','VThree','VThreeC');