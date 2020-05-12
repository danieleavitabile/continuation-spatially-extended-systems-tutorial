% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function [bd,sol] = secant_continuation(fhandle,u0,pars,icp,ds,nmx)

  % Initialise variables
  ndim = size(u0,1); bd = zeros(nmx+1,3); sol = zeros(nmx+1,ndim);
  v0 = zeros(ndim+1,1); v1 = zeros(ndim+1,1); 

  % Options to the nonlinear solver
  opts = optimset('Display','off','TolFun',1e-4,'Jacobian','on');

  % Prepare screen output
  fprintf('%9s %14s %16s\n','STEP','PAR','2-NORM');

  % Converge initial guess
  v0(1:ndim) = fsolve( @(u) fhandle(u,pars), u0, opts );
  v0(ndim+1) = pars(icp);
  bd(1,:)  = [0 v0(ndim+1) norm(v0(1:ndim))];
  sol(1,:) = v0(1:ndim)';
  fprintf('%9d %14.4e %16.4e\n',bd(1,:));

  % Poor-man continuation step
  pars(icp)  = pars(icp) + ds/sqrt(ndim); 
  v1(1:ndim) = fsolve( @(u) fhandle(u,pars), v0(1:ndim), opts );
  v1(ndim+1) = pars(icp);
  bd(2,:)  = [1 v1(ndim+1) norm(v1(1:ndim))];
  sol(2,:) = v1(1:ndim)';
  fprintf('%9d %14.4e %16.4e\n',bd(2,:));

  % Initalise secant continuation
  ds = abs(ds);

  % Start secant continuation
  for n = 2:nmx

    % Prediction in the secant direction
    sec = (v1-v0)/norm(v1-v0); v = v1 + ds * sec;

    % Correction with Newton iteration
    v = fsolve( @(z) secant_corrector(z), v, opts );

    % Book-keeping
    v0 = v1; v1 = v; 
    bd(n+1,:)  = [n v(ndim+1) norm(v(1:ndim))];
    sol(n+1,:) = v(1:ndim)';

    % Print 
    fprintf('%9d %14.4e %16.4e\n',bd(n+1,:));

  end

  function [G,DG] = secant_corrector(z)

    % Compute F
    pars(icp) = z(ndim+1); F = fhandle(z(1:ndim),pars);

    % Extended system
    G = [F; sec' * (z-v1) - ds];
    
    if nargout > 1

      % Jacobian of F
      [F,DFDU] = fhandle(z(1:ndim),pars);

      % Derivative with respect to p
      epsi = 1e-4; pars(icp) = z(ndim+1) + epsi;
      DF = fhandle(z(1:ndim),pars); DFDP = (DF - F)/epsi;

      % Jacobian of the extended system
      DG = [DFDU, DFDP; sec'];

    end

  end

end
