# Sufficient strategies for travel quarantine and testing
Chad R. Wells, Jeffrey P. Townsend*, Abhishek Pandey, Meagan C. Fitzpatrick, William S. Crystal, Alison P. Galvani
Copyright (C) <2021>, Chad R. Wells et. al. All rights reserved. Released under the GNU General Public License (GPL)

This repository contains codes and data used to simulate and analyze COVID-19 travel quarantine and testing strategies between countries.

The model code is written in MATLAB and results are saved as MATLAB data files (extension .mat), with plots also being constructed in MATLAB. As MATLAB is not an open-source software/programming language, a compatible code that can be run using GNU Octave can be found in the directory named Octave in the repository.

## OS System requirements
The codes developed here are tested on Windows operating system (Windows 10 Home: 64-bit). However as Matlab is available for most operating systems, codes should run on Mac OSX and Linux as well.

## Installation guide
### MATLAB
Installation instruction for MATLAB can be found at https://www.mathworks.com/help/install/install-products.html. Typical install time for MATLAB on a "normal" desktop is around 30-40 minutes. The current codes were developed and tested on MATLAB R2018b.

## Demo
CountryMatrix_Summary generates Figure 2G in the main text; while MapPlots_Quarantine generates the panels for A-F for Figure 2. All mat files to run this script are avaialble. The script TX calcualtes the post-quarantine of transmission (Currently set-up to run different for different durations of stay: Analysis assumes long-duration of stay, thus we utilize only a 30-day duration of stay as it exceeds the 28.29 days of the duration of disease. This code will be updated upon revision to remove these extra components not required in the calculation).

## Instructions for use
To generate the Figures and output of the calculations, select a script from Figures section to run in MATLAB and enter the name in the command line. All mat file are availble to generate figures and conduct the calculations. To run analysis on a different set of parameters, adjust the parameters in the script and enter the name of the script in the command line to run.

## Analysis scripts
NoTest- Calculates the post-quarantine transmission (PQT) for no testing.
TX- Calculates the post-quarantine transmission (PQT) for an RT-PCR test on exit.
TXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on exit.
TEXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on entry and exit.
OTX- Calculates the post-quarantine transmission (PQT) for an RT-PCR test on exit using alternative diagnsotic sensitivty curve.
OTXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on exit using alternative diagnsotic sensitivty curve for the RT-PCR.
OTEXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on entry and exit using alternative diagnsotic sensitivty curve for the RT-PCR.
CountryMatrix_Sensitivity_Analysis- Conducts the sensitivity analysis for the country-pair analysis
## Figures and Analysis
CompareQuarantines- Comapres the quarantine for the country-pair analysis and the teir-based analysis
CountryMatrix-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit
CountryMatrix_Summary-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit (Figure 2G).
CountryMatrix_No_Test-Sufficient quarantine duration for country-pair analysis for no testing
CountryMatrix_Ag_Test-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on exit
CountryMatrix_Dual_Ag_Test-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on entry and exit
CountryMatrix_RTPCR_NatComm-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit for alternative diagnostic senticity curve for the RT-PCR
CountryMatrix_Ag_Test_NatComm-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on exit for alternative diagnostic senticity curve for the RT-PCR
CountryMatrix_Dual_Ag_Test_NatComm-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on entry and exit for alternative diagnostic senticity curve for the RT-PCR
CountryMatrixVOC-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit when considering variants of concern
CountryMatrixVOC_summary-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit when considering variants of concern (Generates Figure 4).
Figure_SA_Plot - Generates the panels for the sensitivity analysis
MapPlots_Quarantine-Generates the panels of the maps for specified countries
TrafficLightAnalysis-Sufficient quarantine duration for teir-based analysis for an RT-PCR test on exit
TrafficLightAnalysis_No_Test-Sufficient quarantine duration for teir-based analysis for anot test
TrafficLightAnalysis_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on exit
TrafficLightAnalysis_Dual_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on entry and exit
NatComm_TrafficLightAnalysis_RTPCR-Sufficient quarantine duration for teir-based analysis for an RT-PCR test on exit for alternative diagnostic senticity curve for the RT-PCR
NatComm_TrafficLightAnalysis_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on exit for alternative diagnostic senticity curve for the RT-PCR
NatComm_TrafficLightAnalysis_Dual_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on entry and exit for alternative diagnostic senticity curve for the RT-PCR
## Functions/Scripts
ReadDatatoMAT- Reads data from files to a mat file for the country-pair analysis
