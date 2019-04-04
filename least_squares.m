%Least Squares Curve Fitting Approaches
%
%Three approaches to fit the model
%
%    y = A*x*exp(B*x)
%
%to a data set using a least-squares curve fit.

clear all
x_dat = [0.1 0.2 0.4 0.6 0.9 1.3 1.5 1.7 1.8];
y_dat = [0.75 1.25 1.45 1.25 0.85 0.55 0.35 0.28 0.18];
y_model = @(x,A,B) A*x.*exp(B*x);

%%
%General Linear Least Squares with polyfit
y_lin = log(y_dat./x_dat); % log of array div y/x 
p = polyfit(x_dat, y_lin, 1); % polyfit finds coefficients for curve fit
alpha_polyfit = exp(p(2)); % p(2) us ln(A) so that needs exp(ln(A)) = A
beta_polyfit = p(1); % p(1) is B 
%fit quality
Sr = sum((y_dat-y_model(x_dat,alpha_polyfit,beta_polyfit)).^2);
St = sum((y_dat-mean(y_dat)).^2);
r_squared_polyfit = 1-Sr/St;

%%
%General Linear Least Squares with Left Division
y_lin = log(y_dat./x_dat); % log y/x
Z0 = ones(length(x_dat),1); % coeffs of ln(A)
Z1 = x_dat'; % coeffs of B
Z = [Z0, Z1]; 
c = Z\y_lin'; % results of ln(A) % B
alpha_GLLS = exp(c(1)); % c(1) is ln(A)
beta_GLLS = c(2); % c(2) is B
%fit quality
Sr = sum((y_dat-y_model(x_dat,alpha_GLLS,beta_GLLS)).^2);
St = sum((y_dat-mean(y_dat)).^2);
r_squared_GLLS = 1-Sr/St;

%%
%nonlinear regression
Sr_fun = @(a,xi,yi) sum((yi-y_model(xi,a(1),a(2))).^2);
a = fminsearch(Sr_fun,[1,1],[],x_dat,y_dat);
alpha_NR = a(1);
beta_NR = a(2);
answersA6 = [alpha_NR beta_NR];
%fit quality
Sr = sum((y_dat-y_model(x_dat,alpha_NR,beta_NR)).^2);
r_squared_NR = 1-Sr/St;

%%
%plot
figure(1)
hold on
x_m = linspace(min(x_dat),max(x_dat));
plot(x_dat,y_dat,'ko',x_m,y_model(x_m,alpha_polyfit,beta_polyfit),'-')
plot(x_m,y_model(x_m,alpha_GLLS,beta_GLLS),'--')
plot(x_m,y_model(x_m,alpha_NR,beta_NR),'-.')
title('Three Least-Squares Curve Fits with y = \alpha x e^{\beta x}')
xlabel('x')
ylabel('y')
legend('Data','Polyfit','General Linear Least Squares','Nonlinear Regression')


