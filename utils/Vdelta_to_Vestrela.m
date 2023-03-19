function [VAN,VBN,VCN,VAB,VBC,VCA] = Vdelta_to_Vestrela(VAN,VBN,VCN,sequencia)

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

    VAB = VAN - VBN;
    VBC = VBN - VCN;
    VCA = VCN - VAN;
    
end