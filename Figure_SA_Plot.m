clear;
close all;
load('Country_Sensitivity_Analysis.mat')

XBin=[-15.5:15.5];
PInc=zeros(16,length(XBin)-1);
PDec=zeros(16,length(XBin)-1);
PNC=zeros(16,length(XBin)-1);

STDP=zeros(16,1);
for ii=1:16
    temp=squeeze(QM(ii,:,:));
    tempSA=squeeze(QMSA(ii,:,:));
    CC=squeeze(ChangeD(ii,:,:));
    dt=tempSA-temp;
    dt(tempSA==15 & temp<15 & temp>=0)=15;
    dt(temp==15 & tempSA<15 & tempSA>=0)=-15;
    STDP(ii)=std(dt(temp>=0 & tempSA>=0 & dt<15 & dt>-15));
    n=histogram(dt(temp>=0 & tempSA>=0 & CC>0),XBin);
    PInc(ii,:)=n.Values;
    n=histogram(dt(temp>=0 & tempSA>=0 & CC<0),XBin);
    PDec(ii,:)=n.Values;
end
close all;

[BB,STDPI]=sort(STDP);
STDPI=flip(STDPI);
Name={'Demographics: Destination','Demographics: Origin','Prevalence: Destination','Prevalence: Origin','Vaccine immunity: Destination','Vaccine immunity: Origin','Natural immunity: Destination','Natural immunity: Origin','Incidence per capita: Destination','Incidence per capita: Origin','Proportion travelling: Destination to Origin','Proportion travelling: Origin to Destination','Duration of stay in Origin','Duration of stay in Destination','Population size: Destination','Population size: Origin'};
for jj=1:6
figure('units','normalized','outerposition',[0.0 0.05 1 0.6]);
    for ii=(1+3*(jj-1)):(3*jj)
        if(ii<=16)
            subplot('Position',[0.05+0.33.*(ii-(1+3*(jj-1))),0.245,0.28,0.68]); 
            bar([-15:15],[PInc(STDPI(ii),:); PDec(STDPI(ii),:)],'Stacked','LineStyle','none');
            text(-7.4,450*0.98,['Standard deviation:' num2str(STDP(STDPI(ii)),'%4.3f')],'Fontsize',18);
            title(Name(STDPI(ii)),'Fontsize',14)
            fprintf([Name{STDPI(ii)} '\n']);
            NBCR=PInc(STDPI(ii),1)+PDec(STDPI(ii),1);
            NBCA=PInc(STDPI(ii),end)+PDec(STDPI(ii),end);
            NSum=sum(PInc(STDPI(ii),:))+sum(PDec(STDPI(ii),:));
            fprintf('Added border closure: %4.3f \n',100.*(NBCA./NSum));
            fprintf('Removal border closure: %4.3f \n \n',100.*(NBCR./NSum));
            
            xlim([-13.5 13.5]);
            ylim([0 450])
            box off;
            set(gca,'XTick',[-14:2:14],'Xminortick','on','Fontsize',18,'LineWidth',2','Tickdir','out');
            xtickangle(90);
            xlabel({'Change in quarantine specified','by destination country'},'Fontsize',20','Position',[0.097490571475886,-65.51345482593172]);
            ylabel('Count','Fontsize',20);
            if(jj*ii==1)
                legend('Increase in parameter','Decrease in parameter','Fontsize',16,'Position',[0.184523812920398,0.73303303593272,0.14075629912442,0.10540540250572])
            end
            text(-17.7944,371.14.*450/350,char(64+ii),'Fontsize',32','FontWeight','bold');
        end
    end
    print(gcf,['SA-' num2str(jj) '.png'],'-dpng','-r600');
end


    