function [IAN,IBN,ICN,IAB,IBC,ICA] = get_I(Ipu,Vbase,Sbase,ligacao,sequencia)

    IAN = Ipu*(Sbase/(sqrt(3)*Vbase));
    a = convert_phasor(1,120);

    if lower(sequencia) == 'positiva'
        IBN = IAN*(a^2);
        ICN = IAN*a;
    else
        IBN = IAN*a;
        ICN = IAN*(a^2);
    end

    if lower(ligacao) == 'd'
        IAB = IAN;
        IBC = IBN;
        ICA = ICN;
    elseif lower(ligacao) == 'y'
        VAB = IAN - IBN;
        VBC = IBN - ICN;
        VCA = ICN - IAN;
    else
        fprintf('Error')
    end

    'Informações de Corrente'
    fprintf('Corrente de Fase IAN: %.4f/%.4f V\n',abs(IAN),angle(IAN)*180/pi);
    fprintf('Corrente de Fase IBN: %.4f/%.4f V\n',abs(IBN),angle(IBN)*180/pi);
    fprintf('Corrente de Fase ICN: %.4f/%.4f V\n',abs(ICN),angle(ICN)*180/pi);
    
    fprintf('Corrente de Linha VAB: %.4f/%.4f V\n',abs(IAB),angle(IAB)*180/pi);
    fprintf('Corrente de Linha VBC: %.4f/%.4f V\n',abs(IBC),angle(IBC)*180/pi);
    fprintf('Corrente de Linha VCA: %.4f/%.4f V\n\n',abs(ICA),angle(ICA)*180/pi);
end