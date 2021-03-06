% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

% Cleaning 
clear all, close all, clc;

% Load problem files
addpath('../ProblemFiles');

% Linear operators and grid
% nx = 2^10; Lx = 100; [~,~,~,x,W]=LinearOperators(nx,Lx);
nx = 2^9; Lx = 50; [~,~,~,x,W]=LinearOperators(nx,Lx);

% Initial condition
u0   = (-10 < x) .* (x < 10);
p(1) = 0.3; % h
p(2) = 20;  % beta

% Plot initial solution
parent = PlotSolution(x,u0,p,[]);

% Define handle to right-hand side and time output function
prob = @(t,u) NeuralField(u,p,W);
timeOut = @(t,u,flag) TimeOutput(t,u,flag,true,x,p,parent);

% Time step 
tSpan = [0:0.1:60]; opts = odeset('OutputFcn',timeOut);
[t,U] = ode45(prob,tSpan,u0,opts);

% Plot history
PlotHistory(x,t,U,p,[]);

% Save
u = U(end,:)'; 
save('travellingWaveHistory.mat','x','t','U','p'); 
save('travellingWaveProfile.mat','u','p');
