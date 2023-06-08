function lt = LT_pu(p_i,p_f,x0,x1,x2)
    
    lt = struct();
    
    lt.pinicial = p_i;
    lt.pfinal = p_f;
    lt.X0 = x0;
    lt.X1 = x1;
    lt.X2 = x2;

    disp(struct2table(lt));
end