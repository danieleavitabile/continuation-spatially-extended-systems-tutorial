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
nx = 1000; Lx = 30; hx = 2*Lx/nx; x = -Lx +[0:nx-1]'*hx;

% Synaptic kernel
w = @(x) 0.5*exp(-abs(x));
wHat = fft(w(x));

% Load initial conditions and parameters
sol = load('localisedSolution.mat');
u0  = sol.u;
p0  = sol.p;

% Plot initial solution
PlotSolution(x,u0,p0,[],false);

% Define handle to right-hand side, jacobian and time output function
prob     = @(u,p) NeuralField(u,p,wHat,x,Lx,[]);
jac      = @(u,p,v) NeuralFieldJacobian(u,p,wHat,x,Lx,v);
plotSol  = @(u,p,parent) PlotSolution(x,u,p,parent,false);
solMeas  = @(step,u,p) SolutionMeasures(step,u,p,x,'periodic');
compSpec = @(u,p) ComputeSpectrum(u,p,wHat,x,Lx);
plotSpec = @(lambda,p,parent) PlotSpectrum(lambda,p,parent);

%% Assign problem 
stepPars.iContPar                         = 5;
stepPars.pMin                             = 0;
stepPars.pMax                             = 8;
stepPars.s0                               = -0.1;
stepPars.sMin                             = 0.001;
stepPars.sMax                             = 0.2;
stepPars.maxSteps                         = 20000;
stepPars.nPrint                           = 1;
stepPars.nSaveSol                         = 1;
stepPars.finDiffEps                       = 1e-7;
stepPars.optNonlinIter                    = 5;
stepPars.NewtonGMRESOptions.nonlinTol     = 1e-3;
stepPars.NewtonGMRESOptions.nonlinMaxIter = 10;
stepPars.NewtonGMRESOptions.linTol        = 1e-3;
stepPars.NewtonGMRESOptions.linrestart    = 20;
stepPars.NewtonGMRESOptions.linmaxit      = 10;
stepPars.NewtonGMRESOptions.damping       = 1.0;
stepPars.NewtonGMRESOptions.display       = 0;
stepPars.dataFolder                       = 'Data';
stepPars.PlotSolution                     = plotSol;
stepPars.BranchVariables                  = solMeas;
stepPars.PlotBranchVariableId             = 1;
stepPars.ComputeEigenvalues               = compSpec;
stepPars.PlotSpectrum                     = plotSpec;

%% Run
branch = SecantContinuationNewtonGMRES(prob,jac,u0,p0,stepPars);
