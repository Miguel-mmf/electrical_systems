clear;
addpath("./utils/")
rmpath("./utils/desequilibradas/")
addpath("./utils/equilibradas/")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Trifásicos Desequilibrados';

ligacao_gerador = get_ligacao(dlgtitle,'Qual é o tipo de ligação do gerador?');

sequencia = questdlg( ...
    'Qual a sequência de fase?', ...
    dlgtitle, ...
    'Positiva', ...
    'Negativa', ...
    'Positiva' ...
);

[VAN,VBN,VCN,~,~,~] = calc_Vfase_Vlinha_gerador(ligacao_gerador,sequencia);

%% Conversão da Ligação Y para Delta do Gerador
[VAN,VBN,VCN,VAB,VBC,VCA] = Vdelta_to_Vestrela(VAN,VBN,VCN,sequencia);

%% Impedância do fio
Zfio = 0.08+0.003i;

%% Motor 1
Vl1 = 380;
fpm1 = 0.85;
Potm1 = 5e3;
nm1 = 0.9;

Zm1 = (Vl1^2)/(Potm1/(nm1*fpm1));
Zm1 = Zm1*fpm1 + 1i*Zm1*sind(acosd(fpm1));

%% Motor 2
Vl2 = 380;
fpm2 = 0.9;
Potm2 = 6.5e3;
nm2 = 0.85;
Zfio2 = 0.037+0.0015i;

Zm2 = 3*(Vl2^2)/(Potm2/(nm2*fpm2));
Zm2 = Zm2*fpm1 + 1i*Zm2*sind(acosd(fpm2));
% Somando impedancia do fio para o motor 2
    % Organização de impedância delta para Y
Zm2 = Zdelta_to_Zestrela(Zm2);
Zm2_eq = Zm2 + Zfio2;

% Zm2y = Zdelta_to_Zestrela(Zm2_eq);

%% Paralelo de impedâncias
Zeq12 = (Zm2_eq*Zm1)/(Zm2_eq+Zm1);

%% Cálculo da Corrente de Linha
'Correntes de Linha'
fprintf('IAA: ')
Ia = VAN/(Zfio+Zeq12);
get_phasor(Ia);
fprintf('IBB: ')
Ib = VBN/(Zfio+Zeq12);
get_phasor(Ib);
fprintf('ICC: ')
Ic = VCN/(Zfio+Zeq12);
get_phasor(Ic)

%% Tensões de Linha e Fase para o Motor 1
'Tensões de Linha e Fase para o Motor 1'

VANm1 = VAN-Zfio*Ia;
VBNm1 = VANm1*(a^2);
VCNm1 = VANm1*a;

VABm1 = VANm1 - VBNm1;
VBCm1 = VBNm1 - VCNm1;
VCAm1 = VCNm1 - VANm1;
fprintf('Tensão de Fase VAN: %.4f/%.4f V\n',abs(VANm1),angle(VANm1)*180/pi);
fprintf('Tensão de Fase VBN: %.4f/%.4f V\n',abs(VBNm1),angle(VBNm1)*180/pi);
fprintf('Tensão de Fase VCN: %.4f/%.4f V\n',abs(VCNm1),angle(VCNm1)*180/pi);

fprintf('Tensão de Linha VAB: %.4f/%.4f V\n',abs(VABm1),angle(VABm1)*180/pi);
fprintf('Tensão de Linha VBC: %.4f/%.4f V\n',abs(VBCm1),angle(VBCm1)*180/pi);
fprintf('Tensão de Linha VCA: %.4f/%.4f V\n\n',abs(VCAm1),angle(VCAm1)*180/pi);

%% Correntes de Linha para o Motor 1
'Correntes de Linha para o Motor 1'
Iam1 = VANm1/Zm1;
Ibm1 = Iam1*(a^2);
Icm1 = Iam1*a;
fprintf('Corrente de Linha e Fase (IAA) na carga %.4f j%.4f Ω: %.4f/%.4f A\n',real(Zm1),imag(Zm1),abs(Iam1),angle(Iam1)*180/pi);
fprintf('Corrente de Linha e Fase (IBB) na carga %.4f j%.4f Ω: %.4f/%.4f A\n',real(Zm1),imag(Zm1),abs(Ibm1),angle(Ibm1)*180/pi);
fprintf('Corrente de Linha e Fase (ICC) na carga %.4f j%.4f Ω: %.4f/%.4f A\n\n',real(Zm1),imag(Zm1),abs(Icm1),angle(Icm1)*180/pi);

%% Correntes de Fase para o Motor 2
'Correntes de Fase para o Motor 2'
Iam2 = Ia - Iam1;
Ibm2 = Iam2*(a^2);
Icm2 = Iam2*a;

% VANm2 = VANm1-Zfio2*Iam2;
% VBNm2 = VANm2*(a^2);
% VCNm2 = VANm2*a;
% tensão de fase igual a tensão de linha
Zm2 = Zestrela_to_Zdelta(Zm2);
% Iabm2 = VANm2/Zm2;
% Ibcm2 = VBNm2/Zm2;
% Icam2 = VCNm2/Zm2;
Iabm2 = Iam2/convert_phasor(sqrt(3),-30);
Ibcm2 = Iabm2*(a^2);
Icam2 = Iabm2*a;

fprintf('Corrente de Fase (IAB): %.4f/%.4f A\n',abs(Iabm2),angle(Iabm2)*180/pi);
fprintf('Corrente de Fase (IBC): %.4f/%.4f A\n',abs(Ibcm2),angle(Ibcm2)*180/pi);
fprintf('Corrente de Fase (ICA): %.4f/%.4f A\n\n',abs(Icam2),angle(Icam2)*180/pi);