function [count,p_interval] = prime_finder(input_interval)
%[count,p_interval] = prime_finder(input_interval)
%
%Counts how many prime numbers lie in between the values in two element
%vector input_interval.  Also returns a column vector that includes all of
%the prime numbers that lie in the interval.
pmin = min(input_interval);
pmax = max(input_interval);
all_primes = primes(pmax);

p_interval = all_primes(all_primes >= pmin);
p_interval = p_interval';

count = length(p_interval);
