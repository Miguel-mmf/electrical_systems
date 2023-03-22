clf;
clc;
clear;
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Trifásicos';

seq_fase = questdlg('Qual a sequência de fase?',dlgtitle,'Positiva','Negativa','Positiva');

% Handle response
switch seq_fase

    case 'Positiva'
        %disp([seq_fase ' coming right up.'])
        
        tensao_fase = questdlg('Qual a tensão de fase será utilizada como referência?',dlgtitle,'VAN','VBN','VCN','VAN');
        % Handle response
        switch tensao_fase
            case 'VAN'
                disp([answer ' coming right up.'])
                dessert = 1;

            case 'VBN'
                VBN = inputdlg( ...
                    {'Módulo da tensão VBN','Fase da tensão VBN (°)'}, ...
                    dlgtitle, ...
                    [1 40], ...
                    {'220','0'} ...
                );

                VBN = convert_phasor(str2num(VBN{1}),str2num(VBN{2}));

                VAN = VBN*a;
                VCN = VBN*(a^2);
                fprintf('Fasor VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
                fprintf('Fasor VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
                fprintf('Fasor VCN: %.2f/%.2f V\n\n',abs(VCN),angle(VCN)*180/pi);

                VAB = (VAN - VBN);%/convert_phasor(sqrt(3),30);
                VBC = (VBN - VCN);%/convert_phasor(sqrt(3),30);
                VCA = (VCN - VAN);%/convert_phasor(sqrt(3),30);
                fprintf('Fasor VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
                fprintf('Fasor VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
                fprintf('Fasor VCA: %.2f/%.2f V\n',abs(VCA),angle(VCA)*180/pi);

                compass(VAB,'r');
                hold on
                compass(VBC,'r');
                compass(VCA,'r');
                compass(VAN,'b');
                compass(VBN,'b');
                compass(VCN,'b');

            case 'VCN'

                VCN = inputdlg( ...
                    {'Módulo da tensão VCN','Fase da tensão VBN (°)'}, ...
                    dlgtitle, ...
                    [1 40], ...
                    {'220','0'} ...
                );

                VCN = convert_phasor(str2num(VCN{1}),str2num(VCN{2}));

                VBN = VCN*a;
                VAN = VCN*(a^2);
                fprintf('Fasor VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
                fprintf('Fasor VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
                fprintf('Fasor VCN: %.2f/%.2f V\n\n',abs(VCN),angle(VCN)*180/pi);

                VAB = (VAN - VBN);%/convert_phasor(sqrt(3),30);
                VBC = (VBN - VCN);%/convert_phasor(sqrt(3),30);
                VCA = (VCN - VAN);%/convert_phasor(sqrt(3),30);
                fprintf('Fasor VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
                fprintf('Fasor VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
                fprintf('Fasor VCA: %.2f/%.2f V\n',abs(VCA),angle(VCA)*180/pi);

                compass(VAB,'r');
                hold on
                compass(VBC,'r');
                compass(VCA,'r');
                compass(VAN,'b');
                compass(VBN,'b');
                compass(VCN,'b');
        end

    case 'Negativa'
        disp([answer ' coming right up.'])
        dessert = 2;
end