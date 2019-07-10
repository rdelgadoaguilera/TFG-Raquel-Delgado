%% KesterenOperations
%
% Syntax:
% ======
% [output]=KesterenOperations(desDec,totalYears,operationalYears,StagesMass,...
%                   launchYearRate,HYBRID)
%
%
% Input arguments:
% ===============
%  desDec           = correction factors struct (design decisions)   [-]
%  totalYears       = total project years duration                  [Yr]
%  operationalYears = operational years duration of the project     [Yr]
%  StagesMass       = vector mass for each stage                    [kg]
%  launchRateYear   = number of launches by year                     [-]
%  HYBRID           = true if hybrid engine in upper stage         [m^3]

% Output arguments:
% ================ 
% output = structure.
%   output.operationsCosts    = operations cost in Euros FY2012 [€]
%   

%{
--------------------------------------------------------------------------------
Description:
===========
% This function returns operations costs.


Acronyms:
========


References:
==========
[1] M. W. VAN KESTEREN. 
    "Air Launch versus Ground Launch: a Multidisciplinary Design Optimization 
    Study of Expendable Launch Vehicles on Cost and Performance". 2013

[2] MARTINO, PAOLO. 
    "Costs and risks analysis tool for conceptual launch vehicle MDO". 2010

--------------------------------------------------------------------------------
Main author:
===========
Raquel Delgado-Aguilera Jurado.

National Institute of Aerospace Technology (INTA)
Madrid, Spain

E-Mail: r.delgadoaguilera@alumnos.urjc.es
--------------------------------------------------------------------------------

%}
%%
function [output]=KesterenOperations(desDec,totalYears,operationalYears,StagesMass,...
                   launchYearRate,HYBRID)
%%
%% Operation Costs

% ****
% CERs
% ****

totalMass = sum(StagesMass);
numStages = size(StagesMass,2);

% Ground operations
mGTOW = totalMass/1000; %Needed in TONS

% TYPO in Kesteren about exponent 0.67
groundOpsCost = 8*mGTOW^0.67*launchYearRate^-0.9*numStages^0.7;

% Flight operations
Qn  = desDec.o_Qn;
QnH = desDec.o_QnH;

% ****
% Operation correction factors
% ****

% Launch vehicle type. Winged solid launch vehicle 0.5 
fvehic= desDec.o_fvehic;

if (HYBRID)
    fvehic = desDec.o_fvehic_hybrid;
end

%fc processing for horizontal type.
fc = desDec.o_fc; 
 
%f10 Air launch correction factor
f10= desDec.o_f10;

% Aircraft operations cost.
aircraftOpsCost = desDec.o_aircraftOpsCost; 

% Flight operations cost.
flightOpsCost = 0;
for i=1:numStages
    flightOpsCost = flightOpsCost + 20*Qn(i)*launchYearRate^-0.65;
end

%In hybrid, I assume average in Qn
if(HYBRID)
 flightOpsCost = 0;
 for i=1:numStages-1
    flightOpsCost = flightOpsCost + 20*Qn(i)*launchYearRate^-0.65;
 end
    flightOpsCost = flightOpsCost + ...
        (20*QnH*launchYearRate^-0.65);    
end

%Cost for transport and insurance.
%Martino applies fvehic*fc*f10 to groundOpsCost
transInsurOpsCost = (groundOpsCost*fvehic*fc*f10+flightOpsCost)*0.1;

% Total operational cost.
operationsCost = fvehic*fc*f10*(transInsurOpsCost + flightOpsCost + ...
                 groundOpsCost) + aircraftOpsCost;


output =... 
  struct('operationsCost', operationsCost);

end
