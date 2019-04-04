% Homework 3 problem 1 - part 1
% Root finding using bisection method
clc
clear
close

% Parameters and constants 
p = 1:0.1:6;
K = 0.06;
es = 1e-5;
xl = 0.01;
xu = 0.2;

% Main function
fun = @(x,p) (x/(1-x))*sqrt(2*p/(2+x)) - K;

% Output vectors
x = zeros(1, length(p));
ea = zeros(1, length(p));
iter = zeros(1, length(p));

for ndx = 1:length(p)
    [x(ndx),ea(ndx),iter(ndx)] = bisect_param(fun,xl,xu,es,[],p(ndx));
end

% Transpose to make column vectors
x = x';
ea = ea';
iter = iter';

% Save .mat files
save('x1.mat', 'x');
save('approx_err1.mat', 'ea');
save('iter.mat', 'iter');