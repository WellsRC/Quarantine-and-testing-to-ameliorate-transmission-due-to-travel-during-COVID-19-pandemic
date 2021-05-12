function PlotQuarantineHospitalizationDeviation(Country,QT)

figure('units','normalized','outerposition',[0.0 0.025 0.9 1]);
subplot('Position',[0.115,0.135,0.84,0.7]);
NC=length(Country);

Q=QT;
Q(Q~=-1)=100.*(Q(Q~=-1)+0.15); % need to adjust to call specific colours in the gradient
Q(QT>-1 & QT<-0.15)=0;
% Specify the colormap for the table
cmap=[0.0156862754374743,0.317647069692612,0.521568655967712;0.156302526593208,0.415126055479050,0.589915990829468;0.296918779611588,0.512605071067810,0.658263325691223;0.437535017728806,0.610084056854248,0.726610660552979;0.578151285648346,0.707563042640686,0.794957995414734;0.718767523765564,0.805042028427124,0.863305330276489;0.859383761882782,0.902521014213562,0.931652665138245;1,1,1;0.882913172245026,0.934453785419464,0.857142865657806;0.765826344490051,0.868907570838928,0.714285731315613;0.648739516735077,0.803361356258392,0.571428596973419;0.531652688980103,0.737815141677856,0.428571432828903;0.414565831422806,0.672268927097321,0.285714298486710;0.297479003667831,0.606722712516785,0.142857149243355;0.180392161011696,0.541176497936249,0];
cmapt=[1,1,1;1,1,1;1,1,1;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;1,1,1;1,1,1;1,1,1];
for ii=NC:-1:1
    for jj=1:NC
       if((NC+1-ii)==jj)
          patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,'k');
       else
            if(Q(NC+1-ii,jj)>=0)
               patch([-0.5 -0.5 0.5 0.5]+jj,[-0.5 0.5 0.5 -0.5]+ii,cmap(floor(Q(NC+1-ii,jj)./2)+1,:)); 
               text(jj,ii,num2str(QT(NC+1-ii,jj),'%4.3f'),'Fontsize',18,'HorizontalAlignment','center','color',cmapt(floor(Q(NC+1-ii,jj)./2)+1,:));
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
xlabel('Origin country','Fontsize',24,'Units','normalize','Position',[0.460678972382031,1.180824005434302])
h=colorbar('southoutside');
colormap([cmap;0.65 0.65 0.65]);

xxx=linspace(0,1,17);
h.Ticks=[xxx(1:end-1) 0.01+mean(xxx(end-1:end))];%(xxx(2:end)+xxx(1:end-1))./2;

h.TickLabels={'<-0.15','-0.13','-0.11','-0.09','-0.07','-0.05','-0.03','-0.01','0.01','0.03','0.05','0.07',' 0.09',' 0.11',' 0.13','0.15','N/A'};

h.Position=[0.115,0.098460992907801,0.840023364485981,0.0255];
h.FontSize=20;

h.Label.String='Difference from average two-week hospitalization rate (per 100,000 residents)';
h.Label.FontSize=22;
h.Label.Position=[0.50,-1.609999952316284];

end
