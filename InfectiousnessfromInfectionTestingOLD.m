function R = InfectiousnessfromInfectionTestingOLD(ttemp,utemp,timet,testtype,R0S,R0A,pA,ts,tL,td,SelfIsolate)
%InfectiousnessfromInfection returns the infectiousness at time t given total virus
%shed and R0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t - time post-infection
% u - time of testing
% R0S - Reproductive number symptomatic
% R0A - Reproductive number asymptomatic
% pA - proportion asymptomatic
% ts - time from infection to symptom onset (i.e. incubation period)
% tL - Duration of the latent period
% SelfIsolate - 0 no self-isolation of symptomatic otherwise self-isolation
% upon symptom onset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S - Probability of that it is a true positive based on the viral load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u=utemp(:)';
t=ttemp(:)';
% Computation for asymptomatic
RA=R0A.*ViralShedding_Asymptomatic(t,tL,td);
SA=zeros(length(timet),length(u));
Senstd=inf;
for jj=1:length(timet)
    SA(jj,:) = TestSensitivityOLD(u+timet(jj),ts,tL,Senstd,[testtype{jj}],1);
end
% Computation for symptomatic
if(SelfIsolate==0)
    RS=R0S.*ViralShedding_Symptomatic(t,tL,td);
else
    RS=zeros(size(t));
    RS(t<=ts)=R0S.*ViralShedding_Symptomatic(t(t<=ts),tL,td);
end

SS=zeros(length(timet),length(u));
for jj=1:length(timet)
    SS(jj,:) = TestSensitivityOLD(u+timet(jj),ts,tL,Senstd,[testtype{jj}],0);
end

%Combine asymptmatic and symptomaic 
R=(1-pA).*RS.*prod((1-SS),1)+pA.*RA.*prod((1-SA),1);
R=R';
R=reshape(R,size(utemp));
end

