function [Ya,Yb,Yc] = calc_admitancias(Za,Zb,Zc)
    
    Ya = Za^-1;
    Yb = Zb^-1;
    Yc = Zc^-1;
end