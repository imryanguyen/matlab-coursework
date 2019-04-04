%%
%function that accepts signal voltage 
%and breakdown voltage to calculate voltage load.

function[V_L] = voltLoad(V_s, V_br)
    n = 0.6;
    if V_s < -V_br
        V_L = 999; %failure
    elseif V_s > n
        V_L = V_s - n;
    elseif V_s <= n 
        V_L = 0;
    end
    
    
    