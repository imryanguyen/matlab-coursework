function[scalar, col_vector, row_vector] = prime_func(A, B)

if min(A) > max(B)
    msg = 'Error. Minimum element of vector A is larger than max of B.';
    error(msg)
end

%% Output 1
%Logical Indexing 
%B(B>mean(A)) creates a row vector contains 
%all elements of B larger than mean of elements 
%in vector A.
scalar = length(B(B>mean(A)));

%% Output 2
%all_primes(all_primes >= min(A))' creates a column vector contains
%prime numbers from min(A) to max(B).
all_primes = primes(max(B));
if  isempty(all_primes(all_primes >= min(A)))
    msg = 'Error. No prime numbers in this interval';
    error(msg)
else
    col_vector = all_primes(all_primes >= min(A))';
end


%% Output 3
vector = col_vector(col_vector>mean(A));
count = length(vector);
psum = sum(vector);
row_vector = [count psum];



