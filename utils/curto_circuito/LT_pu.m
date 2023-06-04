function lt = LT_pu(p_i,p_f,x0,x1,x2)
    
    lt = struct();
    
    lt.pinicial = p_i;
    lt.pfinal = p_f;
    lt.x0 = x0;
    lt.x1 = x1;
    lt.x2 = x2;

    disp(struct2table(lt));
end