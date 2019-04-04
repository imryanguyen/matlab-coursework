clc
clear
close
%main function
fun = @(M,k,A) (1/M)*((2/(k+1))*(1+((k-1)/2)*M^2))^((k+1)/(2*(k-1)))-A;

%values of A and k
A = linspace(1.1,10);
k = [1.285 1.400 1.667];

Mneg=zeros(length(k),length(A));
Mpos=zeros(length(k),length(A));

for j = 1:length(k)
    for ndx = 1:length(A)
        [Mneg(j, ndx)]= bisect_param(fun,0,1,[],[],k(j),A(ndx));
        [Mpos(j, ndx)]= fzero(@(M) fun(M,k(j),A(ndx)),[1 10]);
    end
    figure()
    plot(Mneg(j,:),A)
    figure()
    plot(Mpos(j,:),A)
end

