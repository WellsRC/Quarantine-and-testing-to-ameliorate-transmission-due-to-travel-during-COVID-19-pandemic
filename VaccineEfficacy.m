function [epsvT1,epsvT2,epsvH1,epsvH2] = VaccineEfficacy

% Use european average for 60+
w60to69=0.121345549;
w70p=0.052621047;
wT=w60to69+w70p;
w60to69=w60to69./wT;
w70p=w70p./wT;

%age=[0-19 20-29 30-39 40-49 50-59 60-100];
% Vaccine efficacy for transmission
epsvT1=[32 32 32 30 30 (30.*w60to69+26.*w70p)]./100; % First dose
epsvT2=[94 94 94 90 90 (90.*w60to69+95.*w70p)]./100; % Second dose

% Vaccine efficacy for hospitalization
epsvH1=[33 33 33 70 70 (70.*w60to69+51.*w70p)]./100; %First dose
epsvH2=[87 87 87 87 87 (87.*w60to69+87.*w70p)]./100; % Second dose

end

