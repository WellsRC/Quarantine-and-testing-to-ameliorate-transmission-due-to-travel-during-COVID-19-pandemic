% Random entry in qiaratine with testing on exit
clear;

pobj=parpool(16); % Parallel pool
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RTPCR Test for the Nat Comm curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qt=[0:14]; % Quarantine durations consideredd
SelfIsolate=1; % Self-isolation
tL=[2.9]; % vecotor for the incbation periods to be integrated over

% Allcoate memory for output

% Get Basline parameters
[pA,~,R0,ts] = BaselineParameters(tL); % Does not matter here what ts is fed in 

qA=qt;

RQS=zeros(size(qA)); % Vectorize the matrix
RQSN=zeros(size(qA)); % Vectorize the matrix
RQA=zeros(size(qA)); % Vectorize the matrix

td=ts+20; % Asymptomatic increase 20 days from symptom onset

R0S=R0; % Set R0 for symptomatic
R0A=R0; % Set R0 for asymptomatic


load('MLE-Estimate-RTPCR-Hill.mat','beta');
betaRTPCR=beta;

testtype=cell(1,1);
testtype{1}=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We are focusing on "Country A"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parfor jj=1:15 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    % Those from B that travelled to A (i.e. need to undergo quarantine for
    % Country A)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5        

    % re-write as the differences of the integrals to accelerate
    RQS(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[],testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,ts,qA(jj),inf));
    RQSN(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[],testtype,R0S,R0A,0,ts,tL,td,0,betaRTPCR),0,max(ts-qA(jj)),qA(jj),inf));
    RQA(jj)=((1./td).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[],testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,td,qA(jj),inf));  
end

save(['NoTest.mat']);
clear;