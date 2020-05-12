% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [G,DG] = NeuralFieldTW(v,p,W,Dx,uRef,duRef);

  %% Rename parameters
  nx = size(v,1)-1; iU = 1:nx; iC = nx+1;
  u = v(iU); c = v(iC);

  %% Neural field right-hand side (and eventually Jacobian)
  if nargout > 1
    [F,DF] = NeuralField(u,p,W);
  else
    F = NeuralField(u,p,W);
  end

  %% Right-hand side
  G = zeros(nx+1,1);
  G(iU) = c*Dx*u + F;
  G(iC) = duRef'*(u-uRef);

  %% Eventually compute Jacobian
  if nargout > 1
    DG = zeros(nx+1);
    DG(iU,iU) = DF + c*Dx;
    DG(iU,iC) = Dx*u;
    DG(iC,iU) = duRef';
  end

end
