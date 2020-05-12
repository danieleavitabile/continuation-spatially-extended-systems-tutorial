% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [V,D] = ComputeSpectrum(u,p,x,L)

  %% Compute linear operators
  [F,J,JE,M] = NeuralFieldPDE(u,p,x,L);

  %% Call eigenvalue solver
  eigsOpts.disp = 0;
  [V,D] = eigs(JE,M,5,'la',eigsOpts);

end
