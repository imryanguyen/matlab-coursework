%Script mfile template for Worksheet 1.1
%
%Using MATLAB to generate graphs of a decaying cosine model   
%
%   y(t) = A*exp(-k*t)*cos(w*t+phi)
%
%...add anything you want here to elaborate on these HELP COMMENTS
%%
%Define paramater values before the semicolons
A = 200;
k = 10;
w = 50;
phi = (1/2)*pi; %radians

%setup time vector, t
%enter commands here to compute the period of the oscillation 
%and set up a time vector according to the Task 1 instructions
f = w/(2*pi);
T = 1/f;
t = linspace(0,3*T,200);

y = A*exp(-k*t).*cos(w*t+phi);  %generates y data for reference plot
figure()
plot(t,y)
title('Decaying Oscillation')  %replace ? with your own title
xlabel('Time (seconds)') %replace ? with your own x-axis label
ylabel('Amplitude') %replace ? with your own y-axis label

%%
%Parameter Sensitivity Analysis
%
%Enter commands below to generate data for an additional figure that shows
%the effect of changing one or more parameters

As = 5; %smaller amplitude
ks = -10; %negative k value makes the oscillation no longer decaying

y = As*exp(-ks*t).*cos(w*t+phi);
figure()
plot(t,y)
title('Decaying Oscillation (modified A and k)') 
xlabel('t(seconds)') 
ylabel('y')

%%
%Enter commands after the figure command below to create and annotate your second
%figure per the instructions in task 2

figure()

%%
%Amplitude
A1 = [200 500 1000];

for i = 1:3
    subplot(2,2,1);
    y = A1(i)*exp(-k*t).*cos(w*t+phi);  
    hold on
    plot(t,y)  
end

title('Decaying Oscillation at Various Amplitude') 
xlabel('t(seconds)') 
ylabel('y')
legend('A = 200', 'A = 500', 'A = 1000')
hold off

%%
%Damping constant
k1 = [10 15 20];

for i = 1:3
    subplot(2,2,2);
    y = A*exp(-k1(i)*t).*cos(w*t+phi);  
    hold on
    plot(t,y)
end

title('Decaying Oscillation at Various Damping Constant') 
xlabel('t(seconds)') 
ylabel('y')
plot(t,A*exp(-k*t), 'gr--')
plot(t,-A*exp(-k*t), 'gr--')
legend('k = 10', 'k = 15', 'k = 20', 'Amplitude Envelope')
hold off

%%
%Angular frequency
w1 = [20 30 50];

for i = 1:3
    subplot(2,2,3);
    y = A*exp(-k*t).*cos(w1(i)*t+phi);  
    hold on
    plot(t,y)
end

title('Decaying Oscillation at Various Angular Frequency') 
xlabel('t(seconds)') 
ylabel('y')
plot(t,A*exp(-k*t), 'gr--')
plot(t,-A*exp(-k*t), 'gr--')
legend('w = 20 rad/s', 'w = 30 rad/s', 'w = 50 rad/s', 'Amplitude Envelope')
hold off

%%
%Phase angle
phi1 = [(1/2)*pi pi 2*pi];

for i = 1:3
    subplot(2,2,4);
    y = A*exp(-k*t).*cos(w*t+phi1(i));  
    hold on
    plot(t,y)
end

title('Decaying Oscillation at Various Phase Angle') 
xlabel('t(seconds)') 
ylabel('y')
plot(t,A*exp(-k*t), 'gr--')
plot(t,-A*exp(-k*t), 'gr--')
legend('phi = (1/2)pi rad', 'phi = pi rad', 'phi = 2pi rad', 'Amplitude Envelope')
hold off



