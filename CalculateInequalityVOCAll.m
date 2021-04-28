function [RIEQA]=CalculateInequalityVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,RAw,pA,d,prevAw,prevBw,vacAw,vacBw,recAw,recBw,cAw,vAB,vBA,dAB,dBA,NA,NB,qAI,cFile)

load([cFile{1} '=' num2str(d) '.mat'],'qA','qB','RQA','RQS');

RQw=((1-pA).*RQS(qA==qAI & qB==0)+pA.*RQA(qA==qAI & qB==0));

load(['NoTest_Duration=' num2str(d) '.mat'],'qA','qB','RQA','RQS');
RVw=((1-pA).*RQS(qA==0 & qB==0)+pA.*RQA(qA==0 & qB==0));

RIEQA=zeros(length(FVOCA),1);
for jj=1:length(FVOCA)

    RA=RAw.*(1+RVOC(jj));
    RQ=RQw.*(1+RVOC(jj));
    RV=RVw.*(1+RVOC(jj));
    
    cA=cAw.*FVOCA(jj);
    prevA=prevAw.*FVOCA(jj);
    prevB=prevBw.*FVOCB(jj);
    vacA=vacAw.*(1-REPSVOC(jj));
    vacB=vacBw.*(1-REPSVOC(jj));
    recA=recAw.*(1-RNIVOC(jj,1));
    recB=recBw.*(1-RNIVOC(jj,1));
    
    
    
    phiA =sum(nageA.*(prevAw+vacA+recA));
    phiAw=prevAw+vacA+recA;
    phiBw=prevBw+vacB+recB;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the inequality
    
    % Need to have the 1-phiA in the inequality for this code as it will
    % not cancel out over the summation!
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    %%% FACTORED the NA out to improve the numerical accuracy as a result
    %%% of numerical rounding error
    
    T1A=sum((cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(1-phiA);
    
    T2A=sum((1-(qAI+dAB).*vAB).*(cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(1-phiA);

    T3A=sum((NB./NA).*dBA.*vBA.*(cA.*(nageB.*(1-phiBw)./(1-phiA))).*RA).*(1-phiA);

    T4A=sum((vAB.*nageA.*prevA.*RV)).*(1-phiA);

    T5A=sum((vAB.*nageA.*prevB.*((1-phiAw)./(1-phiBw)).*RQ)).*(1-phiA);

    T6A=sum(((NB./NA).*vBA.*nageB.*prevB.*RQ)).*(1-phiA);

    T7A=sum(((NB./NA).*vBA.*nageB.*prevA.*((1-phiBw)./(1-phiAw)).*RV)).*(1-phiA);

    RIEQA(jj)=((T2A+T3A+T5A+T6A)-(T1A+T4A+T7A)); % The minus is suppose to be there!

end

end

