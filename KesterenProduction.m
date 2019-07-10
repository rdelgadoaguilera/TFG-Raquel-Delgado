%% KesterenProduction
%
% Syntax:
% ======
% [output]=KesterenProduction(desDec,operationalYears, StagesMass,...
%           PropMass,EngineMass,HYBRID,launchYearRate,fairingVolume)
%
%
% Input arguments:
% ===============
%  desDec            = struct with correction factors                [-]
%  operationalYears  = operational years duration of the project    [Yr]
%  StagesMass        = vector mass for each stage                   [kg]
%  PropMass          = vector for propellant mass each stage        [kg]
%  EngineMass        = vector for engine masses                     [kg]
%  HYBRID            = true if hybrid engine in upper stage          [-]
%  launchRateYear    = number of launches by year                    [-]
%  fairingVolume     = fairing volume                              [m^3]                      

% Output arguments:
% ================ 
% output = structure.
%   output.productionCost     = production cost in Euros per unit  []

%{
--------------------------------------------------------------------------------
Description:
===========
% This function returns Production Cost.


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
Record of revisions:
===================
     Date               Author                 Description of change
     ====               ======                 =====================
   
--------------------------------------------------------------------------------

%}
%%
function [output]=KesterenProduction(desDec,operationalYears, StagesMass,...
           PropMass,EngineMass,HYBRID,launchYearRate,fairingVolume,PILUM)

%% Production Costs
% ****
% CERs
% ****

% Fairing production cost.
fairingProd = ((0.83*fairingVolume)^0.63);

%REMEMBER HYBRID COST IS AVERAGE SOLID/LIQUID

% Propellant cost for small SRM.
SolidPropellantProd = 0.2422*(PropMass).^0.2962;

liquidStorPropellantProd = 1.19*EngineMass(3)^0.535;

thirdStageProductionHybrid = ( SolidPropellantProd(3) + ...
    liquidStorPropellantProd ) / 2;

% Stage Dry mass (3.25 in Martino's thesis)
dryMassThirdStage = StagesMass(3) - PropMass(3);
liquidUpperStage = 1.19*dryMassThirdStage^0.535;

% Since system for solid = 0, we just compute half this value
liquidUpperStage = 0.5*liquidUpperStage;

% ****
% Production correction factors
% ****

% System engineering correction factor.
f0 = desDec.p_f0;

totalMass = sum(StagesMass);
systemDryMass = totalMass - sum(PropMass); % IN KG


if PILUM
    p = 0.8; %Kesteren indication	
else
    p = 0.85;
end

% Cost reduction due to series production.
f4=0;

auxExponent = log(p)/log(2);

for n=1:(launchYearRate*operationalYears)
     f4 = f4 + n^auxExponent;     
end

f4 = f4/(launchYearRate*operationalYears);


% Value taken from "Cost Model Validation Data, Appendix H"
%For hybrid, needed Industrial Evolution Factor f9. Fixed number (3.34)
f9 = desDec.p_f9;

%Upper stage storability. In hybrid is 1.5;
f10_3 = desDec.p_f10_3;

productionCost = fairingProd + sum(SolidPropellantProd);

if (HYBRID)
    productionCost = fairingProd + sum(SolidPropellantProd(1:2));
    hybridProd     = thirdStageProductionHybrid + liquidUpperStage;
    % Martino associates f10 also to fairing in cost tree, which is wrong
    % our initial numbers where right anyway, since for solid f10 = 1.0;
    hybridProd     = hybridProd*f10_3*f9;
    productionCost = productionCost + hybridProd;    
end

% Total production cost per unit
productionCost = productionCost*f0*f4;

output = struct('productionCost',productionCost);


end

