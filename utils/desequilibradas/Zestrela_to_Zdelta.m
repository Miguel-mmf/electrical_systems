function [Zab,Zbc,Zca] = Zestrela_to_Zdelta(Za,Zb,Zc)
    
%     Zsum = sum([Zab, Zbc, Zca]);
    Zab = (Za*Zb+Zb*Zc+Za*Zc)/Zc;
    Zbc = (Za*Zb+Zb*Zc+Za*Zc)/Za;
    Zca = (Za*Zb+Zb*Zc+Za*Zc)/Zb;
end