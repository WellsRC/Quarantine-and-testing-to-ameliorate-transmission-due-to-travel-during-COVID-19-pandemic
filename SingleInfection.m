function [Infection] = SingleInfection(qAI,RA,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,cFile)
     load([cFile{1} '=' num2str(d) '.mat'],'qA','qB','RQA','RQS');

RQ=((1-pA).*RQS(qA==qAI & qB==0)+pA.*RQA(qA==qAI & qB==0));

load(['Quarantine_NotTEST_Exit_0QNoDelay_-Duration=' num2str(d) '.mat'],'qA','qB','RQA','RQS');
RV=((1-pA).*RQS(qA==0 & qB==0)+pA.*RQA(qA==0 & qB==0));

T2A=NA.*(1-dAB.*vAB).*cA.*RA.*(1-prevA-vacA-recA);

T3A=NB.*dBA.*vBA.*cA.*((1-prevB-vacB-recB)./(1-prevA-vacA-recA)).*RA.*(1-prevA-vacA-recA);

T4A=NA.*vAB.*prevA.*RV.*(1-prevA-vacA-recA);

T5A=NA.*vAB.*prevB.*((1-prevA-vacA-recA)./(1-prevB-vacB-recB)).*RQ.*(1-prevA-vacA-recA);

T6A=NB.*vBA.*prevB.*RQ.*(1-prevA-vacA-recA);

T7A=NB.*vBA.*prevA.*((1-prevB-vacB-recB)./(1-prevA-vacA-recA)).*RV.*(1-prevA-vacA-recA);

Infection=(T2A+T3A+T5A+T6A)-(T4A+T7A); % The minus is suppose to be there!

end
