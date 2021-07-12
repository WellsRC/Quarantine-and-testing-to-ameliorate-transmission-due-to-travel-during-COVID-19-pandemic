function V = ViralShedding_Asymptomatic(t,tL,td)
%ViralShedding_Asymptomatic(t,tL) reutrns the level of infectiousness for an asymptomatic individual at
%time t

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t - time post-infection
%tL- duration of the latent period

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V - the amount of viral shedding at time t

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% See EstimatingInfectioncurves for how determined

av=[10.024035];
bv=[0.939245823173824];
dtv=[0.791600000000000];
mv=[10.3350568509818];

LatentPeriod=[2.9];
a=av(tL==LatentPeriod);
b=bv(tL==LatentPeriod);
dt=dtv(tL==LatentPeriod);
m=mv(tL==LatentPeriod);

V=zeros(size(t));
V(t>=(tL+dt))=gampdf(t(t>=(tL+dt))-tL,a,b); % Do not need the 100 as the 100 was used to scale to the data y and this will be normalzied after

CD=gampdf(dt,a,b);
A=CD./(exp(m.*(dt+tL))-1);
V(t<(tL+dt))=A.*(exp(m.*t(t<(tL+dt)))-1);
V(t<0)=0;
V(t>td)=0;
% Normalizing constant
NC=integral(@(x)(A.*(exp(m.*x)-1)),0,tL+dt)+integral(@(x)(gampdf(x-tL,a,b)),tL+dt,td);

V=V./NC;
end

