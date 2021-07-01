function PlotQuarantineHospitalizationAbsReduction_NoTravel(Country,QT,CRS)
figure('units','normalized','outerposition',[0.0 0.025 0.9 1]);
subplot('Position',[0.115,0.15,0.84,0.7]);
NC=length(Country);
CSTATUS=[25 150 500 10^6]; % last entry is just to serve as an upper bound
XB=[-0.5 -0.2 -0.05 -0.025 -0.01 0.01 0.025 0.05 0.2 0.5];

Q=QT;
for jj=2:length(XB)
    Q(QT>=XB(jj-1) & QT<XB(jj))=jj-1;
end
% Specify the colormap for the table
cmap=flip([1,0,0;1,0.250000000000000,0.250000000000000;1,0.500000000000000,0.500000000000000;1,0.750000000000000,0.750000000000000;1,1,1;0.750000000000000,0.861764729022980,0.935294151306152;0.500000000000000,0.723529398441315,0.870588243007660;0.250000000000000,0.585294127464294,0.805882334709168;0,0.447058826684952,0.741176486015320]);
cmapt=[1,1,1;1,1,1;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;1,1,1;1,1,1];
for ii=NC:-1:1
    for jj=1:NC
       if((NC+1-ii)==jj)
          patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,'k');
       else
            if(Q(NC+1-ii,jj)>=0)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(floor(Q(NC+1-ii,jj)),:)); 
               text(jj,ii,[num2str(QT(NC+1-ii,jj) ,'%3.2f')],'Fontsize',13,'HorizontalAlignment','center','color',cmapt(floor(Q(NC+1-ii,jj)),:));
           else
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,[0.9 0.9 0.9]); 
           end
       end
    end
end
set(gca,'LineWidth',2,'tickdir','out','YTick',[1:NC],'Yminortick','off','YTickLabel',flip(Country),'Fontsize',18,'XAxisLocation','top','XTick',[1:NC],'Xminortick','off','XTickLabel',Country)
xlim([0.5 NC+0.5])
ylim([0.5 NC+0.5])
ylabel('Destination country','Fontsize',24)
xtickangle(45)
xlabel('Origin country','Fontsize',24,'Position',[15.499999999999998,36.71862518089725,0])
h=colorbar('southoutside');
colormap([cmap;0.65 0.65 0.65]);

xxx=linspace(0,1,11);
h.Ticks=[xxx(1:end-1) 0.005+mean(xxx(end-1:end))];%(xxx(2:end)+xxx(1:end-1))./2;
h.TickLabels={'-0.50','-0.20','-0.05','-0.025','-0.01','0.01','0.025','0.05','0.20','0.50','N/A'};


h.Position=[0.115,0.06,0.84,0.0255];
h.FontSize=16;

h.Label.String='Change in two-week hospitalization rate due to travel';
h.Label.FontSize=20;
h.Label.Position=[0.500000476837158,-0.970666584968567,0];


TempL=flip(linspace(0,0.7,NC+1));
dTT=TempL(1)-TempL(2);
TTX=[1:NC];
flast=1;
Stt={'Green','Amber','Red','Dark red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];
ColTx=[0 0 0; 0 0 0; 1 1 1; 1 1 1];

xx=[0.986957943925227,1.00;0.986957943925227,1.00;0.978780373831772,0.993780373831772;0.992799065420557,1.00];
for jj=1:4
    ff=find(CRS<=CSTATUS(jj));
    if(jj>1)
        gg=find(CRS<=CSTATUS(jj)& CRS>CSTATUS(jj-1));
    else
        gg=1;
    end
    if(~isempty(ff)&&~isempty(gg))
        annotation('rectangle',[0.115+0.84 0.15+TempL(ff(end))-dTT 0.0175 dTT+TempL(flast)-TempL(ff(end))],'Facecolor',ColT(jj,:));
        
        annotation('textarrow',xx(jj,:),[0.15+mean([TempL(flast) TempL(ff(end))])-dTT./2 0.15+mean([TempL(flast) TempL(ff(end))])-dTT./2],'String',Stt{jj},'HorizontalAlignment','center','VerticalAlignment','middle','Fontsize',18,'color',ColTx(jj,:),'HeadStyle', 'none', 'LineStyle', 'none','TextRotation',270)  
       
        if(ff(end)==length(TempL))
            flast=TTX(ff(end));
        else
            flast=TTX(ff(end))+1;
        end
    end
end

flast=1;
TempL=(linspace(0,0.84,NC+1));
dTT=TempL(2)-TempL(1);
TTX=[1:NC];
for jj=1:4
    ff=find(CRS<=CSTATUS(jj));
    if(jj>1)
        gg=find(CRS<=CSTATUS(jj)& CRS>CSTATUS(jj-1));
    else
        gg=1;
    end
    if(~isempty(ff)&&~isempty(gg))
        annotation('rectangle',[0.115+TempL(flast) 0.12 (TempL(ff(end))-TempL(flast))+dTT 0.03],'Facecolor',ColT(jj,:));
        annotation('textbox',[0.115+TempL(flast) 0.12 (TempL(ff(end))-TempL(flast))+dTT 0.03],'String',Stt{jj},'HorizontalAlignment','center','VerticalAlignment','middle','Fontsize',18,'color',ColTx(jj,:));
        
        if(ff(end)==length(TempL))
            flast=TTX(ff(end));
        else
            flast=TTX(ff(end))+1;
        end
    end
end

text(1.042801792151612,0.502894356005789,'Country status','Fontsize',20,'Rotation',270,'HorizontalAlignment','center','Units','normalized');


text(0.5,-0.06403121769692,'Country status','Fontsize',20,'HorizontalAlignment','center','Units','normalized');

end

