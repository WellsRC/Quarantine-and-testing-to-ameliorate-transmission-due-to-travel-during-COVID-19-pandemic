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

[qA,qB]=meshgrid(qt,qt); % Create a mesh grid of the paramters being changes
qA=qA(:);
qB=qB(:);

RQS=zeros(size(qA)); % Vectorize the matrix
RQSN=zeros(size(qA)); % Vectorize the matrix
RQA=zeros(size(qA)); % Vectorize the matrix

td=ts+20; % Asymptomatic increase 20 days from symptom onset

R0S=R0; % Set R0 for symptomatic
R0A=R0; % Set R0 for asymptomatic


testtype=cell(1,1);
testtype{1}=[];

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
        RQS(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTestingOLD(t+u,u,max(0,qA(jj)-1),testtype,R0S,R0A,0,ts,tL,td,SelfIsolate),0,ts,qA(jj),qA(jj)+durT));
        RQSN(jj)=((1./ts).*integral2(@(u,t)InfectiousnessfromInfectionTestingOLD(t+u,u,max(0,qA(jj)-1),testtype,R0S,R0A,0,ts,tL,td,0),0,ts,qA(jj),qA(jj)+durT));
        RQA(jj)=((1./td).*integral2(@(u,t)InfectiousnessfromInfectionTestingOLD(t+u,u,max(0,qA(jj)-1),testtype,R0S,R0A,1,ts,tL,td,0),0,td,qA(jj),qA(jj)+durT));  

    end

    save(['NatComm-Quarantine_RTPCR_Exit_Duration=' num2str(durT) '.mat']);
end
clear;