% Copyright 2016 by Daniele Avitabile
% See https://www.maths.nottingham.ac.uk/personal/pmzda/
%
% If you use this code, please cite
% Daniele Avitabile, "Numerical computation of coherent structures in
% spatially-extended neural networks", Second International Conference on
% Mathematical Neuroscience, Antibes Juan-les-Pins, 2016

function status = TimeOutput(t,u,flag,plotSol,x,p,parent) 

  if isempty(flag)
    disp(['t = ' num2str(max(t))]);
    if plotSol
      PlotSolution(x,u(:,end),p,parent);
      drawnow;
    end
  end
  status = 0;

end

