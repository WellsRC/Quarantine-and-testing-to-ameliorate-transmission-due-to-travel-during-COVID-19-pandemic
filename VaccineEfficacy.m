function [epsvT1,epsvT2,epsvH1,epsvH2] = VaccineEfficacy

%age=[0-19 20-29 30-39 40-49 50-59 60-69 70-79 80-100];
% Vaccine efficacy for transmission
epsvT1=[32 32 32 30 30 30 26 26]./100; % First dose
epsvT2=[94 94 94 90 90 90 95 95]./100; % Second dose

% Vaccine efficacy for hospitalization
epsvH1=[33 33 33 70 70 70 51 51]./100; %First dose
epsvH2=[87 87 87 87 87 87 87 87]./100; % Second dose

end

