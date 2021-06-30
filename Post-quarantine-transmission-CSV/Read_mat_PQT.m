cfold=pwd; % get current folder
cfold=cfold(1:79); % read for the folder above

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% No test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CaseScenario={'Symptomatic_Isolation';'Symptomatic_NO_Isolation';'Asymptomatic'};

% Calcualted the effective reproductive number
ts=8.29;
tL=2.9;
td=ts+20;
R0=3;
addpath(cfold);
EffectiveReproductiveNumber=[integral(@(t)InfectiousnessfromInfection(t,R0,R0,0,ts,tL,td,1),0,inf); 3; 3];
rmpath(cfold);

load([cfold 'NoTest.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'No test';'No test';'No test'};

TestConducted={'N/A'; 'N/A'; 'N/A'};

RTPCRCurve={'N/A';'N/A';'N/A'};

T=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];

T.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Wells et al (Nature communications) curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RT-PCR 24 h before exit

load([cfold 'NatComm-Quarantine_RTPCR_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'RT-PCR';'RT-PCR';'RT-PCR'};

TestConducted={'24-hr before exit'; '24-hr before exit'; '24-hr before exit'};

RTPCRCurve={'Wells et al';'Wells et al';'Wells et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];


% Rapid Ag on exit

load([cfold 'NatComm-Quarantine_BDVeritor_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'BD Veritor';'BD Veritor';'BD Veritor'};

TestConducted={'Exit'; 'Exit'; 'Exit'};

RTPCRCurve={'Wells et al';'Wells et al';'Wells et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];

% Rapid Ag on entry and exit

load([cfold 'NatComm-Quarantine_BDVeritor_Entry_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'BD Veritor';'BD Veritor';'BD Veritor'};

TestConducted={'Entry and Exit'; 'Entry and Exit'; 'Entry and Exit'};

RTPCRCurve={'Wells et al';'Wells et al';'Wells et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RT-PCR informed by Hellewell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RT-PCR 24 h before exit

load([cfold 'Quarantine_RTPCR_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'RT-PCR';'RT-PCR';'RT-PCR'};

TestConducted={'24-hr before exit'; '24-hr before exit'; '24-hr before exit'};

RTPCRCurve={'Hellewell et al';'Hellewell et al';'Hellewell et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];


% Rapid Ag on exit

load([cfold 'Quarantine_BDVeritor_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'BD Veritor';'BD Veritor';'BD Veritor'};

TestConducted={'Exit'; 'Exit'; 'Exit'};

RTPCRCurve={'Hellewell et al';'Hellewell et al';'Hellewell et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];

% Rapid Ag on entry and exit

load([cfold 'Quarantine_BDVeritor_Entry_Exit.mat'],'RQA','RQS','RQSN');

Quarantine=[RQS; RQSN; RQA];

TestType={'BD Veritor';'BD Veritor';'BD Veritor'};

TestConducted={'Entry and Exit'; 'Entry and Exit'; 'Entry and Exit'};

RTPCRCurve={'Hellewell et al';'Hellewell et al';'Hellewell et al'};

Ttemp=[table(CaseScenario,TestType,TestConducted,RTPCRCurve,EffectiveReproductiveNumber) array2table(Quarantine)];
Ttemp.Properties.VariableNames(6:20) = {'Q=0','Q=1','Q=2','Q=3','Q=4','Q=5','Q=6','Q=7','Q=8','Q=9','Q=10','Q=11','Q=12','Q=13','Q=14'};

T=[T; Ttemp];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% Write to csv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

writetable(T,'Expected_transmission_Post_quarantine.csv');