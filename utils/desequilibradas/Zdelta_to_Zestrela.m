function [Za,Zb,Zc] = Zdelta_to_Zestrela(Zab,Zbc,Zca)
    
    Zsum = sum([Zab, Zbc, Zca]);
    Za = (Zab*Zca)/Zsum;
    Zb = (Zab*Zbc)/Zsum;
    Zc = (Zbc*Zca)/Zsum;
end