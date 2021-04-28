function S = TestSensitivity(t,ts,tL,td,testtype,beta)
%SensitivityvsViralLoad(V,asym) - Returns the sensitivity for a given viral
%load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ts- incubation period
% testtype - test type

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S - Probability of that it is a true positive based on the viral load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 [S]=PCRSens(t,beta,tL);
 V=ViralShedding_Symptomatic(t,tL,td);
if(~isempty(testtype))
    tt=[ts:0.1:90]; % made coarsered to improve the search tt=[ts:0.001:90]; 
    Vx=ViralShedding_Symptomatic(tt,tL,td);
    PPA=LR(tt,testtype);
    if(~isempty(t(t<ts)))
        S(t<ts)=pchip(Vx,PPA,V(t<ts)).*PCRSens(t(t<ts),beta,tL);
    end
    S(t>=ts)=PCRSens(t(t>=ts),beta,tL).*LR(t(t>=ts),testtype);
end

end

