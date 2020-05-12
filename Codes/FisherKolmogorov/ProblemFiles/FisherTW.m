% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [G,DG] = FisherTW(v,p,Dx,Dxx,x,uRef,duRef)

  % Rename parameters
  d  = p(1);
  r  = p(2);
  k  = p(3);
  uL = p(4);
  uR = p(5);
  hx = x(2) - x(1);

  % Number of points in the interior, ancillary indices
  nxi = size(v,1)-1;  iU = 1:nxi; iC = nxi+1; iB = [1 nxi];

  % Split components
  u = v(iU); c = v(iC);

  % Compute Fisher right-hand side
  [F,~] = Fisher(u,p,Dxx,x);

  % Travelling wave right-hand side 
  G = zeros(size(v));
  G(iU) = F + c*Dx*u; G(iB) = G(iB) + c*[-uL; uR]/(2*hx);
  G(iC) = duRef'*(u-uRef);

end
