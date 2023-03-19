function Vnn = calc_Vnn_neutro_isolado(Van,Vbn,Vcn,Yat,Ybt,Yct)
    
    num = Van*Yat + Vbn*Ybt + Vcn*Yct;
    den = sum([Yat,Ybt,Yct]);
%     den = Yat + Ybt + Yct;

    Vnn = -1*(num/den);
end