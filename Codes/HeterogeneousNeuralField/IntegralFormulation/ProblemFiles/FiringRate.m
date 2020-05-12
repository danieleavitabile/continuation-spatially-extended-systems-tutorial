% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [S,DS] = FiringRate(u,mu,h);

  %% Compute firing rate
  S = 1./(1+exp(-mu*(u-h)));
  
  %% Eventually compute derivative
  if (nargout > 1)
    DS = mu*S.*(1-S);
  end

end
