function [q1,q2] = DetermineQuarantine(qr,nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,RA,RB,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,cFile)
     RIEQA=zeros(length(FVOCA),length(qr));
     RIEQB=zeros(length(FVOCA),length(qr));
    for ii=1:length(qr)
        [RIEQA(:,ii)]=CalculateInequalityVOCAll(nageA,nageB,FVOCA,FVOCB,RVOC,REPSVOC,RNIVOC,RA,pA,d,prevA,prevB,vacA,vacB,recA,recB,cA,vAB,vBA,dAB,dBA,NA,NB,qr(ii),cFile);
        [RIEQB(:,ii)]=CalculateInequalityVOCAll(nageB,nageA,FVOCB,FVOCA,RVOC,REPSVOC,RNIVOC,RB,pA,d,prevB,prevA,vacB,vacA,recB,recA,cB,vBA,vAB,dBA,dAB,NB,NA,qr(ii),cFile);
    end
    
    EPSQT=5.*10^(-19); % Sepcified by the error in the Dark Red and Dark Red case
    q1=-1;
    q2=-1;
    for ii=1:length(FVOCA)
        q1=max([min(qr(RIEQA(ii,:)<=EPSQT))],q1);
        q2=max([min(qr(RIEQB(ii,:)<=EPSQT))],q2);
    end
end
