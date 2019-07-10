%% CostDesignDecisionsKesteren
%
% Syntax:
% ======
% [output] = CostDesignDecisionsKesteren(PEGASUS, PEGASUSXL)
%
%
% Input arguments:
% ===============
%  ALV     = TRUE if ALV project is evaluated                 [-]
%  PEGASUS   = TRUE if PEGASUS project is evaluated               [-]
%  PEGASUSXL = TRUE if PEGASUSXL project is evaluated             [-]

% Output arguments:
% ================ 
% output = structure.
%    d_f0 = development system engineering factor                 [-]
%    d_f1 = development standard factor                           [-]
%    d_f3 = development team experience factor                    [-]
%    d_f7 = development program organization factor               [-]
%    d_f10_3 = development hybrid upper stage                     [-]
%    p_f0    = systems engineering factor                         [-]
%    p_f9    = industrial evoluciont factor                       [-] 
%    p_f10   = upper storability factor                           [-]
%    p_f10_3 = upper storability factor (hybrid)                  [-]
%    p_Qn    = batch factor                                       [-]
%    p_Qn_H  = batch factor hybrid                                [-]
%    o_fvehic= operations launch vehicle type factor              [-]
%    o_fvehic_hybrid = operations launch vehicle type hybrid      [-]
%    o_fc    = operations processing type factor                  [-]
%    o_f8    = operations country operations factor               [-]
%{
--------------------------------------------------------------------------------
Description:
===========
% Design Decisions should be called in order to evaluate properly different launcher
% projects. These decisions change numerical factors and several parameters among 
% CER's calculations. Pegasus parameters are extracted from Kesteren, while 
% our parameters are fixed for several configurations. It is easier to manage all
% configuration changes from this file, totally outside the functions calculations.


Acronyms:
========
 CER.- Cost Estimating Relationship


References:
==========
[1] MARTINO, PAOLO. 
    "Costs and risks analysis tool for conceptual launch vehicle MDO". 2010

[2] M. W. VAN KESTEREN. 
    "Air Launch versus Ground Launch: a Multidisciplinary Design Optimization 
    Study of Expendable Launch Vehicles on Cost and Performance". 2013
--------------------------------------------------------------------------------
Main author:
===========
R. Delgado-Aguilera Jurado
Systems Engineer

E-Mail: r.delgadoaguilera@alumnos.urjc.es
--------------------------------------------------------------------------------
Record of revisions:
===================
     Date               Author                 Description of change
     ====               ======                 =====================
  18/04/2019           J. Alonso               First version
 
--------------------------------------------------------------------------------
Copyright:
=========
Copyright (C) 2019, National Institute of Aerospace Technology (INTA).
The copyright to the computer program(s) herein is the property of INTA.
The program(s) may be used and/or copied only with the written permission of 
INTA or in accordance with the terms and conditions stipulated in the agreement/
contract under which the program(s) have been supplied.
--------------------------------------------------------------------------------
%}
%%
function [output] = CostDesignDecisionsKesteren(ALV,PEGASUS,PEGASUSXL)

    %%%%%%%%
    % ALV
    %%%%%%%%
if ALV  
    d_f0 = 1.5; 
    d_f1 = 1.2;
    d_f3 = 1.2;
    d_f10_3 = 1.0;
    d_aircraftDev = 0.0; 
%
    p_f0 = 1.05;
    p_f9 = 0.2;
    p_f10 = 1.0;
    p_f10_3 = 1.5;

    o_Qn = [0.4, 0.15, 0.15]; 
    o_QnH = (0.15+0.4)/2;

    o_fvehic = 0.3; 
    o_fvehic_hybrid = (0.3+0.3+0.8)/3;   
   
    o_fc = 0.5; 
    o_f8 = 0.85; 

    o_f10 = 0.3; 

    o_aircraftOpsCost = 0.3; 
end

%%%%%%%%
%PEGASUS
%%%%%%%%
if PEGASUS
    d_f0 = 1.4; 
    d_f1 = 1.0;

    d_f3 = 1.2;

    d_f10_3 = 1.0;
    d_aircraftDev = 122; 
%
    p_f0 = 1.05;
    p_f9 = 0.2;
    p_f10 = 1.0;
    p_f10_3 = 1.0; 

    o_Qn = [0.4, 0.15, 0.15]; 
    o_QnH = (0.15+0.4)/2;    
%
    o_fvehic = 0.3; 
    o_fvehic_hybrid = o_fvehic;
    o_fc = 0.5; 

    o_f8 = 1.0; 

    o_f10 = 0.3;
    o_aircraftOpsCost = 1.75; 

end

%%%%%%%%
%PEGASUSXL
%%%%%%%%

if PEGASUSXL
    d_f0 = 1.4; 
    d_f1 = 1.0;
    d_f3 = 1.2;
    d_f10_3 = 1.0;
    d_aircraftDev = 122; 
%
    p_f0 = 1.05;
    p_f9 = 0.2;
    p_f10 = 1.0;
    p_f10_3 = 1.5;

    o_Qn = [0.4, 0.15, 0.15]; 
    o_QnH = (0.15+0.4)/2;

    o_fvehic = 0.3; 
    o_fvehic_hybrid =o_fvehic;
    o_fc = 0.5; 
    o_f8 = 1.0; 

    o_f10 = 0.3; 

    o_aircraftOpsCost = 1.75; 
end


output =... 
  struct('d_f0', d_f0,'d_f1',d_f1,'d_f3',d_f3,...
      'd_f10_3',d_f10_3,'p_f0',p_f0,'p_f9',p_f9,'p_f10',...
       p_f10,'p_f10_3',p_f10_3,'o_Qn',o_Qn,'o_QnH',o_QnH,...
       'o_fvehic',o_fvehic,'o_fvehic_hybrid',o_fvehic_hybrid,...
       'o_fc',o_fc,'o_f8',o_f8,'o_f10',o_f10,'aircraftDev',...
       d_aircraftDev,'o_aircraftOpsCost',o_aircraftOpsCost);

end
