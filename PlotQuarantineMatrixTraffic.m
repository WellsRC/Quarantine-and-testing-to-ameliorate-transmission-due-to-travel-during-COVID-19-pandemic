function PlotQuarantineMatrixTraffic(Country,Q,splot)
% Create Figure
figure('units','normalized','outerposition',[0.05 0.05 0.64 0.8]);
subplot('Position',[0.148,0.25,0.77,0.58]);
NC=length(Country);
cmap=[1,1,1;0.852941215038300,0.809803962707520,0.872549057006836;0.801960825920105,0.656862795352936,0.801960825920105;0.680392205715179,0.511764764785767,0.629411816596985;0.511764764785767,0.327450990676880,0.468627452850342;0.480887889862061,0.254876732826233,0.496078461408615;0.374509811401367,0.186274513602257,0.480392158031464;0.363891184329987,0.157875448465347,0.450326800346375;0.353579014539719,0.131731659173965,0.420261442661285;0.343137264251709,0.107843138277531,0.390196084976196;0.317697197198868,0.0998841077089310,0.373856216669083;0.292974203824997,0.0922328755259514,0.357516348361969;0.269003689289093,0.0848894342780113,0.341176480054855;0.245821028947830,0.0778537914156914,0.324836611747742;0.223461598157883,0.0711259394884110,0.308496743440628;0.201960787177086,0.0647058859467506,0.292156875133514];
cmapt=[0,0,0;0,0,0;0,0,0;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1];

for ii=NC:-1:1
    for jj=1:NC
            if(Q(NC+1-ii,jj)>14)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(Q(NC+1-ii,jj)+1,:));  
               text(jj,ii,'X','Fontsize',30,'HorizontalAlignment','center','color',cmapt(Q(NC+1-ii,jj)+1,:));
            elseif(Q(NC+1-ii,jj)>=0)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(Q(NC+1-ii,jj)+1,:)); 
               text(jj,ii,num2str(Q(NC+1-ii,jj)),'Fontsize',30,'HorizontalAlignment','center','color',cmapt(Q(NC+1-ii,jj)+1,:));
            end
    end
end
set(gca,'LineWidth',2,'tickdir','out','YTick',[1:NC],'Yminortick','off','YTickLabel',flip(Country),'Fontsize',26,'XAxisLocation','top','XTick',[1:NC],'Xminortick','off','XTickLabel',Country)
xlim([0.5 NC+0.5])
ylim([0.5 NC+0.5])
ylabel({'Cases per 100,000','in destination country'},'Fontsize',28,'Position',[0.110535341861161,2.500001907348633])
xtickangle(45)
xlabel('Cases per 100,000 in origin country','Fontsize',28,'Position',[2.5,5.285979877467752])
h=colorbar('southoutside');
colormap([cmap]);

xxx=linspace(0,1,17);
xxx=(xxx(2:end)+xxx(1:end-1))./2;
xxx(end)=xxx(end)+0.025;
h.Ticks=xxx;
h.TickLabels={'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel'};

h.Position=[0.148,0.118795314074776,0.77+0.025,0.035050839771379];
h.FontSize=24;

h.Label.String='Specified travel quarantine duration (days)';
h.Label.FontSize=26;
h.Label.Position=[0.501037821235498,-1.71851850439001];



TempL=flip(linspace(0,0.58,NC+1));
Stt={'Green','Amber','Red','Dark Red'};
ColT=[hex2rgb('#598234');hex2rgb('#C99E10');hex2rgb('#CF3721');hex2rgb('#8C0004');];
ColTx=[0 0 0; 0 0 0; 1 1 1; 1 1 1];

xx=[0.96268031477992,0.97768031477992; 0.963744486598124,0.978744486598125; 0.951790288900511,0.966790288900512;0.975251851121972,0.990251851121973];
for jj=1:4
        annotation('rectangle',[0.148+0.77 0.25+TempL(jj+1) 0.025 TempL(jj)-TempL(jj+1)],'Facecolor',ColT(jj,:));
        
        annotation('textarrow',xx(jj,:),[0.25+mean([TempL(jj) TempL(jj+1)]) 0.25+mean([TempL(jj) TempL(jj+1)])],'String',Stt{jj},'HorizontalAlignment','center','VerticalAlignment','middle','Fontsize',18,'color',ColTx(jj,:),'HeadStyle', 'none', 'LineStyle', 'none','TextRotation',270)  
       
end

TempL=(linspace(0,0.77,NC+1));
for jj=1:4
        annotation('rectangle',[0.148+TempL(jj) 0.215 (TempL(jj+1)-TempL(jj)) 0.035],'Facecolor',ColT(jj,:));
        annotation('textbox',[0.148+TempL(jj) 0.215 (TempL(jj+1)-TempL(jj)) 0.035],'String',Stt{jj},'HorizontalAlignment','center','VerticalAlignment','middle','Fontsize',18,'color',ColTx(jj,:));
        
end

text(4.8256,2.5,'Country status','Fontsize',20,'Rotation',270,'HorizontalAlignment','center');


text(2.5,0.024506738544474,'Country status','Fontsize',20,'HorizontalAlignment','center');
text(-0.237364196476662,5.5,char(64+splot),'Fontsize',32,'FontWeight','bold');
end

