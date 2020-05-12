% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [L,Dxx] = LinearOperators(x,bConds);

  % Rename parameters
  nx = length(x);
  hx = x(2) - x(1);

  % Differentiation matrix in x: finite differences with Neumann BCs
  e = ones(nx,1); Dxx = spdiags([e -2*e e], -1:1, nx, nx);
  if strcmp(bConds,'neumann')
    Dxx(1,2) = 2; Dxx(nx,nx-1) = 2; 
  elseif strcmp(bConds,'periodic')
    Dxx(1,nx) = 1; Dxx(nx,1) = 1; 
  else
    error('bConds must be ''neumann'' or ''periodic''');
  end
  
  Dxx = Dxx/hx^2; Ix = speye(nx);

  % Linear SH operator L = -(id+Laplace)^2
  L  = -( speye(nx) + Dxx )^2;

end

