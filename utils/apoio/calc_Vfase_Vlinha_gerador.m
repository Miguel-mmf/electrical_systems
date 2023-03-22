function [VAN,VBN,VCN,VAB,VBC,VCA] = calc_Vfase_Vlinha_gerador(ligacao,sequencia)
    
    a = convert_phasor(1,120);
    dlgtitle = 'Sistemas Trifásicos';
    entrada = questdlg('Qual a informação inicial?',dlgtitle,'Tensão de Fase','Tensão de Linha','Tensão de Fase');

    switch entrada
        %% Tensão de Fase
        case 'Tensão de Fase'
    
            tensao_fase = questdlg('Qual a tensão de fase será utilizada como referência?',dlgtitle,'VAN','VBN','VCN','VAN');
    
            switch tensao_fase
            
                case 'VAN'
                    VAN = inputdlg( ...
                        {['Módulo da tensão de fase ',tensao_fase],['Fase da tensão de fase ',tensao_fase]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VAN = convert_phasor(str2num(VAN{1}),str2num(VAN{2}));
                    if lower(sequencia) == 'positiva'
                        VBN = VAN*(a^2);
                        VCN = VAN*a;
                    else
                        VBN = VAN*a;
                        VCN = VAN*(a^2);
                    end
            
                case 'VBN'
                    VBN = inputdlg( ...
                        {['Módulo da tensão de fase ',tensao_fase],['Fase da tensão de fase ',tensao_fase]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VBN = convert_phasor(str2num(VBN{1}),str2num(VBN{2}));
                    if lower(sequencia) == 'positiva'
                        VCN = VBN*(a^2);
                        VAN = VBN*a;
                    else
                        VCN = VBN*a;
                        VAN = VBN*(a^2);
                    end
            
                case 'VCN'
            
                    VCN = inputdlg( ...
                        {['Módulo da tensão de fase ',tensao_fase],['Fase da tensão de fase ',tensao_fase]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VCN = convert_phasor(str2num(VCN{1}),str2num(VCN{2}));
                    if lower(sequencia) == 'positiva'
                        VAN = VCN*(a^2);
                        VBN = VCN*a;
                    else
                        VAN = VCN*a;
                        VBN = VCN*(a^2);
                    end
    
            end
            
            if ligacao == 'Δ'
                VAB = VAN;
                VBC = VBN;
                VCA = VCN;
            elseif ligacao == 'Y'
                VAB = VAN - VBN;
                VBC = VBN - VCN;
                VCA = VCN - VAN;
            else
                fprintf('Error')
            end
         
        %% Tensão de Linha
        case 'Tensão de Linha'
    
            tensao_linha = questdlg('Qual a tensão de fase será utilizada como referência?',dlgtitle,'VAB','VBC','VCA','VAB');
            
            switch tensao_linha
    
                case 'VBC'
                    VBC = inputdlg( ...
                        {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VBC = convert_phasor(str2num(VBC{1}),str2num(VBC{2}));
                    if lower(sequencia) == 'positiva'
                        VCA = VBC*(a^2);
                        VAB = VBC*a;
                    else
                        VCA = VBC*a;
                        VAB = VBC*(a^2);
                    end
    
                case 'VAB'
                    VAB = inputdlg( ...
                        {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VAB = convert_phasor(str2num(VAB{1}),str2num(VAB{2}));
                    if lower(sequencia) == 'positiva'
                        VBC = VAB*(a^2);
                        VCA = VAB*a;
                    else
                        VBC = VAB*a;
                        VCA = VAB*(a^2);
                    end
                    
                case 'VCA'
            
                    VCA = inputdlg( ...
                        {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
                        dlgtitle, ...
                        [1 40], ...
                        {'380','0'} ...
                    );
            
                    VCA = convert_phasor(str2num(VCA{1}),str2num(VCA{2}));
                    if lower(sequencia) == 'positiva'
                        VAB = VCA*(a^2);
                        VBC = VCA*a;
                    else
                        VAB = VCA*a;
                        VBC = VCA*(a^2);
                    end
                    
            end
            
            if ligacao == 'Δ'
                VAN = VAB;
                VBN = VBC;
                VCN = VCA;
            elseif ligacao == 'Y'
                VAN = VAB/convert_phasor(sqrt(3),30);
                VBN = VBC/convert_phasor(sqrt(3),30);
                VCN = VCA/convert_phasor(sqrt(3),30);
            else
                fprintf('Error')
            end
             
    end
    'Informações de Tensão do Gerador'
    fprintf('Tensão de Fase VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
    fprintf('Tensão de Fase VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
    fprintf('Tensão de Fase VCN: %.2f/%.2f V\n',abs(VCN),angle(VCN)*180/pi);
    
    fprintf('Tensão de Linha VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
    fprintf('Tensão de Linha VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
    fprintf('Tensão de Linha VCA: %.2f/%.2f V\n\n',abs(VCA),angle(VCA)*180/pi);
end