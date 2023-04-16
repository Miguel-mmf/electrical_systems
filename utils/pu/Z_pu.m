function Z_complex = Z_pu(Zreal,Zbase)%,fp=-1)
    
%     if fp ~= -1
%         Zreal_abs = abs(Zreal);
%         Z_complex = (Zreal_abs*fp + 1i*sind(acosd(fp)))/Zbase;
%     else
    Z_complex = (Zreal)/Zbase;
%     end
    
end