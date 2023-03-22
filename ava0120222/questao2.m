clear;
addpath("./utils/apoio/")
rmpath("./utils/equilibradas/") % para não ter conflitos de path
rmpath('./utils/desequilibradas/') % comentar se a questão envolver cargas equilibradas
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

[VAN,VBN,VCN,VAB,VBC,VCA] = calc_Vfase_Vlinha_gerador(ligacao_gerador,sequencia);

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