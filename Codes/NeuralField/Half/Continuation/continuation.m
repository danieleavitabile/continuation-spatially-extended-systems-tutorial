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

addpath('../ProblemFiles');

%% Spatial grid and linear operators
nx = 2^9; Lx = 50; 
[~,~,~,x,W,Dx]=LinearOperators(nx,Lx);
% nx = 2^10; Lx = 100; [~,~,~,x,W,Dx]=LinearOperators(nx,Lx);

%% Load initial guess and parameters
sol = load('travellingWave_Lx_50.mat'); v0 = sol.v; p0 = sol.p;
% sol = load('travellingWave_Lx_100.mat'); v0 = sol.v; p0 = sol.p;

%% Reference solution 
uRef = v0(1:end-1); duRef = Dx*uRef;

%% Define handle to right-hand side and time output function
prob     = @(v,p) NeuralFieldTW(v,p,W,Dx,uRef,duRef);
plotSol  = @(v,p,parent) PlotSolutionTW(x,v,p,parent);
solMeas  = @(step,v,p) SolutionMeasuresTW(step,v,p,x);
compSpec = @(v,p) ComputeSpectrumTW(v,p,W,Dx,uRef,duRef);
plotSpec = @(lambda,p,parent) PlotSpectrum(lambda,p,parent);

%% Assign problem 
stepPars.iContPar             = 1;
stepPars.pMin                 = 0;
stepPars.pMax                 = 8;
stepPars.s0                   = 0.02;
stepPars.sMin                 = 0.001;
stepPars.sMax                 = 0.1;
stepPars.maxSteps             = 20000;
stepPars.nPrint               = 1;
stepPars.nSaveSol             = 1;
stepPars.finDiffEps           = 1e-7;
stepPars.fsolveOptions        = optimset('Display','off',...
                                         'TolFun',1e-4,...
                                         'MaxIter',5,...
                                         'Jacobian','on');
stepPars.optNonlinIter        = 5;
stepPars.dataFolder           = 'Data';
stepPars.PlotSolution         = plotSol;
stepPars.BranchVariables      = solMeas;
stepPars.PlotBranchVariableId = 1;
stepPars.ComputeEigenvalues   = compSpec;
stepPars.PlotSpectrum         = plotSpec;

%% Run
branch = SecantContinuation(prob,v0,p0,stepPars);
