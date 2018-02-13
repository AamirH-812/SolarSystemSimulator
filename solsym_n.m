function [path, t] = solsym_n(X,t0,tf,GM,n)
% This is the function that sets up and calls the ODE solver. It takes the
% matrices body and GM we defined in the main program along with initial
% and final t values and the number of bodies. 

tol_new = [1e-11 1e-11 1e-11 1e-16 1e-16 1e-16]; 
tol=0;
for i=1:n  %this sets up an array of tolerance values that work for our values
  tol=horzcat(tol,tol_new);
end  
tol=tol(2:end);


options = odeset('InitialStep', 0.1, 'MaxStep', 50, 'Stats','off', 'RelTol', 1e-12, 'AbsTol', tol );

% call the ode45 function to solve our differential equations, can use
% other ODE solvers if you wish.

X=reshape(X',[numel(X),1]); %ode45 only takes column vectors, this reshapes X to be a column vector.

[t, path] = ode45(@rate_of_change_n, [t0 tf], X, options,GM,n);  %calls the ode solver eith parameters shown, rate of change gives DX.
end
