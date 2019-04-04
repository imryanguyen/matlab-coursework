function [xroot,ea,iter] = secant_func(fun,dfdx,xi,es,max_it,varargin)
%[xroot,ea,iter] = secant_func(fun,dfdx,xi,es,max_it,varargin)
%
%Secant Method for the solution of a roots problem
%
%Inputs
%   fun:    user defined function that defines the roots problem
%   dfdx:   derivative of input function 
%   xi:     initial guess
%   es:     optional stopping criterion, default is es = 1E-6
%   max_it: optional maximum iterations, default is max_it = 50
%   p1,p2,...   optional parameter inputs for function evaluation
%
%Outputs
%   xroot:  root estimate 
%   ea:     approximate relative error in root estimate
%   iter:   number of iterations required for convergence

