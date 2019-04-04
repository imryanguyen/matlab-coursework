%This m-file is to test the voltLoad function
%Save the values for V_L as a vector.

V_s_values = [10 -60 -75 145 47];
V_br_values = [45 40 155 115 125];
V_L_vector = zeros(1,5);

for i = 1:5
    V_L_vector(i) = voltLoad(V_s_values(i), V_br_values(i));
end