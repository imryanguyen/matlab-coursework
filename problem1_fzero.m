% Homework 3 problem 1 - part 2
% Root finding using fzero 
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
x = zeros(1,length(p));
ea = zeros(1,length(p));

%Options for fzero
options = optimset('Tolx',1e-5);

for ndx = 1:length(p)
    [x(ndx),ea(ndx)] = fzero(@(x) fun(x,p(ndx)), [xl xu], options);
end

% Transpose to make column vectors
x = x';
ea = ea';

% Save .mat files
save('x2.mat', 'x');
save('resid.mat', 'ea');
