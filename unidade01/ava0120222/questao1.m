clear;
addpath("./utils/")
rmpath("./utils/equilibradas/") % para não ter conflitos de path
rmpath('./utils/desequilibradas/') % comentar se a questão envolver cargas equilibradas
addpath("./utils/desequilibradas/")
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

%% Carga desequilibrada em Delta
'Carga desequilibrada em Delta'
Za = 16+28i;
Zb = 14+6.4i;
Zc = 14+8i;

%%