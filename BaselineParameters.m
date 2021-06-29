function [pA,IncubationI,R0,ts,td] = BaselineParameters(tL)
%BASELINEPARAMETERS 

pA=0.308;

R0=3;

ts=8.29;

td=ts+20;

IncubationI=integral(@(t)ViralShedding_Symptomatic(t,tL,td),0,ts);
end

