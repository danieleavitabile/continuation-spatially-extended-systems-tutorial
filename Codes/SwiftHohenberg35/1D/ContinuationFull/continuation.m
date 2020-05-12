% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

%% Clean
clear all, close all, clc;

%% Load folders
addpath('../../../SecantContinuation/0.2/src');
addpath('../ProblemFiles');
addpath('../SolutionDatabase');

%% Spatial coordinates: x direction
bConds = 'periodic'; nx = 400; Lx = 50; hx = 2*Lx/nx; x = -Lx +[0:nx-1]*hx;

%% Get linear operators
L = LinearOperators(x,bConds);

%% Load initial guess and parameters
sol = load('stableSolution.mat'); u0 = sol.u; p0 = sol.p;

%% Define handle to right-hand side and time output function
prob     = @(u,p) SwiftHohenberg35(u,p,L);
plotSol  = @(u,p,parent) PlotSolution(x,u,p,parent,false);
solMeas  = @(step,u,p) SolutionMeasures(step,u,p,x,bConds);
compSpec = @(u,p) ComputeSpectrum(u,p,L); 
plotSpec = @(lambda,p,parent) PlotSpectrum(lambda,p,parent);


%% Assign problem 
stepPars.iContPar             = 1;
stepPars.pMin                 = 0;
stepPars.pMax                 = 8;
stepPars.s0                   = -0.2; %-0.05;
stepPars.sMin                 = 0.001;
stepPars.sMax                 = 0.3; % 0.05;
stepPars.maxSteps             = 20000;
stepPars.nPrint               = 1;
stepPars.nSaveSol             = 1;
stepPars.finDiffEps           = 1e-7;
stepPars.fsolveOptions        = optimset('Display','off',...
                                         'TolFun',1e-4,...
                                         'MaxIter',10,...
                                         'Jacobian','on');
stepPars.optNonlinIter        = 5;
stepPars.dataFolder           = 'Data';
stepPars.PlotSolution         = plotSol;
stepPars.BranchVariables      = solMeas;
stepPars.PlotBranchVariableId = 1;
stepPars.ComputeEigenvalues   = compSpec;
stepPars.PlotSpectrum         = plotSpec;

%% Run
branch = SecantContinuation(prob,u0,p0,stepPars);
