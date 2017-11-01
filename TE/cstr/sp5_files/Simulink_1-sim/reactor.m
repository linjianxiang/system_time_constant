function [sys,x0,str,ts,simStateCompliance] = reactor(t,x,u,flag)
switch flag,
    
    %%%%%%%%%%%%%%%%%%
    % Initialization %
    %%%%%%%%%%%%%%%%%%
    case 0,
        [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes();
        
        %%%%%%%%%%%%%%%
        % Derivatives %
        %%%%%%%%%%%%%%%
    case 1,
        sys=mdlDerivatives(t,x,u);
        
        %%%%%%%%%%
        % Update %
        %%%%%%%%%%
    case 2,
        sys=mdlUpdate(t,x,u);
        
        %%%%%%%%%%%
        % Outputs %
        %%%%%%%%%%%
    case 3,
        sys=mdlOutputs(t,x,u);
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % GetTimeOfNextVarHit %
        %%%%%%%%%%%%%%%%%%%%%%%
    case 4,
        sys=mdlGetTimeOfNextVarHit(t,x,u);
        
        %%%%%%%%%%%%%
        % Terminate %
        %%%%%%%%%%%%%
    case 9,
        sys=mdlTerminate(t,x,u);
        
        %%%%%%%%%%%%%%%%%%%%
        % Unexpected flags %
        %%%%%%%%%%%%%%%%%%%%
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes()

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);


% initialize the initial conditions
%x0 = [368.25; 0.8;e;mt]; % for Tc = 280
x0 = [368.25; 0.8;0;0];  %T,Ca,a1,a2

%x0  = [324.475443431599; 0.87725294608097]; % for Tc = 300

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%==========================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)
%
% CSTR model from
%
% Michael A. Henson and Dale E. Seborg.  Nonlinear Process Control.
%      Prentice Hall PTR, Upper Saddle River, New Jersey, 1997.

% Description:
% Continuously Stirred Tank Reactor with energy balance and reaction A->B.
%   The temperature of the cooling jacket is the manipulated variable.

% % Inputs (4):
% % Temperature of cooling jacket (K)
% Tc = u(1);  % nominal = 300
% % Volumetric Flowrate (m^3/sec)
% F = u(2);   % nominal = 100
% % Feed Concentration (mol/m^3)
% Caf = u(3); % nominal = 1
% % Feed Temperature (K)
% Tf = u(4);  % nominal = 350
% 
% % States (2):
% % Temperature in CSTR (K)
 T = x(1);
% % Concentration of A in CSTR (mol/m^3)
 Ca = x(2);  
% 
% %Tc = 300;
% %Ca_ss = 0.87725294608097;
% %T_ss = 324.475443431599;
% 
% % Parameters:
% % Volume of CSTR (m^3)
% V = 100;
% % Density of A-B Mixture (kg/m^3)
% rho = 1000;
% % Heat capacity of A-B Mixture (J/kg-K)
% Cp = .239;
% % Heat of reaction for A->B (J/mol)
% mdelH = 5e4;
% % E - Activation energy in the Arrhenius Equation (J/mol)
% % R - Universal Gas Constant = 8.31451 J/mol-K
% EoverR = 8750;
% % Pre-exponential factor (1/sec)
% k0 = 7.2e10;
% % U - Overall Heat Transfer Coefficient (W/m^2-K)
% % A - Area - this value is specific for the U calculation (m^2)
% UA = 5e4;

noise_weight= 200;

V=1;
rho=10^6;
ro_c=10^6;
E_R=8330.1;
Cp=1;
CPc=1;
b=0.5;
K0_initial=10^10;
a=1.678*10^6;
Delta_H=-1.3*10^7;
k0 =(1-t*(3*10^-4))*K0_initial; 

Fc=15;
Fa=0.1;
Fs=0.9;
Tc=365;
T0=370;
Caa=19.1;
Cas=0.1;

a1 = x(3);
a2 = x(4);

%

%e = random('Normal',0,1,1,9);
% if (t == 0)
%     a1 = 0;
%     a2 = 0;
% else %noise introduce
%      T =  T + e(1)*T/noise_weight; 
%      Ca =  Ca + Ca*e(2)/noise_weight;
%      Fc = Fc + Fc*e(3)/noise_weight;
%      Fa = Fa + Fa*e(4)/noise_weight;
%      Fs = Fs +Fs*e(5)/noise_weight;
%      Tc = Tc + Tc*e(6)/noise_weight;
%      T0 = T0 +T0*e(7)/noise_weight;
%      Caa = Caa +Caa*e(8)/noise_weight;
%      Cas = Cas +Cas*e(9)/noise_weight;
% end
% 
% %fault introduce
% if (t > 5) 
%     %Tc = Tc +2;
%     %Caa = Caa * 1.1;
% end  
%     

F = Fs + Fa;   
Ca0=(Caa * Fa + Cas * Fs) / (Fa + Fs);
mdelH = 5e4;
UA = 5e4;
% mdelH = (-Delta_H)*(1+a1);
% UA = (a2*a*Fc^(b+1))/(Fc+(a2*a*Fc^b)/(2*ro_c*(CPc)));
% Compute xdot:
sys(1,1) = F/V*(T0 - T) ... 
    + mdelH/(rho*Cp)*k0*exp(-E_R/T)*Ca ...
    + UA/V/rho/Cp*(Tc-T);
sys(2,1) = F/V*(Ca0 - Ca) ...
    - k0*exp(-E_R/T)*Ca;
sys(3,1) = a1;
sys(4,1) = a2;

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
x1        = x(1);
x2        = x(2);

sys = [x1;x2];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
