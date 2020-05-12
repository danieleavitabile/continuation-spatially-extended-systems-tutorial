% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [V,D] = ComputeSpectrum(u,p,wHat,x,Lx);

  %% Linear function handle
  jhandle = @(v) NeuralFieldJacobian(u,p,wHat,x,Lx,v);

  %% Call eigenvalue solver
  eigsOpts = [];

  [V,D,flag] = eigs(jhandle,size(u,1),10,'lr');

  if flag ~= 0
    warning('Not all eigenvalues converged');
  end

end
