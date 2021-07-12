clc;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Calcualtes the median quarantine duration for countries in different
% tiers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM','CSR');

CSTATUS=[25 150 500 10^6]; % last entry is just to serve as an upper bound
fprintf('=============================================================================== \n');
fprintf('Destination country \n');
fprintf('=============================================================================== \n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Green destination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(1));
if(~isempty(findx))
    QQ=QM(findx,:);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by destination Green country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Amber destination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(2) & CSR>=CSTATUS(1));
if(~isempty(findx))
    QQ=QM(findx,:);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by destination Amber country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Red destination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(3) & CSR>=CSTATUS(2));
if(~isempty(findx))
    QQ=QM(findx,:);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by destination Red country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Dark-Red destination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR>=CSTATUS(3));
if(~isempty(findx))
    QQ=QM(findx,:);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by destination Dark-Red country: %3.2f \n',median(QQ(:)));
end


fprintf('=============================================================================== \n');
fprintf('Origin country \n');
fprintf('=============================================================================== \n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Green origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(1));
if(~isempty(findx))
    QQ=QM(:,findx);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by Origin Green country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Amber origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(2) & CSR>=CSTATUS(1));
if(~isempty(findx))
    QQ=QM(:,findx);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by Origin Amber country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Red origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR<CSTATUS(3) & CSR>=CSTATUS(2));
if(~isempty(findx))
    QQ=QM(:,findx);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by Origin Red country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Dark-Red origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
findx=find(CSR>=CSTATUS(3));
if(~isempty(findx))
    QQ=QM(:,findx);
    QQ=QQ(QQ>=0);
   fprintf('Quarantine specified by Origin Dark-Red country: %3.2f \n',median(QQ(:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Varaints of Concern
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

fprintf('=============================================================================== \n');
fprintf('Varaints of concern \n');
fprintf('=============================================================================== \n');
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM','CSR');

QMNVOC=QM;

load(['Country_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');


fprintf('Median quarantine duration when NOT accounting for VOC: %3.2f \n',median(QMNVOC(QMNVOC>=0)));
fprintf('Median quarantine duration when NOT accounting for VOC (same pairs as VOC analysis): %3.2f \n',median(QMNVOC(QM>=0)));
fprintf('Median increase in quarantine duration when accoutning for VOC: %3.2f \n',median(QM(QM>=0)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Wells et al vs Hellewell et al
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');
QMH=QM;
load(['Country_NO_VOC_Quarantine_NatComm-Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');

fprintf('=============================================================================== \n');
fprintf('Wells et al vs Hellewell et al \n');
fprintf('=============================================================================== \n');

fprintf('Median quarantine for Hellewell et al: %3.2f \n',median(QMH(QMH>=0)));
fprintf('Median quarantine for Wells et al: %3.2f \n',median(QM(QM>=0)));

fprintf('Median non-zero quarantine for Hellewell et al: %3.2f \n',median(QMH(QMH>0)));
fprintf('Median non-zero quarantine for Wells et al: %3.2f \n',median(QM(QM>0)));

dQ=QM-QMH;
fprintf('Maximum difference in the specified quarantine (Remove border closure): %3.2f \n',max(dQ(QM>=0 & QM<15)));
fprintf('Minimum difference in the specified quarantine (Remove border closure): %3.2f \n',min(dQ(QM>=0 & QM<15)));


fprintf('Maximum difference in the specified quarantine: %3.2f \n',max(dQ(QM>=0)));
fprintf('Minimum difference in the specified quarantine: %3.2f \n',min(dQ(QM>=0)));

perC=length(dQ(QM>=0 & dQ<=0))./length(dQ(QM>=0));
fprintf('Percentage of the specified quarantines that decreased: %3.1f %% \n',100*perC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');
QML=QM;
load(['Country_NO_VOC_Quarantine_Shorter_Incubation_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');

fprintf('=============================================================================== \n');
fprintf('8.29 day incubatino period vs 5.72 day incubation period et al \n');
fprintf('=============================================================================== \n');


dQ=QM-QMH;

perC=length(dQ(QM>=0 & dQ==0))./length(dQ(QM>=0));

fprintf('Percentage of the specified quarantines that DID NOT CHANGE for shorter incubation: %3.1f %% \n',100*perC);

diffMed=median(QM(QM>=0 & dQ~=0))-median(QML(QM>=0 & dQ~=0));

fprintf('Change in the median quarantine due to the shorter incubation period: %3.2f \n',diffMed);



load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');
QML=QM;
load(['Country_NO_VOC_Quarantine_Longer_Incubation_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');

fprintf('=============================================================================== \n');
fprintf('8.29 day incubatino period vs 11.7 day incubation period et al \n');
fprintf('=============================================================================== \n');


dQ=QM-QMH;

perC=length(dQ(QM>=0 & dQ==0))./length(dQ(QM>=0));

fprintf('Percentage of the specified quarantines that DID NOT CHANGE for longer incubation: %3.1f %% \n',100*perC);

diffMed=median(QM(QM>=0 & dQ~=0))-median(QML(QM>=0 & dQ~=0));

fprintf('Change in the median quarantine due to the longer incubation period: %3.2f \n',diffMed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Adeherence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

fprintf('=============================================================================== \n');
fprintf('Adherence to self-isolation \n');
fprintf('=============================================================================== \n');
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');
QM100=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=75_AQ=100.mat'],'QM');
QM75=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=50_AQ=100.mat'],'QM');
QM50=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=25_AQ=100.mat'],'QM');
QM25=QM;


d75=QM75-QM100;
d75=d75(QM75>=0);


d50=QM50-QM100;
d50=d50(QM50>=0);


d25=QM25-QM100;
d25=d25(QM25>=0);

fprintf('Percentage of pairs that changed quarantine duration for 75%% adherence to self-isolation: %3.1f \n',100*length(d75(d75~=0))./length(d75));
fprintf('Percentage of pairs that changed quarantine duration for 50%% adherence to self-isolation: %3.1f \n',100*length(d50(d50~=0))./length(d50));
fprintf('Percentage of pairs that changed quarantine duration for 25%% adherence to self-isolation: %3.1f \n',100*length(d25(d25~=0))./length(d25));


fprintf('=============================================================================== \n');
fprintf('Adherence to quarantine \n');
fprintf('=============================================================================== \n');
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=100.mat'],'QM');
QM100=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=75.mat'],'QM');
QM75=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=50.mat'],'QM');
QM50=QM;
load(['Country_NO_VOC_Quarantine_Quarantine_RTPCR_Exit_AL=100_AQ=25.mat'],'QM');
QM25=QM;

fprintf('Percentage of pairs that require no travel for 100%% adherence to quarantine: %3.1f \n',100*length(QM100(QM100==15))./length(QM100(QM100>=0)));
fprintf('Percentage of pairs that require no travel for 75%% adherence to quarantine: %3.1f \n',100*length(QM75(QM75==15))./length(QM75(QM75>=0)));
fprintf('Percentage of pairs that require no travel for 50%% adherence to quarantine: %3.1f \n',100*length(QM50(QM50==15))./length(QM50(QM50>=0)));
fprintf('Percentage of pairs that require no travel for 25%% adherence to quarantine: %3.1f \n',100*length(QM25(QM25==15))./length(QM25(QM25>=0)));