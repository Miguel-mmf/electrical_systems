function [VAN,VBN,VCN,VAB,VBC,VCA] = Vdelta_to_Vestrela(VAB,VBC,VCA,sequencia)

    %% Informações da configuração delta
        % tensões de linha e fase iguais
        % VAB = VAN;
        % VBC = VBN;
        % VCA = VCN;
    
    %% Conversão
        % Tensão de fase será a tensão de linha/fase dividida por √3/∓30°
    if lower(sequencia) == 'positiva'
        VAN = VAB/convert_phasor(sqrt(3),30);
        VBN = VBC/convert_phasor(sqrt(3),30);
        VCN = VCA/convert_phasor(sqrt(3),30);
    else
        VAN = VAB/convert_phasor(sqrt(3),-30);
        VBN = VBC/convert_phasor(sqrt(3),-30);
        VCN = VCA/convert_phasor(sqrt(3),-30);
    end

    % VAB = VAN - VBN;
    % VBC = VBN - VCN;
    % VCA = VCN - VAN;
    'Novas Informações de Tensão do Gerador'
    fprintf('Tensão de Fase VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
    fprintf('Tensão de Fase VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
    fprintf('Tensão de Fase VCN: %.2f/%.2f V\n',abs(VCN),angle(VCN)*180/pi);
    
    fprintf('Tensão de Linha VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
    fprintf('Tensão de Linha VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
    fprintf('Tensão de Linha VCA: %.2f/%.2f V\n\n',abs(VCA),angle(VCA)*180/pi);
    
end