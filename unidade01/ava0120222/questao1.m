clear;
addpath("../../utils/apoio/")
% rmpath("../utils/equilibradas/") % para não ter conflitos de path
% rmpath('../utils/desequilibradas/') % comentar se a questão envolver cargas equilibradas
addpath("../../utils/desequilibradas/")
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
Zf = 0;
Zn = 0;

%% Corrente de Neutro

In = calc_Ineutro([VAN,VBN,VCN],[Za,Zb,Zc],Zf,Zn);
fprintf('Corrente no Neutro: %.4f/%.4f V\n',abs(In),angle(In)*180/pi);

%% Tensão Neutro Neutro
Vnn = In*Zn;
fprintf('Tensão no Neutro: %.4f/%.4f V\n',abs(Vnn),angle(Vnn)*180/pi);

%% Correntes de Linha

V_AN = VAN - Vnn; % é -Vnn, pois ele faz VAN' = VAN + VNN' e o que encontramos é o VN'N
V_BN = VBN - Vnn;
V_CN = VCN - Vnn;
fprintf('Tensão de Fase VAN na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Za),imag(Za),abs(V_AN),angle(V_AN)*180/pi);
fprintf('Tensão de Fase VBN na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Zb),imag(Zb),abs(V_BN),angle(V_BN)*180/pi);
fprintf('Tensão de Fase VCN na carga %.4f j%.4f Ω: %.4f/%.4f V\n\n',real(Zc),imag(Zc),abs(V_CN),angle(V_CN)*180/pi);

Ia = V_AN/(Za+Zf);
Ib = V_BN/(Zb+Zf);
Ic = V_CN/(Zc+Zf);
fprintf('Corrente de Linha e Fase (IAA) na carga %.4f j%.4f Ω: %.4f/%.4f A\n',real(Za),imag(Za),abs(Ia),angle(Ia)*180/pi);
fprintf('Corrente de Linha e Fase (IBB) na carga %.4f j%.4f Ω: %.4f/%.4f A\n',real(Zb),imag(Zb),abs(Ib),angle(Ib)*180/pi);
fprintf('Corrente de Linha e Fase (ICC) na carga %.4f j%.4f Ω: %.4f/%.4f A\n',real(Zc),imag(Zc),abs(Ic),angle(Ic)*180/pi);

%% Tensões de Fase na Carga

V_A_N = Ia*Za;
V_B_N = Ib*Zb;
V_C_N = Ic*Zc;
fprintf('\nTensão de Fase (A) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Za),imag(Za),abs(V_A_N),angle(V_A_N)*180/pi);
fprintf('Tensão de Fase (B) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Zb),imag(Zb),abs(V_B_N),angle(V_B_N)*180/pi);
fprintf('Tensão de Fase (C) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Zc),imag(Zc),abs(V_C_N),angle(V_C_N)*180/pi);

%% Tensões de Linha na Carga

V_A_B = V_A_N - V_B_N;
V_B_C = V_B_N - V_C_N;
V_C_A = V_C_N - V_A_N;
fprintf('\nTensão de Fase e Linha (A) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Za),imag(Za),abs(V_A_B),angle(V_A_B)*180/pi);
fprintf('Tensão de Fase e Linha (B) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Zb),imag(Zb),abs(V_B_C),angle(V_B_C)*180/pi);
fprintf('Tensão de Fase e Linha (C) na carga %.4f j%.4f Ω: %.4f/%.4f V\n',real(Zc),imag(Zc),abs(V_C_A),angle(V_C_A)*180/pi);