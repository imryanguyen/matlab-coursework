clc
close
clear

%% Data and equation
% Data

data_proj2= importfile('O_H2_rxn.dat');
data_proj2=table2array(Data_proj2);
Ta=Data_proj2(:,1);
k =Data_proj2(:,2);
R=8.314; % J/(mol K)
%equation
k_model1=@(T,A,E) A*exp(-E./(R.*T));
k_model2=@(T,A,b,E) A*T.^b.*exp(-E./(R.*T));

%% First Equation
%% GLLS with left division 
y_lin=log(k);
z0=ones(length(k),1);
z1=log(Ta);%This is for second equation
z2=1./(Ta);

Z1=[z0,z2];
c1=Z1\y_lin;

A_GLLS1=exp(c1(1));
E_GLLS1=-R*c1(2);

% fit quality for first equation
Sr1 = sum((k-k_model1(Ta,A_GLLS1,E_GLLS1)).^2);
St1 = sum((k-mean(k)).^2);
r_squared_GLLS1 = 1-Sr1/St1;
Syx_GLLS1=sqrt(Sr1/(length(Ta)-2));

%% Nonlinear regression
Sr_fun1 = @(d1,xi,yi) sum((yi-k_model1(xi,d1(1),d1(2))).^2);
d1 = fminsearch(Sr_fun1,[A_GLLS1,E_GLLS1],[],Ta,k);
A_NR1 = d1(1);
E_NR1 = d1(2);

% fit quality
Sr1 = sum((k-k_model1(Ta,A_NR1,E_NR1)).^2);
r_squared_NR1 = 1-Sr1/St1;
Syx_NR1=sqrt(Sr1/(length(Ta)-2));


%% Second equation
%% GLLS with left division 
Z2=[z0,z1,z2];
c2=Z2\y_lin;

A_GLLS2=exp(c2(1));
b_GLLS2=c2(2);
E_GLLS2=-R*c2(3);

% fit quality for second equation
Sr2 = sum((k-k_model2(Ta,A_GLLS2,b_GLLS2,E_GLLS2)).^2);
St2 = sum((k-mean(k)).^2);
r_squared_GLLS2 = 1-Sr2/St2;
Syx_GLLS2=sqrt(Sr2/(length(Ta)-3));

%% Nonlinear regression

Sr_fun2 = @(d2,xi,yi) sum((yi-k_model2(xi,d2(1),d2(2),d2(3))).^2);
d2 = fminsearch(Sr_fun2,[A_GLLS2,b_GLLS2,E_GLLS2],[],Ta,k);
A_NR2=d2(1);
b_NR2=d2(2);
E_NR2= d2(3);

%fit quality
Sr2 = sum((k-k_model2(Ta,A_NR2,b_NR2,E_NR2)).^2);
r_squared_NR2 = 1-Sr2/St2;
Syx_NR2=sqrt(Sr2/(length(Ta)-3));

%% plot data
figure()
hold on
plot(Ta,k,'o');
plot(Ta,k_model1(Ta,A_GLLS1,E_GLLS1),'r--');
plot(Ta,k_model1(Ta,A_NR1,E_NR1),'b--');
plot(Ta,k_model2(Ta,A_GLLS2,b_GLLS2,E_GLLS2),'m.-');
plot(Ta,k_model2(Ta,A_NR2,b_NR2,E_NR2),'g--');

title('Arrhenius equation');
xlabel('Temperature (Kelvin)');
ylabel('Reaction Rate (s^-1)');
legend('Data','left division eq1','Nonlinear regression eq1','left division eq2','Nonlinear regression eq2');
