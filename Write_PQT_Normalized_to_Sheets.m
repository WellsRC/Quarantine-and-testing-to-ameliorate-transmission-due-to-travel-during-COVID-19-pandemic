%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% No test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asy=zeros(3,15);
SymNI=zeros(3,15);
Sym=zeros(3,15);

% 5.723 day incubation period

load('Shorter_Incubation_NoTest.mat')
Asy(1,:)=RQA./R0;
SymNI(1,:)=RQSN./R0;
Sym(1,:)=RQS./R0;

% 8.29 day incubation period

load('NoTest.mat')
Asy(2,:)=RQA./R0;
SymNI(2,:)=RQSN./R0;
Sym(2,:)=RQS./R0;

% 11.66 day incubation period

load('Longer_Incubation_NoTest.mat')
Asy(3,:)=RQA./R0;
SymNI(3,:)=RQSN./R0;
Sym(3,:)=RQS./R0;

writetable(array2table(Asy),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_No_Test','Range','B3','WriteVariableNames',0)
writetable(array2table(Sym),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_No_Test','Range','B8','WriteVariableNames',0)
writetable(array2table(SymNI),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_No_Test','Range','B13','WriteVariableNames',0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% RT-PCR Exit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asy=zeros(3,15);
SymNI=zeros(3,15);
Sym=zeros(3,15);

% 5.723 day incubation period

load('Shorter_Incubation_Quarantine_RTPCR_Exit.mat')
Asy(1,:)=RQA./R0;
SymNI(1,:)=RQSN./R0;
Sym(1,:)=RQS./R0;

% 8.29 day incubation period

load('Quarantine_RTPCR_Exit.mat')
Asy(2,:)=RQA./R0;
SymNI(2,:)=RQSN./R0;
Sym(2,:)=RQS./R0;

% 11.66 day incubation period

load('Longer_Incubation_Quarantine_RTPCR_Exit.mat')
Asy(3,:)=RQA./R0;
SymNI(3,:)=RQSN./R0;
Sym(3,:)=RQS./R0;

writetable(array2table(Asy),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RTPCR_Exit','Range','B3','WriteVariableNames',0)
writetable(array2table(Sym),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RTPCR_Exit','Range','B8','WriteVariableNames',0)
writetable(array2table(SymNI),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RTPCR_Exit','Range','B13','WriteVariableNames',0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% RA Test Exit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asy=zeros(3,15);
SymNI=zeros(3,15);
Sym=zeros(3,15);

% 5.723 day incubation period

load('Shorter_Incubation_Quarantine_BDVeritor_Exit.mat')
Asy(1,:)=RQA./R0;
SymNI(1,:)=RQSN./R0;
Sym(1,:)=RQS./R0;

% 8.29 day incubation period

load('Quarantine_BDVeritor_Exit.mat')
Asy(2,:)=RQA./R0;
SymNI(2,:)=RQSN./R0;
Sym(2,:)=RQS./R0;

% 11.66 day incubation period

load('Longer_Incubation_Quarantine_BDVeritor_Exit.mat')
Asy(3,:)=RQA./R0;
SymNI(3,:)=RQSN./R0;
Sym(3,:)=RQS./R0;

writetable(array2table(Asy),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Exit','Range','B3','WriteVariableNames',0)
writetable(array2table(Sym),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Exit','Range','B8','WriteVariableNames',0)
writetable(array2table(SymNI),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Exit','Range','B13','WriteVariableNames',0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% RA Test Exit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asy=zeros(3,15);
SymNI=zeros(3,15);
Sym=zeros(3,15);

% 5.723 day incubation period

load('Shorter_Incubation_Quarantine_BDVeritor_Entry_Exit.mat')
Asy(1,:)=RQA./R0;
SymNI(1,:)=RQSN./R0;
Sym(1,:)=RQS./R0;

% 8.29 day incubation period

load('Quarantine_BDVeritor_Entry_Exit.mat')
Asy(2,:)=RQA./R0;
SymNI(2,:)=RQSN./R0;
Sym(2,:)=RQS./R0;

% 11.66 day incubation period

load('Longer_Incubation_Quarantine_BDVeritor_Entry_Exit.mat')
Asy(3,:)=RQA./R0;
SymNI(3,:)=RQSN./R0;
Sym(3,:)=RQS./R0;

writetable(array2table(Asy),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Entry_Exit','Range','B3','WriteVariableNames',0)
writetable(array2table(Sym),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Entry_Exit','Range','B8','WriteVariableNames',0)
writetable(array2table(SymNI),'Supplemental_Quarantine_Calculation.xlsx','Sheet','PQT_RAg_Entry_Exit','Range','B13','WriteVariableNames',0)
