% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

% Clear
clear all, close all, clc;

% Load directories
addpath('../SolutionDatabase');

% Load history
sol = load('travellingWaveHistory.mat');
U = sol.U; p = sol.p; t = sol.t; x = sol.x;

deltaT = 10;
id = find( t(end)-deltaT <= t & t <= t(end) );
tIni = t(id(1)); tEnd = t(id(end));
uIni = U(id(1),:)'; uEnd = U(id(end),:)';

h = 0.5;
id = find( uIni >= h ); xIni = x(id(end));
id = find( uEnd >= h ); xEnd = x(id(end));

figure; plot(x,uIni,x,h*ones(size(x)),'.-');
figure; plot(x,uEnd,x,h*ones(size(x)),'.-');

c = (xEnd-xIni)/deltaT;
disp(['Estimated speed c = ', num2str(c)]);

tProf = 50;
id = find(t <= tProf );
uProf = U(id(end),:)';
v = [uProf; c];
save('travellingWave.mat','v','p');
figure; plot(x,uProf,x,h*ones(size(x)),'.-');
