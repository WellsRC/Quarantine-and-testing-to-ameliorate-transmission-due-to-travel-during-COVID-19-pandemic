%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Runs the sensntivity analysis for the coutnry pairings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
clear;
clc;
DateI={'August 8, 2021'};
IncubationP=5.723;
load('Country_Data_August 8, 2021_Incubation=5.723_Adherence_Level_100.mat');

AL=1;
AQ=1;

tempV=VTABM./repmat(N,1,length(CountryM));

meddAB=median(avgABM(avgABM>=0));
stddAB=std(avgABM(avgABM>=0));

medvAB=median(tempV(tempV>=0));
stdvAB=std(tempV(tempV>=0));

medc=median(c);
stdc=std(c);
medN=median(log10(N));
stdN=std(log10(N));
medrec=median(rec,1);
stdrec=std(rec,1);
medvac=median(vac,1);
stdvac=std(vac,1);
medprev=median(prev,1);
stdprev=std(prev,1);
mednage=median(Demo,1);
stdnage=std(Demo,1);


TT=[[1:length(CountryM)]' cstatusR];
TEX=sortrows(TT,2);

CountryM=CountryM(TEX(:,1));
CSR=TEX(:,2);

cFile='Shorter_Incubation_Quarantine_RTPCR_Exit';


NM=length(CountryM);

QM=-1.*ones(16,NM,NM);
QMSA=-1.*ones(16,NM,NM);

ChangeD=zeros(16,NM,NM);


d=30;
qR=[0:14];
FVOCA=1;
FVOCB=1;
RVOC=0;
REPSVOC=0;
RNIVOC=0;

for ii=1:NM
    for jj=1:NM
        [nageA,nageB,prevA,prevB,vacA,vacB,~,~,recA,recB,cA,cB,NA,NB,~,VTAB,dAB,~,VTBA,dBA,pA,~,~,~,~,~,~] = DataReturnSim(CountryM(ii),CountryM(jj),AL,DateI,IncubationP);
        if(~isempty(prevA))
            
            for pp=1:16
                nageAtemp=nageA;
                nageBtemp=nageB;
                prevAtemp=prevA;
                prevBtemp=prevB;
                vacAtemp=vacA;
                vacBtemp=vacB;
                recAtemp=recA;
                recBtemp=recB;
                cAtemp=cA;
                cBtemp=cB;
                dABtemp=dAB;
                dBAtemp=dBA;
                NAtemp=NA;
                NBtemp=NB;
                
                vABtemp=(VTAB/NAtemp);
                vBAtemp=(VTBA/NBtemp);
                
                vAB=(VTAB./NA);
                vBA=(VTBA./NB);
                [qA,~] = DetermineQuarantine(qR,nageA,nageB,[1],[1],[0],[0],[0],pA,prevA,prevB,vacA,vacB,recA,recB,cA,cB,vAB,vBA,dAB,dBA,NA,NB,AL,AQ,cFile);
                if(~isempty(qA))
                    QM(pp,ii,jj)=qA;
                else
                    QM(pp,ii,jj)=15;           
                end
                switch pp
                    case 1
                        ABin=[19./2 25 35 45 55 65 75 90];
                        for zz=1:length(nageA)
                           if(nageAtemp(zz)>mednage(zz))
                               nageAtemp(zz)=max(nageAtemp(zz)-stdnage(zz),0);
                           else
                               nageAtemp(zz)=min(nageAtemp(zz)+stdnage(zz),1);
                           end
                           nageAtemp=nageAtemp./sum(nageAtemp);
                        end
                        
                        if(sum(ABin.*nageAtemp)>sum(ABin.*nageA))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(ABin.*nageAtemp)<sum(ABin.*nageA))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 2
                        ABin=[19./2 25 35 45 55 65 75 90];
                        for zz=1:length(nageB)
                           if(nageBtemp(zz)>mednage(zz))
                               nageBtemp(zz)=max(nageBtemp(zz)-stdnage(zz),0);
                           else
                               nageBtemp(zz)=min(nageBtemp(zz)+stdnage(zz),1);
                           end
                           nageBtemp=nageBtemp./sum(nageBtemp);
                        end
                        if(sum(ABin.*nageBtemp)>sum(ABin.*nageB))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(ABin.*nageBtemp)<sum(ABin.*nageB))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 3
                        for zz=1:length(prevA)
                           if(prevAtemp(zz)>medprev(zz))
                               prevAtemp(zz)=max(prevAtemp(zz)-stdprev(zz),0);
                           else
                               prevAtemp(zz)=min(prevAtemp(zz)+stdprev(zz),1);
                           end
                           if(prevAtemp(zz)+recAtemp(zz)+vacAtemp(zz)>=1)
                               prevAtemp(zz)=0.999-recAtemp(zz)-vacAtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        if(sum(prevAtemp.*nageAtemp)>sum(prevA.*nageA))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(prevAtemp.*nageAtemp)<sum(prevA.*nageA))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 4
                        for zz=1:length(prevB)
                           if(prevBtemp(zz)>medprev(zz))
                               prevBtemp(zz)=max(prevBtemp(zz)-stdprev(zz),0);
                           else
                               prevBtemp(zz)=min(prevBtemp(zz)+stdprev(zz),1);
                           end
                           if(prevBtemp(zz)+recBtemp(zz)+vacBtemp(zz)>=1)
                               prevBtemp(zz)=0.999-recBtemp(zz)-vacBtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        if(sum(prevBtemp.*nageBtemp)>sum(prevB.*nageB))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(prevBtemp.*nageBtemp)<sum(prevB.*nageB))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 5
                        for zz=1:length(vacA)
                           if(vacAtemp(zz)>medvac(zz))
                               vacAtemp(zz)=max(vacAtemp(zz)-stdvac(zz),0);
                           else
                               vacAtemp(zz)=min(vacAtemp(zz)+stdvac(zz),1);
                           end
                           if(prevAtemp(zz)+recAtemp(zz)+vacAtemp(zz)>=1)
                               vacAtemp(zz)=0.999-recAtemp(zz)-prevAtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        
                        if(sum(vacAtemp.*nageAtemp)>sum(vacA.*nageA))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(vacAtemp.*nageAtemp)<sum(vacA.*nageA))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 6
                        for zz=1:length(vacB)
                           if(vacBtemp(zz)>medvac(zz))
                               vacBtemp(zz)=max(vacBtemp(zz)-stdvac(zz),0);
                           else
                               vacBtemp(zz)=min(vacBtemp(zz)+stdvac(zz),1);
                           end
                           if(prevBtemp(zz)+recBtemp(zz)+vacBtemp(zz)>=1)
                               vacBtemp(zz)=0.999-recBtemp(zz)-prevBtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        if(sum(vacBtemp.*nageBtemp)>sum(vacB.*nageB))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(vacBtemp.*nageBtemp)<sum(vacB.*nageB))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 7
                        for zz=1:length(recA)
                           if(recAtemp(zz)>medrec(zz))
                               recAtemp(zz)=max(recAtemp(zz)-stdrec(zz),0);
                           else
                               recAtemp(zz)=min(recAtemp(zz)+stdrec(zz),1);
                           end
                           if(prevAtemp(zz)+recAtemp(zz)+vacAtemp(zz)>=1)
                               recAtemp(zz)=0.999-vacAtemp(zz)-prevAtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        if(sum(recAtemp.*nageAtemp)>sum(recA.*nageA))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(recAtemp.*nageAtemp)<sum(recA.*nageA))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 8
                        for zz=1:length(recB)
                           if(recBtemp(zz)>medrec(zz))
                               recBtemp(zz)=max(recBtemp(zz)-stdrec(zz),0);
                           else
                               recBtemp(zz)=min(recBtemp(zz)+stdrec(zz),1);
                           end
                           if(prevBtemp(zz)+recBtemp(zz)+vacBtemp(zz)>=1)
                               recBtemp(zz)=0.999-vacBtemp(zz)-prevBtemp(zz); %Using 0.999 as we do divide by the age based immunit in A in the calcuation of the inequlity and do not want to be dividing by zero; need to be conssitent so alos apply to B
                           end
                        end
                        if(sum(recBtemp.*nageBtemp)>sum(recB.*nageB))
                            ChangeD(pp,ii,jj)=1;
                        elseif(sum(recBtemp.*nageBtemp)<sum(recB.*nageB))
                            ChangeD(pp,ii,jj)=-1;
                        end
                    case 9
                       if(cAtemp>medc)
                           cAtemp=max(cAtemp-stdc,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           cAtemp=min(cAtemp+stdc,1);
                           ChangeD(pp,ii,jj)=1;
                       end
                    case 10
                       if(cBtemp>medc)
                           cBtemp=max(cBtemp-stdc,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           cBtemp=min(cBtemp+stdc,1);
                           ChangeD(pp,ii,jj)=1;
                       end
                   case 11
                       if(vABtemp>medvAB)
                           vABtemp=max(vABtemp-stdvAB,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           vABtemp=min(vABtemp+stdvAB,1);
                           ChangeD(pp,ii,jj)=1;
                       end
                    case 12
                       if(vBAtemp>medvAB)
                           vBAtemp=max(vBAtemp-stdvAB,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           vBAtemp=min(vBAtemp+stdvAB,1);
                           ChangeD(pp,ii,jj)=1;
                       end
                   case 13
                       if(dABtemp>meddAB)
                           dABtemp=max(dABtemp-stddAB,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           dABtemp=dABtemp+stddAB;
                           ChangeD(pp,ii,jj)=1;
                       end
                    case 14
                       if(dBAtemp>meddAB)
                           dBAtemp=max(dBAtemp-stddAB,0);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           dBAtemp=dBAtemp+stddAB;
                           ChangeD(pp,ii,jj)=1;
                       end
                    case 15
                       if(log10(NAtemp)>medN)
                           NAtemp=10.^(log10(NAtemp)-stdN);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           NAtemp=10.^(log10(NAtemp)+stdN);
                           ChangeD(pp,ii,jj)=1;
                       end
                       % Need to ensure that the total number of travellers
                       % does not change
                       vABtemp=(VTAB./NAtemp);
                    case 16
                       if(log10(NBtemp)>medN)
                           NBtemp=10.^(log10(NBtemp)-stdN);
                           ChangeD(pp,ii,jj)=-1;
                       else
                           NBtemp=10.^(log10(NBtemp)+stdN);
                           ChangeD(pp,ii,jj)=1;
                       end
                       % Need to ensure that the total number of travellers
                       % does not change
                       vBAtemp=(VTBA./NBtemp);
                end
                [qA,~] = DetermineQuarantine(qR,nageAtemp,nageBtemp,[1],[1],[0],[0],[0],pA,prevAtemp,prevBtemp,vacAtemp,vacBtemp,recAtemp,recBtemp,cAtemp,cBtemp,vABtemp,vBAtemp,dABtemp,dBAtemp,NAtemp,NBtemp,AL,AQ,cFile);
                if(~isempty(qA))
                    QMSA(pp,ii,jj)=qA;
                else
                    QMSA(pp,ii,jj)=15;           
                end
            end
        end
    end
end
save('Country_Sensitivity_Analysis.mat');