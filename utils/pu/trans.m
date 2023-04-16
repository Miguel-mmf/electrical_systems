function trans = trans(Vp,Vs,S,X)
    Zbase_p = (Vp^2)/S;
    Zbase_s = (Vs^2)/S;
    trans = struct('Vp',Vp,'Vs',Vs,'Vbp',Vp,'Vbs',Vs,'S',S,'X',X,'Zbp',Zbase_p,'Zbs',Zbase_s);
end