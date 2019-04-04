%This is a random workspace to test stuffs.
%%
%Clear everything before program starts.
clear 
close
clc

%Function has to be the same name as m-file.
%Functions should avoid MATLAB built-ins.

%Variables need semicolons
n = 100;


v = zeros(1,n);
for i = 1:2:n
    v(i)= 5*i;
end

%The figure number will be labeled automatically
figure()

