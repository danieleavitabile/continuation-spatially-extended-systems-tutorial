% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function F = SolutionMeasures(step,u,p,x,bConds)

  %% Rename parameters
  Lx = max(x);
  hx = abs(x(2)-x(1));

  %% Compute quadrature weights and l2norm
  w = ones(size(u)); 
  if ~strcmp(bConds,'periodic')
    w(1) = 0.5; w(end) = 0.5; 
  end
  l2Norm = sum( hx * w .* u.^2)/(2*Lx);

  %% Allocate
  F = zeros(1,3);

  %% Assign branch variables
  F = [l2Norm max(u) min(u)];
  
end
