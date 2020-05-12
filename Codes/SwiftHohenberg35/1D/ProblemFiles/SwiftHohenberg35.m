% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [F,J] = sh35(u,p,L)

  % Rename parameters
  mu = p(1); nu = p(2); n = size(u,1);

  % Right-hand side
  F =  L*u -mu*u + nu*u.^3 - u.^5;

  % Jacobian
  if nargout > 1
     J = L + spdiags( -mu + 3*nu*u.^2 - 5*u.^4, 0, n, n);
  end

end
