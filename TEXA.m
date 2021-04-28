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

[qA,qB]=meshgrid(qt,qt); % Create a mesh grid of the paramters being changes
qA=qA(:);
qB=qB(:);

RQS=zeros(size(qA)); % Vectorize the matrix
RQA=zeros(size(qA)); % Vectorize the matrix

RQQS=zeros(size(qA)); % Vectorize the matrix
RQQA=zeros(size(qA)); % Vectorize the matrix

RIQS=zeros(size(qA));
RIQA=zeros(size(qA));

td=ts+20; % Asymptomatic increase 20 days from symptom onset

R0S=R0; % Set R0 for symptomatic
R0A=R0; % Set R0 for asymptomatic


load('MLE-Estimate-RTPCR-Hill.mat','beta');
betaRTPCR=beta;

load('BDVeritor_Parameter.mat','beta');

testtype=cell(2,1);
testtype{1}=beta;
testtype{2}=beta;

testtype2=cell(4,1);
testtype2{1}=beta;
testtype2{2}=beta;
testtype2{3}=beta;
testtype2{4}=beta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We are focusing on "Country A"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for durT=30:-1:1
    parfor jj=1:225 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        % Those from B that travelled to A (i.e. need to undergo quarantine for
        % Country A)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        
        
        % re-write as the differences of the integrals to accelerate
        RQS(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qA(jj)],testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,ts,qA(jj),qA(jj)+durT));
        RQA(jj)=((1./td).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qA(jj)],testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,td,qA(jj),qA(jj)+durT));  
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        % Those from A that travelled to B and returned to A (i.e. need to undergo both quarantine for
        % Country A and coutnry B) we go to inf since the are not leaving
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

         RQQS(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qB(jj) qB(jj)+durT qA(jj)+qB(jj)+durT],testtype2,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,ts,qA(jj)+qB(jj)+durT,inf));
         RQQA(jj)=((1./td).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qB(jj) qB(jj)+durT qA(jj)+qB(jj)+durT],testtype2,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,td,qA(jj)+qB(jj)+durT,inf));  


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        % Individual from A infected in B and returning to A
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

        RIQS(jj)=((1./min(ts,durT)).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qA(jj)],testtype,R0S,R0A,0,ts,tL,td,SelfIsolate,betaRTPCR),0,min(ts,durT),qA(jj),inf));
        RIQA(jj)=((1./min(td,durT)).*integral2(@(u,t)InfectiousnessfromInfectionTesting(t+u,u,[0 qA(jj)],testtype,R0S,R0A,1,ts,tL,td,0,betaRTPCR),0,min(td,durT),qA(jj),inf));   

    end

    save(['Quarantine_BDVeritor_Entry_Exit_Duration=' num2str(durT) '.mat']);
end
clear;