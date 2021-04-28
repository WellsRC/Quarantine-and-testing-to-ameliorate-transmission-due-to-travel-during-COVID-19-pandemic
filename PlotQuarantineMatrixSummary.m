function PlotQuarantineMatrixSummary(Country,Q,CRS)
figure('units','normalized','outerposition',[0.0 0.025 0.9 1]);
subplot('Position',[0.115,0.15,0.84,0.7]);
NC=length(Country);
CSTATUS=[25 150 500 10^6]; % last entry is just to serve as an upper bound
% Specify the colormap for the table
cmap=[1,1,1;0.852941215038300,0.809803962707520,0.872549057006836;0.801960825920105,0.656862795352936,0.801960825920105;0.680392205715179,0.511764764785767,0.629411816596985;0.511764764785767,0.327450990676880,0.468627452850342;0.480887889862061,0.254876732826233,0.496078461408615;0.374509811401367,0.186274513602257,0.480392158031464;0.363891184329987,0.157875448465347,0.450326800346375;0.353579014539719,0.131731659173965,0.420261442661285;0.343137264251709,0.107843138277531,0.390196084976196;0.317697197198868,0.0998841077089310,0.373856216669083;0.292974203824997,0.0922328755259514,0.357516348361969;0.269003689289093,0.0848894342780113,0.341176480054855;0.245821028947830,0.0778537914156914,0.324836611747742;0.223461598157883,0.0711259394884110,0.308496743440628;0.201960787177086,0.0647058859467506,0.292156875133514];
cmapt=[0,0,0;0,0,0;0,0,0;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1];
for ii=NC:-1:1
    for jj=1:NC
       if((NC+1-ii)==jj)
          patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,'k');
       else
            if(Q(NC+1-ii,jj)>14)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(Q(NC+1-ii,jj)+1,:));  
               text(jj,ii,'X','Fontsize',20,'HorizontalAlignment','center','color',cmapt(Q(NC+1-ii,jj)+1,:));
            elseif(Q(NC+1-ii,jj)>=0)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(Q(NC+1-ii,jj)+1,:)); 
               text(jj,ii,num2str(Q(NC+1-ii,jj)),'Fontsize',20,'HorizontalAlignment','center','color',cmapt(Q(NC+1-ii,jj)+1,:));
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
xlabel('Origin country','Fontsize',24,'Units','normalize','Position',[0.460678972382031,1.166352225405358])
h=colorbar('southoutside');
colormap([cmap;0.9 0.9 0.9]);

xxx=linspace(0,1,18);
h.Ticks=(xxx(2:end)+xxx(1:end-1))./2;
h.TickLabels={'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','No travel','N/A'};

h.Position=[0.115,0.06,0.84+0.0175,0.0255];
h.FontSize=20;

h.Label.String='Specified travel quarantine duration (days)';
h.Label.FontSize=22;
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
    ff=find(CRS<CSTATUS(jj));
    if(~isempty(ff))
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
    ff=find(CRS<CSTATUS(jj));
    if(~isempty(ff))
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