% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function F = NeuralField(u,p,W);

  % Rename parameters 
  h    = p(1);
  beta = p(2);

  % Compute S
  S = FiringRate(u,h,beta);

  % Right-hand side
  F = -u + W*S;

end
