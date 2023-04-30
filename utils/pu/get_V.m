function [VAN,VBN,VCN,VAB,VBC,VCA] = get_V(Vpu,Vbase,ligacao,sequencia)
    
    VAN = Vpu*Vbase;
    a = convert_phasor(1,120);

    if lower(sequencia) == 'positiva'
        VBN = VAN*(a^2);
        VCN = VAN*a;
    else
        VBN = VAN*a;
        VCN = VAN*(a^2);
    end

    if lower(ligacao) == 'd'
        VAB = VAN;
        VBC = VBN;
        VCA = VCN;
    elseif lower(ligacao) == 'y'
        VAB = VAN - VBN;
        VBC = VBN - VCN;
        VCA = VCN - VAN;
    else
        fprintf('Error')
    end

    'Informações de Tensão'
    fprintf('Tensão de Fase VAN: %.4f/%.4f V\n',abs(VAN),angle(VAN)*180/pi);
    fprintf('Tensão de Fase VBN: %.4f/%.4f V\n',abs(VBN),angle(VBN)*180/pi);
    fprintf('Tensão de Fase VCN: %.4f/%.4f V\n',abs(VCN),angle(VCN)*180/pi);
    
    fprintf('Tensão de Linha VAB: %.4f/%.4f V\n',abs(VAB),angle(VAB)*180/pi);
    fprintf('Tensão de Linha VBC: %.4f/%.4f V\n',abs(VBC),angle(VBC)*180/pi);
    fprintf('Tensão de Linha VCA: %.4f/%.4f V\n\n',abs(VCA),angle(VCA)*180/pi);
end