% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [F,J] = Fisher(u,p,Dxx,x)

  % Rename parameters
  d  = p(1);
  r  = p(2);
  k  = p(3);
  uL = p(4);
  uR = p(5);
  hx = x(2) - x(1);

  % Number of points in the interior, boundary indices
  nxi = size(u,1); iB = [1 nxi];

  % Right hand side (including boundary conditions)
  F = d * Dxx * u + r * u .* (1-u/k);
  F(iB) = F(iB) + [uL; uR]/hx^2;

  % Eventually compute Jacobian
  if nargout > 1
    J = d * Dxx + spdiags(r - 2 * r/k * u,0,nxi,nxi);
  end

end
