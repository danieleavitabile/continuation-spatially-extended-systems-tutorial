% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [V,LAMBDA] = ComputeSpectrumTW(v,p,W,Dx,uRef,duRef);

  %% Compute linear operators
  [~,DG] = NeuralFieldTW(v,p,W,Dx,uRef,duRef);

  %% Call direct eigenvalue solver on the relevant part of the Jacobian
  [V,LAMBDA] = eig(DG(1:end-1,1:end-1));

end
