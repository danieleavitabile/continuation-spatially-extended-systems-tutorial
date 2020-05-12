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
addpath('../ProblemFiles');
addpath('../SolutionDatabase');

%% Spatial coordinates: x direction
bConds = 'periodic'; nx = 400; Lx = 50; hx = 2*Lx/nx; x = -Lx +[0:nx-1]*hx;

%% Get linear operators
L = LinearOperators(x,bConds);

%% Load initial guess and parameters
sol = load('saddleNodeSolution.mat'); 

%% Prepare weights for normalisation
hx = abs(x(2)-x(1)); w = ones(nx,1); w(1) = 0.5; w(end) = 0.5; 

[~,id] = sort(real(sol.d),'descend');
d = sol.d(id); W = sol.W(:,id);

%% Plot eigenfunction
figure;
for i = 1:4
  subplot(4,1,i); 
  lambda = d(i); psi = W(:,i); l2Norm = sqrt(sum( hx * w .* psi.^2)/(2*Lx)); psi = psi/l2Norm;
  plot(x,psi,'.-'); title (['\lambda = ' num2str(lambda)]);
end
