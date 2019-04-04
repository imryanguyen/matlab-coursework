reference.solution
y_correct1 = ExponentialTerms;
clear ExponentialTerms
run('solution')
%test if variables exist and are named correctly
assert(isequal(exist('ExponentialTerms','var'),1),['The variable, '...
'ExponentialTerms, has not been created. '...
'Check spelling and capitalization.'])
student_sol1 = ExponentialTerms;
%test vector length
assert(isequal(size(student_sol1),size( y_correct1)),sprintf(['The vector, '...
'ExponentialTerms should be a %d element row vector.'],length(y_correct1)))
%test accuracy
test = max(abs(student_sol1-y_correct1));
assert(le(test,1e-6),'One or more values in ExponentialTerms is incorrect.')