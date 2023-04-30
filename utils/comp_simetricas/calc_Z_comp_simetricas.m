function [Z0,Z1,Z2,matriz_Zs] = calc_Z_comp_simetricas(Za,Zb,Zc)

    T = get_T();
    Zs = [Za Zb Zc];

    Z0 = sum(Zs)/3;
    Z1 = sum(Zs.*T(3,:))/3;
    Z2 = sum(Zs.*T(2,:))/3;

    matriz_Zs = [Z0 Z2 Z1; Z1 Z0 Z2;Z2 Z1 Z0];
end