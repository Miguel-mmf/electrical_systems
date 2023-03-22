clear;
addpath("./utils/")
rmpath("./utils/equilibradas/") % para não ter conflitos de path
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

'Carga desequilibrada em Delta'
Zab = 16+28i;
Zbc = 14+6.4i;
Zca = 14+8i;

[Za,Zb,Zc] = Zdelta_to_Zestrela(Zab,Zbc,Zca);

'Carga somada as impedancias do fio'
Zfio = 0.3+1i;

Zal = Za + Zfio;
Zbl = Zb + Zfio;
Zcl = Zc + Zfio;

% Convertendo novamente para delta
[Zabl,Zbcl,Zcal] = Zestrela_to_Zdelta(Zal,Zbl,Zcl);

'Calculo das correntes de fase na carga (gerador em Delta)'
Iab = VAB/Zabl;
get_phasor(Iab);
Ibc = VBC/Zbcl;
get_phasor(Ibc);
Ica = VCA/Zcal;
get_phasor(Ica);

'Calculo das correntes de linha (gerador em Delta)'
IAA = Iab - Ica;
get_phasor(IAA);
IBB = Ibc - Iab;
get_phasor(IBB);
ICC = Ica - Ibc;
get_phasor(ICC);

'Leitura no Wattimetro W1'
VAC = -VCA;
PW1 = abs(VAC)*abs(IAA)*cosd((angle(VAC)*180/pi) - (-angle(IAA)*180/pi))

'Leitura no Wattimetro W2'
PW2 = abs(VBC)*abs(IBB)*cosd((angle(VBC)*180/pi) - (-angle(IBB)*180/pi))

'Potência trifásica'
Ptot = PW1 + PW2