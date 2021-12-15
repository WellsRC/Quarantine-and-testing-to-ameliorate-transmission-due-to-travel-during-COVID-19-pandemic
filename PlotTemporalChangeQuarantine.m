clear;
close all;
figure('units','normalized','outerposition',[0 0.05 0.8 0.7]);

subplot('Position',[0.141210526315789,0.33,0.85,0.638174962292611]);

load('Compare_Time_Quarantine.mat','deltaQ','QM','Qtemp','DateIv')

QMN=squeeze(QM(:,:,1));
QMN=QMN(:);

Per=zeros(length(DateIv),3);
for ii=1:length(DateIv)
   Per(ii,:)=[sum(deltaQ(QMN>=0,ii)==1) sum(deltaQ(QMN>=0,ii)==2) sum(deltaQ(QMN>=0,ii)>=3)]./sum(QMN>=0);
end

bar(Per,'stacked','LineStyle','none');
XL=cell(size(DateIv));
for ii=1:length(DateIv)
    XL{ii}=datestr(datenum(DateIv{ii}));
end
xlim([0.5 length(DateIv)+0.5])
ylim([0 0.45]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',20,'XTick',[1:length(DateIv)],'XTickLabel',XL,'YTick',[0:0.05:0.45])
xtickangle(90);
box off;
legend({'One additional day required','Two additional days required','Three or more additional days required'},'Fontsize',18,'Location','NorthWest');

xlabel('Date of epidemic information','Fontsize',24);
ylabel({'Fraction of October 3','specified quarantines','in need of an increase'},'Fontsize',24);


figure('units','normalized','outerposition',[0 0.05 0.8 0.7]);

subplot('Position',[0.141210526315789,0.33,0.84,0.62]);

QS=Qtemp(QMN>=0,:);

plot(mean(QS,1),'k-o','LineWidth',2,'MarkerFace','k');

xlim([1 length(DateIv)])
ylim([0 1]);
set(gca,'LineWidth',2,'tickdir','out','Fontsize',20,'XTick',[1:length(DateIv)],'XTickLabel',XL,'YTick',[0:0.1:1])
xtickangle(90);
box off;
grid on

xlabel('Date of epidemic information','Fontsize',24);
ylabel({'Fraction of October 3 quarantines',' that never resulted in an','increase of infections'},'Fontsize',22);

print(gcf,'Figure_Temporal_Q.png','-dpng','-r600');



