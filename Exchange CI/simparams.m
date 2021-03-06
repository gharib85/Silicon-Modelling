%***Physical constants***%
sparams.unitsType = 'Rydberg';
% sparams.unitsType = 'SI - J';
% sparams.unitsType = 'SI - meV';
sparams.materialSystem = 'Silicon';

% Grid parameters
% Number of grid points in x and y directions.  Initialized to 0 but filled
% in after potential is loaded
gparams.ngridx = 0;
gparams.ngridy = 0;

% electron charge
sparams.ee = 1.60217662E-19;
% permitivity of free space
sparams.eps0 = 8.85418782E-12;
% Reduced Planck's constant
sparams.hbar = 6.6260701E-34/(2*pi);
if strcmp(sparams.unitsType,'SI - meV')
    sparams.hbar = sparams.hbar/sparams.ee/1E-3;
end
% Dielectic constant and effective mass
if strcmp(sparams.materialSystem,'Silicon')
    sparams.epsR = 7.8;
    sparams.me = 9.10938356E-31*0.191;
elseif strcmp(sparams.materialSystem,'GaAs')
    sparams.epsR = 12.4;
    sparams.me = 9.10938356E-31*0.067; 
end
% Permitivity
sparams.eps = sparams.eps0*sparams.epsR;
% If Rydberg
if strcmp(sparams.unitsType,'Rydberg')
    sparams.hbar = 1;
    sparams.me = 1;
end

%***Input definitions***%
sparams.potFile = 'Brandon_1660mV.fig';
sparams.verbose = 1; % Will display some figures to help with debugging
sparams.CMEsLib_fPath = 'C:\Users\bbuonaco\Documents\MATLAB\Silicon-Modelling\Exchange CI\CMEsOrigin_11_11.mat';

%***Geometry definitions***%
% sparams.dotLocations = [-20.0,0.0; 20,0.0]*1E-9; % Each row is a dot's
% location (x,y)
h = 2*sqrt(3);
sparams.dotLocations = [0,2/3*h;-2,-h/3;2,-h/3];
% d = 3;
% sparams.dotLocations = [d,0;3*d,0;-d,0;-3*d,0];
[sparams.nDots,~] = size(sparams.dotLocations);

%***Simulation definitions***%
% How many orbitals you will consider when buiding up the localized
% harmonic orbitals.  Up to the sparams.nLocalOrbitals-1 mode will be
% considered as you always have ground state of n = 0. 
% s-orbital = 1
% p-orbital = 2
% d-orbital = 3
% etc.
sparams.nLocalOrbitals = 1;
% Now get the full number of single electron orbitals we will consider when
% we include orbitals from all dots
sparams.nSingleOrbitals = sparams.nLocalOrbitals*(sparams.nLocalOrbitals+1)/2*sparams.nDots;
% Set the number of basis states in the itinerant basis you want to use
sparams.nItinerantOrbitals = 3;
% Sets the maximum value for the non shfited HO we will use when we rewrite
% the basis of shifted HOs into non shifted HOs
sparams.maxOriginHOsX = 14; %10; 
sparams.maxOriginHOsY = 14; %10;
sparams.nOriginHOs = sparams.maxOriginHOsX*sparams.maxOriginHOsY;

% Set tolerance level for norm checks
sparams.normThreshold = 1E-10;

sparams.numElectrons = 2;
% Used to specify which S_z spin subspaces you want to use for the many 
% body calculation. For a 3 electron system, possible S_z values are 
% [-3, -1, 1, 3]/2.  To use only the lowest two spin subspaces [-3/2, -1/2]
% set spinSubspaces = [1,2].  For all, specify spinSubSystems = 'all' or 
% spinSubspaces = [1,2,3,4]
sparams.spinSubspaces = [2];

