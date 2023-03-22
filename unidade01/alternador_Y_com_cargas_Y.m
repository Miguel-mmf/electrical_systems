clf;
clc;
clear;
addpath("./utils/")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Trifásicos';

% Adotando sequência positiva
tensao_linha = questdlg('Qual a tensão de linha será utilizada como referência?',dlgtitle,'VAB','VBC','VCA','VAB');

% Handle response
switch tensao_linha
    case 'VBC'
        VBC = inputdlg( ...
            {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
            dlgtitle, ...
            [1 40], ...
            {'380','0'} ...
        );

        VBC = convert_phasor(str2num(VBC{1}),str2num(VBC{2}));
        VCA = VBC*(a^2);
        VAB = VBC*a;

        fprintf('Tensão de Linha VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
        fprintf('Tensão de Linha VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
        fprintf('Tensão de Linha VCA: %.2f/%.2f V\n\n',abs(VCA),angle(VCA)*180/pi);
        
        %% Converter para Tensão de Fase

        VAN = VAB/convert_phasor(sqrt(3),30);
        VBN = VBC/convert_phasor(sqrt(3),30);
        VCN = VCA/convert_phasor(sqrt(3),30);

        fprintf('Tensão de Fase VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
        fprintf('Tensão de Fase VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
        fprintf('Tensão de Fase VCN: %.2f/%.2f V\n',abs(VCN),angle(VCN)*180/pi);
        
        figure(1);
        compass(VAB,'r');
        title('Diagrama Fasorial para as Tensões de Linha e de Fase')
        hold on
        compass(VBC,'r');
        compass(VCA,'r');

        compass(VAN,'b');
        compass(VBN,'b');
        compass(VCN,'b');

        % espelho de fasores
        compass(-1*VAN,'g');
        compass(-1*VBN,'g');
        compass(-1*VCN,'g');

        Z_fio = inputdlg( ...
            {'Parte Real das Impedâncias do Fio:','Parte Imaginária das Impedâncias do Fio:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'0.2','0.5'} ...
        );

        Z_fio = str2num(Z_fio{1}) + 1i*str2num(Z_fio{2});

        Z_carga = inputdlg( ...
            {'Parte Real das Impedâncias de Carga:','Parte Imaginária das Impedâncias de Carga:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'3','4'} ...
        );

        Z_carga = str2num(Z_carga{1}) + 1i*str2num(Z_carga{2});

        %% Associação em série

        Z_eq = Z_fio + Z_carga;

        %% Cálculo das Correntes de Linha
        % Correntes de linhas são iguais as de fase quando a carga em Y.

        Iaa = VAN/Z_eq;
        Ibb = VBN/Z_eq;
        Icc = VCN/Z_eq;

        fprintf('\nCorrente de Linha Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Linha Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Linha Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);

        fprintf('\nCorrente de Fase Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Fase Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Fase Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);
        
        figure(2);
        title('Diagrama Fasorial para as Correntes de Linha e de Fase')
        compass(Iaa,'r');
        hold on
        compass(Ibb,'r');
        compass(Icc,'r');

        fprintf('\nQueda de tensão na linha AA: %.2f/%.2f V\n',abs(Iaa*Z_fio),angle(Iaa*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha BB: %.2f/%.2f V\n',abs(Ibb*Z_fio),angle(Ibb*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha CC: %.2f/%.2f V\n',abs(Icc*Z_fio),angle(Icc*Z_fio)*180/pi);

    case 'VAB'
        VAB = inputdlg( ...
            {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
            dlgtitle, ...
            [1 40], ...
            {'380','0'} ...
        );

        VAB = convert_phasor(str2num(VAB{1}),str2num(VAB{2}));
        VBC = VAB*(a^2);
        VCA = VAB*a;

        fprintf('Tensão de Linha VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
        fprintf('Tensão de Linha VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
        fprintf('Tensão de Linha VCA: %.2f/%.2f V\n\n',abs(VCA),angle(VCA)*180/pi);
        
        %% Converter para Tensão de Fase

        VAN = VAB/convert_phasor(sqrt(3),30);
        VBN = VBC/convert_phasor(sqrt(3),30);
        VCN = VCA/convert_phasor(sqrt(3),30);

        fprintf('Tensão de Fase VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
        fprintf('Tensão de Fase VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
        fprintf('Tensão de Fase VCN: %.2f/%.2f V\n',abs(VCN),angle(VCN)*180/pi);
        
        figure(1);
        compass(VAB,'r');
        title('Diagrama Fasorial para as Tensões de Linha e de Fase')
        hold on
        compass(VBC,'r');
        compass(VCA,'r');

        compass(VAN,'b');
        compass(VBN,'b');
        compass(VCN,'b');

        % espelho de fasores
        compass(-1*VAN,'g');
        compass(-1*VBN,'g');
        compass(-1*VCN,'g');

        Z_fio = inputdlg( ...
            {'Parte Real das Impedâncias do Fio:','Parte Imaginária das Impedâncias do Fio:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'0.2','0.5'} ...
        );

        Z_fio = str2num(Z_fio{1}) + 1i*str2num(Z_fio{2});

        Z_carga = inputdlg( ...
            {'Parte Real das Impedâncias de Carga:','Parte Imaginária das Impedâncias de Carga:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'3','4'} ...
        );

        Z_carga = str2num(Z_carga{1}) + 1i*str2num(Z_carga{2});

        %% Associação em série

        Z_eq = Z_fio + Z_carga;

        %% Cálculo das Correntes de Linha
        % Correntes de linhas são iguais as de fase quando a carga em Y.

        Iaa = VAN/Z_eq;
        Ibb = VBN/Z_eq;
        Icc = VCN/Z_eq;

        fprintf('\nCorrente de Linha Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Linha Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Linha Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);

        fprintf('\nCorrente de Fase Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Fase Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Fase Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);
        
        figure(2);
        title('Diagrama Fasorial para as Correntes de Linha e de Fase')
        compass(Iaa,'r');
        hold on
        compass(Ibb,'r');
        compass(Icc,'r');

        fprintf('\nQueda de tensão na linha AA: %.2f/%.2f V\n',abs(Iaa*Z_fio),angle(Iaa*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha BB: %.2f/%.2f V\n',abs(Ibb*Z_fio),angle(Ibb*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha CC: %.2f/%.2f V\n',abs(Icc*Z_fio),angle(Icc*Z_fio)*180/pi);

    case 'VCA'

        VCA = inputdlg( ...
            {['Módulo da tensão de linha ',tensao_linha],['Fase da tensão de linha ',tensao_linha]}, ...
            dlgtitle, ...
            [1 40], ...
            {'380','0'} ...
        );

        VCA = convert_phasor(str2num(VCA{1}),str2num(VCA{2}));
        VAB = VCA*(a^2);
        VBC = VCA*a;

        fprintf('Tensão de Linha VAB: %.2f/%.2f V\n',abs(VAB),angle(VAB)*180/pi);
        fprintf('Tensão de Linha VBC: %.2f/%.2f V\n',abs(VBC),angle(VBC)*180/pi);
        fprintf('Tensão de Linha VCA: %.2f/%.2f V\n\n',abs(VCA),angle(VCA)*180/pi);
        
        %% Converter para Tensão de Fase

        VAN = VAB/convert_phasor(sqrt(3),30);
        VBN = VBC/convert_phasor(sqrt(3),30);
        VCN = VCA/convert_phasor(sqrt(3),30);

        fprintf('Tensão de Fase VAN: %.2f/%.2f V\n',abs(VAN),angle(VAN)*180/pi);
        fprintf('Tensão de Fase VBN: %.2f/%.2f V\n',abs(VBN),angle(VBN)*180/pi);
        fprintf('Tensão de Fase VCN: %.2f/%.2f V\n',abs(VCN),angle(VCN)*180/pi);
        
        figure(1);
        compass(VAB,'r');
        title('Diagrama Fasorial para as Tensões de Linha e de Fase')
        hold on
        compass(VBC,'r');
        compass(VCA,'r');

        compass(VAN,'b');
        compass(VBN,'b');
        compass(VCN,'b');

        % espelho de fasores
        compass(-1*VAN,'g');
        compass(-1*VBN,'g');
        compass(-1*VCN,'g');

        Z_fio = inputdlg( ...
            {'Parte Real das Impedâncias do Fio:','Parte Imaginária das Impedâncias do Fio:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'0.2','0.5'} ...
        );

        Z_fio = str2num(Z_fio{1}) + 1i*str2num(Z_fio{2});

        Z_carga = inputdlg( ...
            {'Parte Real das Impedâncias de Carga:','Parte Imaginária das Impedâncias de Carga:'}, ...
            dlgtitle, ...
            [1 70], ...
            {'3','4'} ...
        );

        Z_carga = str2num(Z_carga{1}) + 1i*str2num(Z_carga{2});

        %% Associação em série

        Z_eq = Z_fio + Z_carga;

        %% Cálculo das Correntes de Linha
        % Correntes de linhas são iguais as de fase quando a carga em Y.

        Iaa = VAN/Z_eq;
        Ibb = VBN/Z_eq;
        Icc = VCN/Z_eq;

        fprintf('\nCorrente de Linha Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Linha Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Linha Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);

        fprintf('\nCorrente de Fase Iaa: %.2f/%.2f V\n',abs(Iaa),angle(Iaa)*180/pi);
        fprintf('Corrente de Fase Ibb: %.2f/%.2f V\n',abs(Ibb),angle(Ibb)*180/pi);
        fprintf('Corrente de Fase Icc: %.2f/%.2f V\n',abs(Icc),angle(Icc)*180/pi);
        
        figure(2);
        title('Diagrama Fasorial para as Correntes de Linha e de Fase')
        compass(Iaa,'r');
        hold on
        compass(Ibb,'r');
        compass(Icc,'r');

        fprintf('\nQueda de tensão na linha AA: %.2f/%.2f V\n',abs(Iaa*Z_fio),angle(Iaa*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha BB: %.2f/%.2f V\n',abs(Ibb*Z_fio),angle(Ibb*Z_fio)*180/pi);
        fprintf('Queda de tensão na linha CC: %.2f/%.2f V\n',abs(Icc*Z_fio),angle(Icc*Z_fio)*180/pi);
end