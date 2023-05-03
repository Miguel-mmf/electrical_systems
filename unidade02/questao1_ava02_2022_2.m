clear;
warning('off','all')
addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Compoentes Simétricas';

%% Gerador
% VAB = 380/30 V
VAN = convert_phasor(110,0);
VBN = convert_phasor(220,-120);
VCN = convert_phasor(220,120);

gerador = [VAN; VBN; VCN];
gerador_comp_simetricas = get_comp_simetricas(gerador);
'Gerador'
get_phasor_m(gerador_comp_simetricas);

%% Cargas Desequilibradas
Zml = convert_phasor(82.764,25.8419);
Zba = convert_phasor(25.41,45.5729);
Zmic = convert_phasor(60.5,0);
Zfre = convert_phasor(44.528,36.8699);
Zil1 = convert_phasor(191.58,18.1949);
Zil2 = convert_phasor(208.6578,14.0699);

Za = get_paralelo_Zs(Zba,Zil1);
Zb = get_paralelo_Zs(Zfre,Zil2);
Zc = get_paralelo_Zs(Zmic,Zml);
Zn = 0.4435 + 0.0085i;

[Z0,Z1,Z2,Zl_m] = calc_Z_comp_simetricas(Za,Zb,Zc);


%% Impedância de fio
Zfio = Zn;
[abc,bca,cba,Zfio_m] = calc_Z_comp_simetricas(Zfio,Zfio,Zfio);


%% Associação de Impedâncias
'Impedância Total'
Ztotal = Zfio_m + Zl_m + [3*Zn 0 0; 0 0 0; 0 0 0];
get_phasor_m(Ztotal);

%% IA0 = 0A enquanto IA1 e IA2 pode ser encontradas por
% As componentes simétricas das correntes nos fios ( A0 I , A1 I e A2 I ) em Ampère durante o defeito
I_seqs_m = inv(Ztotal)*gerador_comp_simetricas;
'Correntes de Sequencia'
get_phasor_m(I_seqs_m);


%% Correntes Reais
I_reais_m = get_comp_fase(I_seqs_m);
'Correntes Reais'
get_phasor_m(I_reais_m);


%% Corrente no Neutro
In = sum(I_reais_m);
'Corrente no Neutro'
get_phasor(In);

%% Cálculo de VNN
'Cálculo de VNN'
Vnn = sum(Ztotal(1,:)*I_seqs_m) - gerador_comp_simetricas(1);
get_phasor_m(Vnn);


%% Potência por Fase
% A perda elétrica em cada fase (A, B e C) da instalação durante o defeito
'Perdas na instalação por fase'
perdas_instalacao = abs(I_reais_m.^2).*abs(Zfio);
get_phasor_m(perdas_instalacao);