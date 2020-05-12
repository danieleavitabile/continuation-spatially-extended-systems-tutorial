% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [F,DF] = NeuralField(u,p,W);

  %% Rename parameters 
  h    = p(1);
  beta = p(2);
  nx   = size(u,1);

  %% Compute firing rate (eventually its derivative)
  if nargout > 1
    [S,DS] = FiringRate(u,h,beta);
  else
    S = FiringRate(u,h,beta);
  end

  %% Right-hand side
  F = zeros(nx,1);
  F = -u + W*S;

  %% Eventually compute jacobian
  if (nargout > 1)
    DF = -eye(nx) + W*diag(DS);
  end

end
