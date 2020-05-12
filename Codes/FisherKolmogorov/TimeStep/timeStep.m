% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

%% Cleaning
clear all, close all, clc;

%% Load folders
addpath('../ProblemFiles');

%% Spatial grid 
nx = 1200; Lx = 75; hx = 2*Lx/(nx-1); x = [-Lx:hx:Lx]';

% Linear operator
[~,Dxx,xI] = LinearOperators(x);

%% Load initial conditions and parameters
u0  = 0.5*(1-tanh(xI+15));
p0(1) = 1.0; % d
p0(2) = 1.0; % r
p0(3) = 1.0; % k
p0(4) = 1;   % uL
p0(5) = 0;   % uR

%% Plot initial solution
parent = PlotSolution(x,u0,p0,[]);

%% Define handle to right-hand side and time output function
prob    = @(t,u) Fisher(u,p0,Dxx,x);
jac     = @(t,u) FisherJacobian(u,p0,Dxx,x);
timeOut = @(t,u,flag) TimeOutput(t,u,flag,true,x,p0,parent);

%% Time step 
tSpan = [0:0.1:15]; opts = odeset('OutputFcn',timeOut,'Jacobian',jac);
[t,U] = ode23s(prob,tSpan,u0,opts);

% Plot history
PlotHistory(x,t,U,p0,[]);

% Save
p = p0; u = U(end,:)'; 
save('travellingWaveHistory.mat','x','t','U','p'); 
save('travellingWaveProfile.mat','u','p');
