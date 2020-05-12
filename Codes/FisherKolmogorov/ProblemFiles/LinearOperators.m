% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [Dx,Dxx,xI] = LinearOperators(x);

  % Rename parameters
  nxi = length(x)-2; hx = x(2) - x(1);

  % Ancillary vector of ones
  e = ones(nxi,1); 

  % Differentiation matrix in x: finite differences with Dirichlet BCs
  Dx = spdiags([-e e], [-1 1], nxi, nxi); Dx = Dx/(2*hx);

  % Differentiation matrix in x: finite differences with Dirichlet BCs
  Dxx = spdiags([e -2*e e], -1:1, nxi, nxi); Dxx = Dxx/hx^2;

  %% Interior grid
  xI = x(2:nxi+1);

end

