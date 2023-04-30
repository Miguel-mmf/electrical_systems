function value = convbases(oldvalue,Vold,Vnew,Sold,Snew)

    value = oldvalue*(Vold/Vnew)^2;
    value = value*(Snew/Sold);
end