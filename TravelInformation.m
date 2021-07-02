function [TravelDepart,DoS,pgeo] = TravelInformation(CountryLeaving,CountryEntering)
if(strcmp(CountryEntering,'United Kingdom'))
    % Country A data (i.e. entering the UK)
    T=readtable([pwd '\Country_Data\Travel_Into_UK.xlsx'],'Sheet','2.10','Range','A13:M77');
    T=T(:,[1 13]);
    tA=strcmp(CountryLeaving,T.Var1);
    TravelDepart=1000*T.Var13(tA)./365; % Divide by 365 since the number is annual
    
    T=readtable([pwd '\Country_Data\Travel_Into_UK.xlsx'],'Sheet','2.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tA=strcmp(CountryLeaving,T.Var1);
    DoS=T.Var25(tA);
    x=[1:30];
    if(~isempty(DoS))
        pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
    else
        pgeo=[];
    end
elseif(strcmp(CountryLeaving,'United Kingdom'))
    % Country B data (i.e. leaving the UK for country A)
    T=readtable([pwd '\Country_Data\Travel_Leaving_UK.xlsx'],'Sheet','3.10','Range','A13:M77');
    T=T(:,[1 13]);
    tB=strcmp(CountryEntering,T.Var1);
    TravelDepart=1000*T.Var13(tB)./365; % Divide by 365 since the number is annual
    
    T=readtable([pwd '\Country_Data\Travel_Leaving_UK.xlsx'],'Sheet','3.12','Range','A10:Y74');
    T=T(:,[1 end]);
    tB=strcmp(CountryEntering,T.Var1);
    DoS=T.Var25(tB);
    x=[1:30];
    if(~isempty(DoS))
        pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
    else
        pgeo=[];
    end
else
     if(strcmp(CountryEntering,'Italy'))
        % Country B entering Italy
        T=readtable([pwd '\Country_Data\Italy_Tourism.xlsx'],'Range','A9:N70');
        tB=strcmp(CountryLeaving,T.CountryOfResidenceOfGuests);
        TravelDepart=T.arrivals_3(tB)./365; % Divide by 365 since the number is annual
        DoS=T.nightsSpent_3(tB)./T.arrivals_3(tB);
        x=[1:30];
        if(~isempty(DoS))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
        end
    elseif(strcmp(CountryEntering,'Turkey'))
        % Country B entering Turkey
        DoS=5.7; % There is only a single number and no specified by individual country; assumes the average length of stay in a hotel
        x=[1:30];
        pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        T=readtable([pwd '\Country_Data\Destination_Turkey.xls'],'Range','A4:V123');
        tB=strcmp(CountryLeaving,T.Milliyet_Nationality);
        TravelDepart=(37048558/53269861).*T.x2019(tB)./365; % Divide by 365 since the number is annual and scale by 0.695 to approximate the number of arrivals in all forms of paid accomidation 
    
    elseif(strcmp(CountryEntering,'Greece'))
        % Country B entering Greece
        T=readtable([pwd '\Country_Data\Greece_Arrivals.xlsx'],'Range','A5:G56');
        tB=strcmp(CountryLeaving,T.COUNTRYOFRESIDENCE);
        TravelDepart=T.Total(tB)./365; % Divide by 365 since the number is annual
        DoS=T.Total_Bed(tB)./T.Total(tB);
        x=[1:30];
        if(~isempty(DoS))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
        end     
    elseif(strcmp(CountryEntering,'Norway'))
        % Country B entering Norway
        DoS=4.253182605; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        T=readtable([pwd '\Country_Data\Norway_GuestNights.xlsx'],'Range','A4:N75');
        tB=strcmp(CountryLeaving,T.Var1);
        TravelDepart=(T.Y2019(tB)./365)./DoS; % Divide by 365 since the number is annual   (Divide by DoS as it is guest nights)
    elseif(strcmp(CountryEntering,'Russia'))
        DoS=283191006./32866265; % There is only a single number and no specified by individual country
        x=[1:30];
        pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        T=readtable([pwd '\Country_Data\Russia Inbound Travel Data.xls'],'Range','A1:B204','Sheet','English');
        tB=strcmp(CountryLeaving,T.Country);
        TravelDepart=(T.EntryOfForeignNationalsToRussia(tB)./365); % Divide by 365 since the number is annual   
    elseif(strcmp(CountryEntering,'Luxembourg'))
        T=readtable([pwd '\Country_Data\Luxembourg_Travel.xlsx'],'Range','A1:C52');
        tB=strcmp(CountryLeaving,T.Country);
        DoS=T.AvgNight(tB);
        TravelDepart=T.Travel(tB)./365;x=[1:30];
        if((~isempty(DoS))&&(~isnan(DoS)))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
        end
     elseif(strcmp(CountryEntering,'Romania'))
        T=readtable([pwd '\Country_Data\Destination_Romania-2019.xlsx'],'Range','A7:B52');
        tB=strcmp(CountryLeaving,T.Country);
        TravelDepart=T.x2019(tB)./365;
        x=[1:30];        
        DoS=5266964/2671708; % Based on the pdf for the totals of turi?ti str?ini on pg 3 and pg 4         
        if((~isempty(DoS))&&(~isnan(DoS)))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
        end
     elseif(strcmp(CountryEntering,'Denmark'))
         DoS=28857842/5532870; % Based on the World Outside Denmark (We only have inbound travel data for the world outside denmark)
         T=readtable([pwd '\Country_Data\Denmark Inbound Bednight Data.xlsx'],'Range','D3:E56'); 
         tB=strcmp(CountryLeaving,T.Country);
         TravelDepart=(T.x2019(tB)./365)./DoS; % Need to divide by duration of stay as we do not have avialble information for number of travellers
         x=[1:30];     
         if((~isempty(DoS))&&(~isnan(DoS)))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
         end
    elseif(strcmp(CountryEntering,'Sweden'))
         DoS=7.30155898474969; % Based on the avergage duration of stay for the UK (as only info I could find)
         T=readtable([pwd '\Country_Data\Sweden Inbound Bednight Data.xlsx'],'Range','A3:D258'); 
         tB=strcmp(CountryLeaving,T.Country);
         TravelDepart=(T.x2019(tB)./365)./DoS; % Need to divide by duration of stay as we do not have avialble information for number of travellers
         x=[1:30];     
         if((~isempty(DoS))&&(~isnan(DoS)))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
         end
    elseif(exist([pwd '\Country_Data\Destination_' CountryEntering{1} '-2019.xlsx'],'file'))
        % Country B entering Country A
       T=readtable([pwd '\Country_Data\Destination_' CountryEntering{1} '-2019.xlsx'],'Range','A7:J100');
       tB=strcmp(CountryLeaving,T.Var1);
        TravelDepart=T.x2019(tB)./365; % Divide by 365 since the number is annual
        DoS=T.x2019_1(tB)./T.x2019(tB); % Bed days divided by total travellers
        x=[1:30];
        if((~isempty(DoS))&&(~isnan(DoS)))
            pgeo=fmincon(@(z)(sum(x.*((z.*(1-z).^(x-1))./(1-(1-z)^30)))-DoS).^2,1./DoS,[],[],[],[],0,1);
        else
            pgeo=[];
        end       
   else
       TravelDepart=[];
       DoS=[];
       pgeo=[];
    end
end
end

