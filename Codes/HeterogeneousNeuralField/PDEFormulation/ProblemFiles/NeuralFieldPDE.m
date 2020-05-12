% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [F,J,JE,M] = NeuralFieldPDE(u,p,x,L);

  %% Rename parameters
  k    = p(1);
  h    = p(2);
  mu   = p(3);
  epsi = p(4);
  a    = p(5);
  Lx   = p(6);
  phi  = p(7);
  A0   = p(8);
  delta = p(9);
  nx   = size(u,1);

  %% Firing rate function
  f  = @(u) 1./(1+exp( -mu*(u-h) ));
  df = @(u) mu*f(u).*(1-f(u));

  %% Compute A
  A = A0 + a*cos(x/epsi+phi) + delta*x;

  %% Right-hand side for u
  F = L*u + 2*k*A.*f(u);

  %% Jacobian
  if nargout > 1
    J = L + spdiags(2*k*A.*df(u),0,nx,nx);
  end

  %% Stability operators (with mass matrix)
  if nargout > 2
    JE = J;
    M  = -L;
  end

end

%
