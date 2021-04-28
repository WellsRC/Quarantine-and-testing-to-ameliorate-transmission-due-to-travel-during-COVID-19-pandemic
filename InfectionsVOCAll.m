function [InfectionsA]=InfectionsVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,RAw,pA,d,prevAw,prevBw,vacAw,vacBw,recAw,recBw,cAw,vAB,vBA,dAB,dBA,NA,NB,qAI,cFile)

if(qAI>=0)
    load([cFile{1} '=' num2str(d) '.mat'],'qA','qB','RQA','RQS');

    RQw=((1-pA).*RQS(qA==qAI & qB==0)+pA.*RQA(qA==qAI & qB==0));

    load(['NoTest_Duration=' num2str(d) '.mat'],'qA','qB','RQA','RQS');
    RVw=((1-pA).*RQS(qA==0 & qB==0)+pA.*RQA(qA==0 & qB==0));

    InfectionsA=zeros(size(nageA));
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
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        T2A=sum(NA.*(1-(qAI+dAB).*vAB).*(cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(nageA.*(1-phiAw));

        T3A=sum(NB.*dBA.*vBA.*(cA.*(nageB.*(1-phiBw)./(1-phiA))).*RA).*(nageA.*(1-phiAw));

        T4A=sum(NA.*vAB.*nageA.*prevA.*RV).*(nageA.*(1-phiAw));

        T5A=sum(NA.*vAB.*nageA.*prevB.*((1-phiAw)./(1-phiBw)).*RQ).*(nageA.*(1-phiAw));

        T6A=sum(NB.*vBA.*nageB.*prevB.*RQ).*(nageA.*(1-phiAw));

        T7A=sum(NB.*vBA.*nageB.*prevA.*((1-phiBw)./(1-phiAw)).*RV).*(nageA.*(1-phiAw));

        InfectionsA=InfectionsA+((T2A+T3A+T5A+T6A)-(T4A+T7A)); % The minus is suppose to be there!

    end
else
    
    InfectionsA=zeros(size(nageA));
    for jj=1:length(FVOCA)

        RA=RAw.*(1+RVOC(jj));

        cA=cAw.*FVOCA(jj);
        vacA=vacAw.*(1-REPSVOC(jj));
        recA=recAw.*(1-RNIVOC(jj,1));



        phiA =sum(nageA.*(prevAw+vacA+recA));
        
        phiAw=prevAw+vacA+recA;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate the inequality
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        T1A=sum(NA.*(cA.*nageA.*(1-phiAw)./(1-phiA)).*RA).*(nageA.*(1-phiAw));
        InfectionsA=InfectionsA+T1A; 

    end
end

end

