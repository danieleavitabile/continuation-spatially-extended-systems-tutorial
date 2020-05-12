% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [V,LAMBDA] = ComputeSpectrum(u,p,L);

  %% Compute linear operators
  [~,J] = SwiftHohenberg35(u,p,L);

  % %% Call iterative eigenvalue solver
  % eigsOpts.disp = 0;
  % [V,LAMBDA] = eigs(J,M,10,'lr',eigsOpts);

  %% Call direct eigenvalue solver
  [V,LAMBDA] = eig(full(J));

end
