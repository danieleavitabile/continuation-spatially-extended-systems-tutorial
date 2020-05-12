% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [x,W,Dx,xH,WH,DxH] = LinearOperators(nx,Lx);

  %% Number of nodes must be even
  if mod(nx,2) ~= 0
    error('nx must be even');
  end

  %% Grid parameters
  hx = 2*Lx/(nx-1); x = -Lx + [0:nx-1]'*hx; 
  
  %% Synaptic kernel function
  wFun = @(x) 0.5*exp(-abs(x));

  %% Integration weights
  rho = ones(size(x)); rho(1) = 0.5; rho(nx) = 0.5; rho = rho*hx;

  %% Synaptic matrix
  W = zeros(nx);
  for i = 1:nx
    for j = 1:nx
      W(i,j) = rho(j)*wFun(x(i) - x(j));
    end
  end

  %% Ancillary vector of ones for differentiation matrix
  e = ones(nx,1); 

  %% Differentiation matrix in x: finite differences
  Dx = spdiags([-e e], [-1 1], nx, nx); Dx = Dx/(2*hx);

  %% Half domain
  iH = nx/2+1:nx; xH = x(iH);

  %% Reflect W
  WH = W(iH,iH) + W(nx/2:-1:1,iH);

  %% Impose Neumann BCs for Dx
  e = ones(nx/2,1); 
  DxH = spdiags([-e e], [-1 1], nx/2, nx/2); DxH(1,:) = 0; DxH = DxH/(2*hx);

end

