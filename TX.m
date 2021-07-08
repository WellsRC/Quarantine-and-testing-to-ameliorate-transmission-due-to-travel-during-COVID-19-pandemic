% Random entry in qiaratine with testing on exit
clear;

pobj=parpool(16); % Parallel pool
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ag Test
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


load('MLE-Estimate-RTPCR-Hill_Incubation_8_29_days.mat','beta');
betaRTPCR=beta;

testtype=cell(1,1);
testtype{1}=[];

PT24=1;
parfor jj=1:15 
    if(qA(jj)>0)
        RQS(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,max(qA(jj)-1,0),testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,ts,qA(jj),inf));
        RQSN(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,max(qA(jj)-1,0),testtype,R0S,R0A,0,ts,tL,td,0,betaRTPCR),0,max(ts-qA(jj),0),qA(jj),inf));
        RQA(jj)=((1./td).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,max(qA(jj)-1,0),testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,td,qA(jj),inf));  
    else
        % Infected after the test was adminsted 
        Posttest=((1./PT24).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,[],testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,PT24,@(u)(PT24-u),inf));
        Pretest=((1./(ts-PT24)).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,0,testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,ts-PT24,@(u)(u+PT24),inf));
        RQS(jj)=(PT24./ts).*Posttest+((ts-PT24)./ts).*Pretest;


        Posttest=((1./PT24).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,[],testtype,R0S,R0A,0,ts,tL,td,0,betaRTPCR),0,PT24,@(u)(PT24-u),inf));
        Pretest=((1./(ts-PT24)).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,0,testtype,R0S,R0A,0,ts,tL,td,0,betaRTPCR),0,ts-PT24,@(u)(u+PT24),inf));
        RQSN(jj)=(PT24./ts).*Posttest+((ts-PT24)./ts).*Pretest;


        Posttest=((1./PT24).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,[],testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,PT24,@(u)(PT24-u),inf));
        Pretest=((1./(td-PT24)).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t,u,0,testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,td-PT24,@(u)(u+PT24),inf));
        RQA(jj)=(PT24./td).*Posttest+((td-PT24)./td).*Pretest;            
    end
end

save(['Quarantine_RTPCR_Exit.mat']);
