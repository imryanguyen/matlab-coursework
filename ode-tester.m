clc
clear 
close

%% Constants
S0=0.999999;
I0=1.0e-6;
R0=0;
T=12;
beta0=3.0;
mu=0.1;
gamma=1.5;
tspan=[0 48];
h=0.2;
es=1.0e-6;
y0=[0.999999 1.0e-6 0];

dydt= @(t,y,T,gamma,mu)[mu*(1-y(1))-beta0*(1+sin(2*pi*t/T))*y(2)*y(1)
            beta0*(1+sin(2*pi*t/T))*y(1)*y(2)-(gamma+mu)*y(2)
            gamma*y(2)-mu*y(3)];

%% Euler Method
[t,y_euler] = eulersys(dydt,tspan,y0,h,T,gamma,mu);          
S_euler=y_euler(:,1);
I_euler=y_euler(:,2);
R_euler=y_euler(:,3);

%% Adams-Bashforth-Moulton
tic
[t,y_AB4] = odeAB4sys(dydt,tspan,y0,h,T,gamma,mu);
S_AB4=y_AB4(:,1);
I_AB4=y_AB4(:,2);
R_AB4=y_AB4(:,3);
toc

%% ODE45
tic
[t_ODE45,y_ODE45]=ode45(dydt,tspan,y0,[],T,gamma,mu);
S_ODE45=y_ODE45(:,1);
I_ODE45=y_ODE45(:,2);
R_ODE45=y_ODE45(:,3);
toc

%% ODE23
tic
[t_ODE23,y_ODE23]=ode23(dydt,tspan,y0,[],T,gamma,mu);
S_ODE23=y_ODE23(:,1);
I_ODE23=y_ODE23(:,2);
R_ODE23=y_ODE23(:,3);
toc

%% Vary in T
T_vary=5:5:20;

[t_Tvary1,y_Tvary1]=ode45(dydt,tspan,y0,h,T_vary(1),gamma,mu);
S_Tvary1=y_Tvary1(:,1);
I_Tvary1=y_Tvary1(:,2);
R_Tvary1=y_Tvary1(:,3);
    
[t_Tvary2,y_Tvary2]=ode45(dydt,tspan,y0,h,T_vary(2),gamma,mu);
S_Tvary2=y_Tvary2(:,1);
I_Tvary2=y_Tvary2(:,2);
R_Tvary2=y_Tvary2(:,3);

[t_Tvary3,y_Tvary3]=ode45(dydt,tspan,y0,h,T_vary(3),gamma,mu);
S_Tvary3=y_Tvary3(:,1);
I_Tvary3=y_Tvary3(:,2);
R_Tvary3=y_Tvary3(:,3);

[t_Tvary4,y_Tvary4]=ode45(dydt,tspan,y0,h,T_vary(4),gamma,mu);
S_Tvary4=y_Tvary4(:,1);
I_Tvary4=y_Tvary4(:,2);
R_Tvary4=y_Tvary4(:,3);

%% Vary in recovery rate
gamma_vary=[0.001 1 2 3];

[t_gammavary1,y_gammavary1]=ode45(dydt,tspan,y0,h,T,gamma_vary(1),mu);
S_gammavary1=y_gammavary1(:,1);
I_gammavary1=y_gammavary1(:,2);
R_gammavary1=y_gammavary1(:,3);
    
[t_gammavary2,y_gammavary2]=ode45(dydt,tspan,y0,h,T,gamma_vary(2),mu);
S_gammavary2=y_gammavary2(:,1);
I_gammavary2=y_gammavary2(:,2);
R_gammavary2=y_gammavary2(:,3);

[t_gammavary3,y_gammavary3]=ode45(dydt,tspan,y0,h,T,gamma_vary(3),mu);
S_gammavary3=y_gammavary3(:,1);
I_gammavary3=y_gammavary3(:,2);
R_gammavary3=y_gammavary3(:,3);

[t_gammavary4,y_gammavary4]=ode45(dydt,tspan,y0,h,T,gamma_vary(4),mu);
S_gammavary4=y_gammavary4(:,1);
I_gammavary4=y_gammavary4(:,2);
R_gammavary4=y_gammavary4(:,3);

%% Vary in Birth death rate
mu_vary=[0.1 0.2 0.3 0.4];

[t_muvary1,y_muvary1]=ode45(dydt,tspan,y0,h,T,gamma,mu_vary(1));
S_muvary1=y_muvary1(:,1);
I_muvary1=y_muvary1(:,2);
R_muvary1=y_muvary1(:,3);
   
[t_muvary2,y_muvary2]=ode45(dydt,tspan,y0,h,T,gamma,mu_vary(2));
S_muvary2=y_muvary2(:,1);
I_muvary2=y_muvary2(:,2);
R_muvary2=y_muvary2(:,3);

[t_muvary3,y_muvary3]=ode45(dydt,tspan,y0,h,T,gamma,mu_vary(3));
S_muvary3=y_muvary3(:,1);
I_muvary3=y_muvary3(:,2);
R_muvary3=y_muvary3(:,3);

[t_muvary4,y_muvary4]=ode45(dydt,tspan,y0,h,T,gamma,mu_vary(4));
S_muvary4=y_muvary4(:,1);
I_muvary4=y_muvary4(:,2);
R_muvary4=y_muvary4(:,3);

%% Plot graph
figure(1)

subplot(311)
hold on
plot(t,S_euler,'r--');
plot(t,S_AB4,'og');
plot(t_ODE45,S_ODE45,'m--');
plot(t_ODE23,S_ODE23,'b--');
title('Fractions Susceptibel Analysis');
ylabel('Susceptibel');
legend('Euler','AB4','ODE45','ODE23','location','best');
hold off


subplot(312)
hold on
plot(t,I_euler,'r--');
plot(t,I_AB4,'og');
plot(t_ODE45,I_ODE45,'m--');
plot(t_ODE23,I_ODE23,'b--');
title('Fractions Infected Analysis');
ylabel('I');
legend('Euler','AB4','ODE45','ODE23','location','best');
hold off

subplot(313)
hold on
plot(t,R_euler,'r--');
plot(t,R_AB4,'og');
plot(t_ODE45,R_ODE45,'m--');
plot(t_ODE23,R_ODE23,'b--');
title('Fractions Recovered Analysis');
ylabel('R');
legend('Euler','AB4','ODE45','ODE23','location','best');
xlabel('Time');
hold off

%% Plot functions that vary in T
figure(2)

subplot(311)
hold on
plot(t_Tvary1,S_Tvary1,'b--');
plot(t_Tvary2,S_Tvary2,'r--');
plot(t_Tvary3,S_Tvary3,'g--');
plot(t_Tvary4,S_Tvary4,'m--');
title('Fractions Susceptibel Analyzation');
ylabel('Susceptibel');
xlabel('Time');
legend('T=5','T=10','T=15','T=20','location','best');
hold off

subplot(312)
hold on
plot(t_Tvary1,I_Tvary1,'b--');
plot(t_Tvary2,I_Tvary2,'r--');
plot(t_Tvary3,I_Tvary3,'g--');
plot(t_Tvary4,I_Tvary4,'m--');
title('Fractions Infected Analyzation');
ylabel('Infected');
xlabel('Time');
legend('T=5','T=10','T=15','T=20','location','best');
hold off

subplot(313)
hold on
plot(t_Tvary1,R_Tvary1,'b--');
plot(t_Tvary2,R_Tvary2,'r--');
plot(t_Tvary3,R_Tvary3,'g--');
plot(t_Tvary4,R_Tvary4,'m--');
title('Fractions Recovered Analyzation');
ylabel('Recovered');
xlabel('Time');
legend('T=5','T=10','T=15','T=20','location','best');
hold off

%% Plot functions that vary in recovery rate
figure(3)

subplot(311)
hold on
plot(t_gammavary1,S_gammavary1,'b--');
plot(t_gammavary2,S_gammavary2,'r--');
plot(t_gammavary3,S_gammavary3,'g--');
plot(t_gammavary4,S_gammavary4,'m--');
title('Fractions Susceptibel Analyzation');
ylabel('Susceptibel');
xlabel('Time');
legend('gamma=0.001','gamma=1','gamma=2','gamma=3','location','best');
hold off

subplot(312)
hold on
plot(t_gammavary1,I_gammavary1,'b--');
plot(t_gammavary2,I_gammavary2,'r--');
plot(t_gammavary3,I_gammavary3,'g--');
plot(t_gammavary4,I_gammavary4,'m--');
title('Fractions Infected Analyzation');
ylabel('Infected');
xlabel('Time');
legend('gamma=0.001','gamma=1','gamma=2','gamma=3','location','best');
hold off

subplot(313)
hold on
plot(t_gammavary1,R_gammavary1,'b--');
plot(t_gammavary2,R_gammavary2,'r--');
plot(t_gammavary3,R_gammavary3,'g--');
plot(t_gammavary4,R_gammavary4,'m--');
title('Fractions Recovered Analyzation');
ylabel('Recovered');
xlabel('Time');
legend('gamma=0.001','gamma=1','gamma=2','gamma=3','location','best');
hold off

%Plot vary in birth and death rate
figure(4)

subplot(311)
hold on
plot(t_muvary1,S_muvary1,'b--');
plot(t_muvary2,S_muvary2,'r--');
plot(t_muvary3,S_muvary3,'g--');
plot(t_muvary4,S_muvary4,'m--');
title('Fractions Susceptibel Analyzation');
ylabel('Susceptibel');
xlabel('Time');
legend('mu=0.1','mu=0.2','mu=0.3','mu=0.4','location','best');
hold off

subplot(312)
hold on
plot(t_muvary1,I_muvary1,'b--');
plot(t_muvary2,I_muvary2,'r--');
plot(t_muvary3,I_muvary3,'g--');
plot(t_muvary4,I_muvary4,'m--');
title('Fractions Infected Analyzation');
ylabel('Infected');
xlabel('Time');
legend('mu=0.1','mu=0.2','mu=0.3','mu=0.4','location','best');
hold off

subplot(313)
hold on
plot(t_muvary1,R_muvary1,'b--');
plot(t_muvary2,R_muvary2,'r--');
plot(t_muvary3,R_muvary3,'g--');
plot(t_muvary4,R_muvary4,'m--');
title('Fractions Recovered Analyzation');
ylabel('Recovered');
xlabel('Time');
legend('mu=0.1','mu=0.2','mu=0.3','mu=0.4','location','best');
hold off
