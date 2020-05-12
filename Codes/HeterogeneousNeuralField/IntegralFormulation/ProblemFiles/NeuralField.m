% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [F,Jv] = NeuralField(u,p,wHat,x,Lx,v);

  % Rename parameters
  mu     = p(1);
  a      = p(2);
  b      = p(3);
  lambda = p(4);
  h      = p(5);
  nx   = size(u,1);

  % Heterogeneity
  alpha = (a + b*cos(x/lambda));

  % Firing rate function (eventually compute derivative)
  if nargout > 1 && ~isempty(v)
    [s,ds] = FiringRate(u,mu,h);
  else
    s = FiringRate(u,mu,h);
  end
  sHat = fft(s.*alpha);

  % Right-hand side
  F = -u + (2*Lx/nx)*ifftshift(real(ifft(sHat .* wHat)));

  % Jacobian action
  if nargout > 1 && ~isempty(v)
    dsHat = fft(ds.*alpha.*v);
    Jv = - v + (2*Lx/nx)*ifftshift(real(ifft(dsHat .* wHat)));
  end

end
