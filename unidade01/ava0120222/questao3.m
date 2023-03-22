clear;
addpath("./utils/")
rmpath("./utils/desequilibradas/")
addpath("./utils/equilibradas/")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Trifásicos Equilibrados';

ligacao_gerador = get_ligacao(dlgtitle,'Qual é o tipo de ligação do gerador?');

sequencia = questdlg( ...
    'Qual a sequência de fase?', ...
    dlgtitle, ...
    'Positiva', ...
    'Negativa', ...
    'Positiva' ...
);

[VAN,VBN,VCN,VAB,VBC,VCA] = calc_Vfase_Vlinha_gerador(ligacao_gerador,sequencia);

%% Impedância do fio
Zfio = 0;

%% Carga em Delta Equilibrada
Vl1 = 200;
Potm1 = 40e3;
Qm1 = 30e3;
Fpm1 = cosd(atand(Qm1/Potm1));

Zc = 3*(Vl1^2)/(sqrt(Potm1^2+Qm1^2));
Zc = Zc*Fpm1 + 1i*Zc*sind(acosd(Fpm1));
get_phasor(Zc)

%% Correntes de Fase da Carga em Delta
'Correntes de Fase da Carga em Delta'
IAB = VAB/Zc;
IBC = VBC/Zc;
ICA = VCA/Zc;
fprintf('Corrente de Fase (IAB): %.4f/%.4f A\n',abs(IAB),angle(IAB)*180/pi);
fprintf('Corrente de Fase (IBC): %.4f/%.4f A\n',abs(IBC),angle(IBC)*180/pi);
fprintf('Corrente de Fase (ICA): %.4f/%.4f A\n\n',abs(ICA),angle(ICA)*180/pi);

%% Correntes de Linha da Carga em Delta
'Correntes de Linha da Carga em Delta'
IA = IAB - ICA;
IB = IBC - IAB;
IC = ICA - IBC;
fprintf('Corrente de Linha IA: %.4f/%.4f A\n',abs(IA),angle(IA)*180/pi);
fprintf('Corrente de Linha IB: %.4f/%.4f A\n',abs(IB),angle(IB)*180/pi);
fprintf('Corrente de Linha IC: %.4f/%.4f A\n\n',abs(IC),angle(IC)*180/pi);

