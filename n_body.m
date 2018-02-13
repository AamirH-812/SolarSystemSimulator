% Hello and welcome to my Solar System Simulator! This program takes data 
% from Excel spreadsheets and plots the orbits of the 8 planets, Sun 
% and Pluto. It consists of this main program (n_body.m), the solver
% function (solsym_n.m) and a calculation function (rate_of_change.m)
% The data can be edited to emulate the orbits of other objects 
% if needed. 
% 
% The data stored in initial_positions.xlsx is of the form 
% [x y z dx dy dz]
% where x,y and z are the positions in the respective co-ordinate systems
% measured in AU (w.r.t the centre of mass of the solar system) and dx, dy
% and dz are the velocities in units of AU/day. These values are taken from
% NASA's JPL. Each new row gives the data for another object.
%
% The data stored in GM.xls is the values of the gravitational constant
% multiplied by the mass of the body, in units of AU^3/yr^2 (this is to
% allow Matlab to process the data more easily).
% 
% To use, ensure data is inputted correctly in the Excel Files and run from
% the main program


body=xlsread("initial_positions.xlsx");  %reads data from Excel Files
GM=xlsread("GM.xlsx");
n=numel(body)/6;  %This gives the number of bodies

[path, t] = solsym_n(body,0,365*300,GM,n); 
% This calls the solver function, change the second and third number inside 
% the brackets to set the time the orbits will be calculated for.


x=1;

for i=1:n     %this iterates over path and plots the 1st, 2nd and 3rd value of path for each planet corresponding to it's x,y and z position.
   
    plot3(path(:,x),path(:,x+1),path(:,x+2));
    hold on; 
   

    x=x+6;
end
axis('equal') %axis setting to equal