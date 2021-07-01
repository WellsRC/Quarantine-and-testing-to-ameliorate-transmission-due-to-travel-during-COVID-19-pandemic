function PlotQuarantineHospitalization(Country,Q,CRS)
figure('units','normalized','outerposition',[0.0 0.025 0.9 1]);
subplot('Position',[0.115,0.15,0.84,0.7]);
NC=length(Country);
CSTATUS=[25 150 500 10^6]; % last entry is just to serve as an upper bound

% Specify the colormap for the table
cmap=[1,1,1;1,0.960784316062927,0.921568632125855;0.996078431606293,0.901960790157318,0.807843148708344;0.992156863212585,0.815686285495758,0.635294139385223;0.992156863212585,0.682352960109711,0.419607847929001;0.992156863212585,0.617647051811218,0.327450990676880;0.992156863212585,0.552941203117371,0.235294118523598;0.968627452850342,0.482352972030640,0.154901966452599;0.945098042488098,0.411764711141586,0.0745098069310188;0.898039221763611,0.347058832645416,0.0392156876623631;0.850980401039124,0.282352954149246,0.00392156885936856;0.750980377197266,0.247058838605881,0.00784313771873713;0.650980412960053,0.211764708161354,0.0117647061124444;0.574509799480438,0.182352945208550,0.0137254912406206;0.498039215803146,0.152941182255745,0.0156862754374743];% hex2rgb('#662506')];
cmapt=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1];%;1,1,1];
for ii=NC:-1:1
    for jj=1:NC
       if((NC+1-ii)==jj)
          patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,'k');
       else
            if(Q(NC+1-ii,jj)>=0)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(floor(Q(NC+1-ii,jj)./2)+1,:)); 
               text(jj,ii,num2str(Q(NC+1-ii,jj),'%3.1f'),'Fontsize',14,'HorizontalAlignment','center','color',cmapt(floor(Q(NC+1-ii,jj)./2)+1,:));
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

xxx=linspace(0,1,17);
h.Ticks=[xxx(1:end-1) 0.01+mean(xxx(end-1:end))];%(xxx(2:end)+xxx(1:end-1))./2;
h.TickLabels={'0','2','4','6','8','10','12','14','16','18','20','22','24','26','28','30','N/A'};

h.Position=[0.115,0.06,0.84,0.0255];
h.FontSize=16;

h.Label.String='Two-week hospitalization rate (per 100,000 residents)';
h.Label.FontSize=20;
h.Label.Position=[0.500000476837158,-0.975,0];


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

