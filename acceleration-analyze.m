%Project 3 - main m-file
clc
clear
close

%% Getting data and given constants
load data
time = Dat(:,1);
accel = Dat(:,2);
v0 = -1.6; %m/s
s0 = 0; %m
h = (time(end)-time(1))/length(time);

%% Direct_data using cumtrapz and gradient
v_cumtrapz = v0+cumtrapz(time,accel);
s_cumtrapz = s0+cumtrapz(time,v_cumtrapz);
jerk_direct= gradient(accel,h);

%% Interpolation using spline
tt = linspace(min(time),max(time),200);
a_spline = spline(time,accel,tt);
v_spline = v0+cumtrapz(tt,a_spline);
s_spline = s0+cumtrapz(tt,v_spline);
jerk_iterpolation=gradient(a_spline,(max(tt)-min(tt))/200);

%% Nonlinear Regression curve fit using fminsearch
a_model = @(t,A,B,C,D) A.*exp(B.*t).*cos(C.*t+D);
Sr_fun = @(b,xi,yi) sum((yi-a_model(xi,b(1),b(2),b(3),b(4))).^2);
b = fminsearch(Sr_fun,[1,1,1,1],[],time,accel);
A = b(1);
B = b(2);
C = b(3);
D = b(4);

a_NR = a_model(time,A,B,C,D);
v_NR = v0+cumtrapz(time,a_NR);
s_NR = s0+cumtrapz(time,v_NR);
jerk_NR = gradient(a_NR,h);

% fit quality
Sr = sum((accel-a_model(time,A,B,C,D)).^2);
St = sum((accel-mean(accel)).^2);
r_squared = 1-Sr/St;


%% Plot data
% graph acceleration with error
figure(1)
hold on
plot(time,accel,'ob');
plot(time,a_NR,'r--');
plot(tt,a_spline,'k--');
plot(time,accel+0.5,'m');
plot(time,accel-0.5,'m');
ylabel('acceleration (m/s^2)');
xlabel('time(s)');
title(' Acceleration with Error bound');
hold off
legend('a data','a NR','a iterpolation','error boundary');

% acceleration vs time
figure(2)
subplot(221)
hold on
plot(time,accel,'ob');
plot(time,a_NR,'r--');
plot(tt,a_spline,'k--');
ylabel('acceleration (m/s^2)');
xlabel('time(s)');
title(' Acceleration analyzation');
legend('a data','a NR','a iterpolation');
hold off

% velocity vs time
subplot(222)
hold on
plot(time,v_cumtrapz,'ob');
plot(time,v_NR,'r--');
plot(tt,v_spline,'k--');
ylabel('velocity (m/s)');
xlabel('time(s)');
title(' Velocity analyzation');
legend('v cumtrapz','v NR','v iterpolation','location','southeast');
hold off

% position vs time
subplot(223)
hold on
plot(time,s_cumtrapz,'ob');
plot(time,s_NR,'r--');
plot(tt,s_spline,'k--');
ylabel('position (m)');
xlabel('time(s)');
title(' Position analyzation');
legend('s cumtrapz','s NR','s iterpolation');
hold off

% jerk vs time
subplot(224)
hold on
plot(time,jerk_direct,'b-');
plot(time,jerk_NR,'r--');
plot(tt,jerk_iterpolation,'k--');
ylabel('jerk (m/s^3)');
xlabel('time(s)');
title(' Jerk analyzation');
legend('jerk direct','jerk NR','jerk iterpolation','location','southeast');
hold off
