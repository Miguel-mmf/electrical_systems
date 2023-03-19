function In = calc_Ineutro(Vs,Zcs,Zf,Zn)

    % Vs = [VAN,VBN,VCN]
    % Zcs = [ZA,ZB,ZC]

    den = 1;
    num = 0;
    for i = 1:length(Vs)
        num = num + Vs(i)/(Zcs(i)+Zf);
        den = den + Zn/(Zcs(i)+Zf);
    end
   
    In = num/den;
end

