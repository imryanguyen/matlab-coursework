% Homework 3 problem 2
% Newton-Raphson method 
clc
close
clear 

% Functions and their derivatives
f = @(x) cos(2*x) - tan(x/3);
df = @(x) -2*sin(2*x) - (1/3)*(sec(x/3))^2;

g = @(x) 3*sin(sqrt(2*x)) - 2*(x^3);
dg = @(x) (3*2^(1/2)*cos(2^(1/2)*x^(1/2)))/(2*x^(1/2)) - 6*x^2;

% Constants
es = 0.001;
xf = 0.7;
xg = 1.1;

% Root findings using newtonraphson() function
[froot,eaf] = newtonraphson(f,df,xf,es);
[groot,eag] = newtonraphson(g,dg,xg,es);

% Approx error values
ea = [eaf eag];

% Save files
save('froot.mat', 'froot');
save('groot.mat', 'groot');
save('approx_err2.mat', 'ea');