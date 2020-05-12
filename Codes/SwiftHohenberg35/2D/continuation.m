% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

% Cleaning
close all, clear all, clc;

% Spatial coordinates: x direction
nx = 800; Lx = 50; hx = Lx/(nx-1); 

% Differentiation matrix in x: finite differences
e = ones(nx,1); Dxx = spdiags([e -2*e e], -1:1, nx, nx);
Dxx(1,2) = 2; Dxx(nx,nx-1) = 2; Dxx = Dxx/hx^2; Ix = speye(nx);

% Spatial discretisation in y
ny = 8; m = 2*(ny-1); hy = 2*pi/m; m2 = m/2; 

% Fourier differentiation matrix for y between -pi and pi
Dyy = toeplitz([-pi^2/(3*hy^2)-1/6 .5*(-1).^(2:m)./sin(hy*(1:m-1)/2).^2]);

% Rewrite differentiation matrix for y between 0 and pi
Iy = speye(ny); Z = zeros(m2+1,1);
Dyy = Dyy(m2:m,m2:m) + [Z Dyy(m2:m,m2-1:-1:1) Z];

% Linear SH operator L = -(id+Laplace)^2
L  = -( speye(nx*ny) + kron(Ix,Dyy) + kron(Dxx,Iy) )^2;

% Initial condition
sol = load('initialGuess.mat'); u0 = sol.u; p0 = sol.p; 

% SH function handle
sh = @(u,p) SwiftHohenberg35(u,p,L);

% Continuation and bifurcation diagram plot
[bd,sol] = secantContinuation(sh,u0,p0,1,0.6,40); plot(bd(:,2), bd(:,3),'.-');

% Plot bifurcation diagram
i1 = 0; i2 = 40;
subplot(2,3,[1 4]); hold on; grid on;
title('Bifurcation diagram');
plot(bd(:,2),  bd(:,3), '.-');
plot(bd(i1+1,2), bd(i1+1,3),'r.','MarkerSize',20);
plot(bd(i2+1,2), bd(i2+1,3),'r.','MarkerSize',20);                 
text(bd(i1+1,2), bd(i1+1,3),num2str(i1),'VerticalAlignment','bottom');
text(bd(i2+1,2), bd(i2+1,3),num2str(i2),'VerticalAlignment','bottom');
xlabel('nu'); ylabel('norm u'); xlim([0.61 0.73]);
  
% Plot first pattern of the branch
subplot(2,3,[5 6]);
u = reshape(sol(i1+1,:),ny,nx);
u = [u(:,nx:-1:2) u]; u = [u(ny:-1:2,:); u]; u = [u; u; u; u];
x = linspace(-Lx,Lx,2*nx-1); y = linspace(-4*pi,4*pi,8*ny-4); 
[xx,yy] = meshgrid(x,y);
surf(xx,yy,u); shading interp; view([0 90]); %set(gca,'Visible','off');
title(['Solution ' num2str(i1)]);

% Plot last pattern of the branch
subplot(2,3,[2 3]); 
u = reshape(sol(i2+1,:),ny,nx);
u = [u(:,nx:-1:2) u]; u = [u(ny:-1:2,:); u]; u = [u; u; u; u];
surf(xx,yy,u); shading interp; view([0 90]); %set(gca,'Visible','off');
title(['Solution ' num2str(i2)]);
