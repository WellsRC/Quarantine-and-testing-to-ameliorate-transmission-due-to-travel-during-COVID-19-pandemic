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

av=[6.85146800000000;3.44342380000000;2.16082760000000];
bv=[0.982316341225263;1.76955383531329;2.35323186981921];

LatentPeriod=[1.9,2.9,3.9];
a=av(tL==LatentPeriod);
b=bv(tL==LatentPeriod);

mm=(a-1).*b+tL;

 [S]=PCRSens(t,beta);
 V=ViralShedding_Symptomatic(t,tL,td);
if(~isempty(testtype))
    tt=[mm:0.1:90]; % made coarsered to improve the search tt=[ts:0.001:90]; 
    Vx=ViralShedding_Symptomatic(tt,tL,td);
    PPA=LR(tt-ts,testtype);
    if(~isempty(t(t<mm)))
        S(t<mm)=pchip(Vx,PPA,V(t<mm)).*PCRSens(t(t<mm),beta);
    end
    S(t>=mm)=PCRSens(t(t>=mm),beta).*LR(t(t>=mm)-ts,testtype);
end

end

