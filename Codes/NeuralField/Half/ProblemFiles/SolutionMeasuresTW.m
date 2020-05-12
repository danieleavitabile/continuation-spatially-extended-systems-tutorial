% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function F = SolutionMeasuresTW(step,v,p,x)

  %% Rename parameters
  Lx = x(end)-x(1); 
  hx = abs(x(2)-x(1));

  %% Split solution
  u = v(1:end-1);
  c = v(end);

  %% Compute quadrature weights and l2norm
  w = ones(size(u)); w(1) = 0.5; w(end) = 0.5; 
  l2Norm = sum( hx * w .* u.^2)/Lx;

  %% Allocate
  F = zeros(1,2);

  %% Assign branch variables
  F = [c l2Norm];
  
end
