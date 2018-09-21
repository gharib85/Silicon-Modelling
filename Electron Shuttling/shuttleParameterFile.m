% % Constants
sparams.ee = 1.602E-19; % Charge of electron
sparams.me = 9.11E-31*0.191; % Effective mass of electron
sparams.hbar = 6.626E-34/(2*pi); % Reduced Planck's constant
sparams.c = 2.998E8; % Speed of light
% Pauli matrices
sparams.dz = [1,0;0,-1];
sparams.dx = [0,1;1,0];
sparams.dy = [0,-1i;1i,0];

% % Miscellaneous simulation parameters
sparams.verbose = 1;
sparams.saveData = 1;
sparams.updateWaitbar = 10000; % How many frames to wait before updating waitbar
sparams.updateFigure = 7000; % How many frames to wait before updating figure
sparams.updateInterpPot = 40000; % Interpolate the potential at 40000 points at a time
sparams.nFidelityFrames = 1000; % How many frames to calculate fidelity
sparams.nFigureFrames = 100; % How many frames of the simulation to save for outputted gif

% % Stark Shift Parameters
sparams.calculateStarkShift = 1; % Set to 0 if you don't want to calcualte Stark shift, 1 if you do.
sparams.nStarkShiftFrames = 500; % How many frames of the simulation to calculate the Stark shift
sparams.v0 = 40E9; % [Hz] Reference frequency for Stark shift calculation
sparams.n2 = 2.2*1E-9*1E-9; % [m^2/V^2] Stark shift formula quadratic coefficient

% % Pulse Parameters
sparams.tcThreshold = 0.0009; % Threshold value for the tunnel coupling
%sparams.voltagesToLoad = 0.2:0.250:1.95; % Declare which simulated voltages you wish to load
% sparams.voltagesToLoad = [0.3:0.2:0.7]; % Declare which simulated voltages you wish to load
% sparams.voltagesToLoad = 0.4:0.1:0.9;
sparams.numOfGates = 3;
sparams.gatesUsedInPulse = [1,2]; % Specificies which gates in the geometry you will actually use in the voltage pulse
sparams.nPulsePoints = length(sparams.gatesUsedInPulse)*500;

% % Adiabatic Parameters
sparams.findAdiabaticPulse = 1; % 1 if you want to use adiabatic conditions to find a pulse
% sparams.adiabaticThreshold = [[0.5,0.5];[0.001,0.025]];
sparams.adiabaticThreshold = [[0.5,0.5]];
sparams.hdt = 1E-15; % The h value used to find the time derivative of the wave function
sparams.timePowerBounds = [-15,-6]; % Range of 10^N time values to search in when doing optimizing the adiabatic parameter

% % Main Shuttling Simulation Parameters
sparams.dt = 5E-17; % Time between each simulation frame [sec]
sparams.sweptParameter = 'adiabicity';
% Vector of times to do the shuttling simulation over
%sparams.totalTime = 4E-9;

% % Effective Hamiltonian parameters
sparams.includeOrbital = 1;
sparams.includeValley = 1;
sparams.includeSpin = 1;

% % Directory Parameters
% Where to load potentials from for simulation
sparams.potDir = 'C:\Users\bbuonaco\Documents\MATLAB\Simulated Potentials\Three Gate Gap Induced Quantum Dots-DSize Increasing GSize Increasing\150nm dot increasing gap size\';
% sparams.potDir = 'C:\Users\bbuonaco\Documents\MATLAB\Simulated Potentials\Three Gate Gap Induced Quantum Dots - DSize80_GSize10\';
sparams.interpPotentials = 1; % Whether or not to interpolate the potentials in time domain for simulation
sparams.interpType = 'linear'; % What type of interpolation of the potentials to do in time domain
sparams.gateLabels = {'V_1','V_2','V_3'};%,'V_4','V_5'};
sparams.saveDir = 'C:/Users/bbuonaco/Documents/MATLAB/SimulationResults/Electron Shuttling/';