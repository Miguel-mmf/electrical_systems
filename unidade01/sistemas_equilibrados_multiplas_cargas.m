% clc;
clear;
addpath("./utils/apoio/")
addpath("./utils/equilibradas/")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Trifásicos';

ligacao_gerador = get_ligacao(dlgtitle);

sequencia = questdlg( ...
    'Qual a sequência de fase?', ...
    dlgtitle, ...
    'Positiva', ...
    'Negativa', ...
    'Positiva' ...
);

[VAN,VBN,VCN,VAB,VBC,VCA] = calc_Vfase_Vlinha_gerador(ligacao_gerador,sequencia);

if ligacao_gerador == 'Δ'
    conversao_gerador = questdlg( ...
        'Deseja converter a ligação do gerador para Ligação Estrela (Y)?', ...
        dlgtitle, ...
        'Sim', ...
        'Não', ...
        'Sim' ...
    );
    
    if conversao_gerador == 'Sim'
        [VAN,VBN,VCN,VAB,VBC,VCA] = Vdelta_to_Vestrela(VAN,VBN,VCN,sequencia);
    end
end

Zfio = get_Zfio_Eq();

num_cargas = inputdlg( ...
    {'Qual o numero de cargas equilibradas ligadas ao gerador? '}, ...
    dlgtitle, ...
    [1 40], ...
    {'1'} ...
);
num_cargas = str2num(num_cargas{1});

%% Cargas ligadas ao sistemas de alimentação
if num_cargas >= 1
    Zcarga = zeros(1,num_cargas);
    ligacao_Zcarga = strings(1,num_cargas);

    for i = 1:num_cargas
        Zcarga(i) = get_Zcarga_Eq(i);
        ligacao_Zcarga(i) = get_ligacao(['Ligacão da ',i,'ª Carga Equilibrada']);
    end
end

%% Conversão da ligação das cargas em delta para estrela
if num_cargas > 1
    for i = 1:num_cargas
        if ligacao_Zcarga(i) == 'Δ'
            Zcarga(i) = Zdelta_to_Zestrela(Zcarga(i));
        end
    end
elseif ligacao_Zcarga(1) == 'Δ'
    if ligacao_gerador == 'Y'
        Zcarga(1) = Zdelta_to_Zestrela(Zcarga(1));
        Zeq = Zcarga(1) + Zfio;
    else
        Zcarga(1) = Zdelta_to_Zestrela(Zcarga(1));
        Zeq = Zcarga(1) + Zfio;
        Zeq = Zestrela_to_Zdelta(Zeq);
    end
end

%% Associação em paralelo de todas as cargas

if num_cargas > 1
    Zcarga_eq = 0;
    for i = 1:(num_cargas-1)
        Zcarga_eq = Zcarga_eq + ((Zcarga(i)*Zcarga(i+1))/(Zcarga(i)+Zcarga(i+1))); 
    end
end

%% Inserindo impedância do fio em série

if num_cargas > 1
    if Zfio == 0
        Zeq = Zcarga_eq;
    else
        Zeq = Zcarga_eq + Zfio;
    end
end

%% Cálculo das correntes de linha
if ligacao_gerador == 'Y'
    IAA = VAN/Zeq;
    IBB = VBN/Zeq;
    ICC = VCN/Zeq;
else
    IAB = VAB/Zeq;
    IBC = VBC/Zeq;
    ICA = VCA/Zeq;
    IAA = IAB - ICA;
    IBB = IBC - IAB;
    ICC = ICA - IBC;
end

fprintf('Corrente de Linha IAA: %.2f/%.2f A\n',abs(IAA),angle(IAA)*180/pi);
fprintf('Corrente de Linha IBB: %.2f/%.2f A\n',abs(IBB),angle(IBB)*180/pi);
fprintf('Corrente de Linha ICC: %.2f/%.2f A\n\n',abs(ICC),angle(ICC)*180/pi);

%% Módulo da queda de tensão nas impedâncias do fio
Vfio = abs(IAA)*Zfio;
fprintf('\nMódulo da Queda de Tensão de Linha VAB: %.2f V\n',Vfio);

%% Inserindo a queda de tensão no fio
VAN = VAN - Vfio;
VBN = VBN - Vfio;
VCN = VCN - Vfio;
VAB = VAN - VBN;
VBC = VBN - VCN;
VCA = VCN - VAN;

%% Tensões de fase e linha em cada uma das cargas

Z_carga = Zcarga;

if num_cargas == 1
    i = 1;

    if ligacao_Zcarga(1) == 'Δ'
        Vcarga_A = IAB*Zcarga(i);
        Vcarga_B = IBC*Zcarga(i);
        Vcarga_C = ICA*Zcarga(i);
        fprintf('\nTensão de Fase e Linha (A) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_A),angle(Vcarga_A)*180/pi);
        fprintf('Tensão de Fase e Linha (B) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_B),angle(Vcarga_B)*180/pi);
        fprintf('Tensão de Fase e Linha (C) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_C),angle(Vcarga_C)*180/pi);
        fprintf('Corrente de Fase IAB na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IAB),angle(IAB)*180/pi);
        fprintf('Corrente de Fase IBC na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IBC),angle(IBC)*180/pi);
        fprintf('Corrente de Fase ICA na carga %.2f j%.2f Ω: %.2f/%.2f A\n\n',real(Z_carga(i)),imag(Z_carga(i)),abs(ICA),angle(ICA)*180/pi);
        fprintf('Corrente de Linha IAN na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IAN),angle(IAN)*180/pi);
        fprintf('Corrente de Linha IBN na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IBN),angle(IBN)*180/pi);
        fprintf('Corrente de Linha ICN na carga %.2f j%.2f Ω: %.2f/%.2f A\n\n',real(Z_carga(i)),imag(Z_carga(i)),abs(ICN),angle(ICN)*180/pi);
    end

else
    for i = 1:num_cargas
    
        if ligacao_Zcarga(i) == 'Δ'
    %         Zcarga(i) = Zdelta_to_Zestrela(Zcarga(i));
            fprintf('\n\nImpedância de carga - Ligação Triângulo (Δ): %.2f j%.2f Ω\n',real(Z_carga(i)),imag(Z_carga(i)));
            IAB = VAB/Zcarga(i);
            IBC = VBC/Zcarga(i);
            ICA = VCA/Zcarga(i);
            IAN = IAB - ICA;
            IBN = IBC - IAB;
            ICN = ICA - IBC;
            Vcarga_A = IAB*Zcarga(i);
            Vcarga_B = IBC*Zcarga(i);
            Vcarga_C = ICA*Zcarga(i);
            fprintf('\nTensão de Fase e Linha (A) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_A),angle(Vcarga_A)*180/pi);
            fprintf('Tensão de Fase e Linha (B) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_B),angle(Vcarga_B)*180/pi);
            fprintf('Tensão de Fase e Linha (C) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_C),angle(Vcarga_C)*180/pi);
            fprintf('Corrente de Fase IAB na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IAB),angle(IAB)*180/pi);
            fprintf('Corrente de Fase IBC na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IBC),angle(IBC)*180/pi);
            fprintf('Corrente de Fase ICA na carga %.2f j%.2f Ω: %.2f/%.2f A\n\n',real(Z_carga(i)),imag(Z_carga(i)),abs(ICA),angle(ICA)*180/pi);
            fprintf('Corrente de Linha IAN na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IAN),angle(IAN)*180/pi);
            fprintf('Corrente de Linha IBN na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IBN),angle(IBN)*180/pi);
            fprintf('Corrente de Linha ICN na carga %.2f j%.2f Ω: %.2f/%.2f A\n\n',real(Z_carga(i)),imag(Z_carga(i)),abs(ICN),angle(ICN)*180/pi);
        else
            fprintf('\n\nImpedância de carga - Ligação Estrela (Y): %.2f j%.2f Ω\n',real(Z_carga(i)),imag(Z_carga(i)));
            Vcarga_A = IAA*Zcarga(i);
            Vcarga_B = IBB*Zcarga(i);
            Vcarga_C = ICC*Zcarga(i);
    %         VAB = V
    %         VBC = 
    %         VCA = 
            fprintf('\nTensão de Fase (A) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_A),angle(Vcarga_A)*180/pi);
            fprintf('Tensão de Fase (B) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_B),angle(Vcarga_B)*180/pi);
            fprintf('Tensão de Fase (C) na carga %.2f j%.2f Ω: %.2f/%.2f V\n',real(Z_carga(i)),imag(Z_carga(i)),abs(Vcarga_C),angle(Vcarga_C)*180/pi);
            fprintf('Corrente de Linha e Fase (IAA) na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IAA),angle(IAA)*180/pi);
            fprintf('Corrente de Linha e Fase (IBB) na carga %.2f j%.2f Ω: %.2f/%.2f A\n',real(Z_carga(i)),imag(Z_carga(i)),abs(IBB),angle(IBB)*180/pi);
            fprintf('Corrente de Linha e Fase (ICC) na carga %.2f j%.2f Ω: %.2f/%.2f A\n\n',real(Z_carga(i)),imag(Z_carga(i)),abs(ICC),angle(ICC)*180/pi);
        end
    end
end