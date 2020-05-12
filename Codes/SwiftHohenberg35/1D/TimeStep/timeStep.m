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

% Spatial coordinates: x direction
bConds = 'periodic'; nx = 400; Lx = 50; hx = 2*Lx/nx; x = -Lx +[0:nx-1]*hx;

% Get linear operators
L = LinearOperators(x,bConds);

% Load initial conditions and parameters
u0  = (-tanh(x-8) + tanh(x+8)).*cos(x)+2.0;
p0(1) = 1.5; % mu 
p0(2) = 3.0; % nu

% Plot initial solution
PlotSolution(x,u0,p0,[],false);

% Define handle to right-hand side and time output function
prob = @(t,u) SwiftHohenberg35(u,p0,L);
timeOut = @(t,u,flag) TimeOutput(t,u,flag);

% Time step 
tSpan = [0:0.1:20]; opts = odeset('OutputFcn',timeOut);
[t,U] = ode45(prob,tSpan,u0,opts);

% Plot final solution
PlotSolution(x,U(end,:)',p0,[],false);

% Plot history
PlotHistory(x,t,U,p0,[]);
