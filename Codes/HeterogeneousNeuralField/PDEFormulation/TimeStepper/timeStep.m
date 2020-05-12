% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

% Cleaning 
clear all, close all, clc;

% Load problem files and solution
addpath('../ProblemFiles');
addpath('../SolutionDatabase');

% Spatial coordinates: x direction
bConds = 'periodic'; nx = 1000; Lx = 30; hx = 2*Lx/nx; x = -Lx +[0:nx-1]'*hx;

% Get linear operators
[L,M,~] = LinearOperators(x,bConds);

% Load initial conditions and parameters
sol = load('nonlocalisedSolution.mat');
u0  = sol.u .* (-12 <= x & x <= 12);
p0  = sol.p;
p0(2) = 0.5; p0(9) = 0;

% Plot initial solution
PlotSolution(x,u0,p0,[],false);

% Define handle to right-hand side, jacobian and time output function
prob    = @(t,u) NeuralFieldPDE(u,p0,x,L);
jac     = @(t,u) NeuralFieldPDEJacobian(u,p0,x,L);
timeOut = @(t,u,flag) TimeOutput(t,u,flag);

% Integrate ODE
options = odeset('Mass',M,'Jacobian',jac,'OutputFcn',timeOut);
[t,U] = ode23s(prob,[0 100],u0,options);

% Plot final solution
PlotSolution(x,U(end,:)',p0,[],false);

% Plot history
PlotHistory(x,t,U,p0,[]);

% % Save
% p = p0;
% u = U(end,:)';
% save('finalState.mat','u','p');
