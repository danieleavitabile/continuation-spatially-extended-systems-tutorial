% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

% Cleaning 
clear all, close all, clc;

%% Load folders
addpath('../../../SecantContinuation/0.2/src');
addpath('../ProblemFiles');
addpath('../SolutionDatabase');

% Spatial coordinates: x direction
bConds = 'periodic'; nx = 1000; Lx = 30; hx = 2*Lx/nx; x = -Lx +[0:nx-1]'*hx;

% Get linear operators
[L,M,~] = LinearOperators(x,bConds);

% Load initial conditions and parameters
sol = load('localisedSolution.mat');
u0  = sol.u;
p0  = sol.p;

% Plot initial solution
PlotSolution(x,u0,p0,[],false);

% Define handle to right-hand side, jacobian and time output function
prob     = @(u,p) NeuralFieldPDE(u,p,x,L);
plotSol  = @(u,p,parent) PlotSolution(x,u,p,parent,false);
solMeas  = @(step,u,p) SolutionMeasures(step,u,p,x,bConds);
compSpec = @(u,p) ComputeSpectrum(u,p,x,L);
plotSpec = @(lambda,p,parent) PlotSpectrum(lambda,p,parent);

%% Assign problem 
stepPars.iContPar             = 2;
stepPars.pMin                 = 0;
stepPars.pMax                 = 8;
stepPars.s0                   = -0.1;
stepPars.sMin                 = 0.001;
stepPars.sMax                 = 0.3;
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
