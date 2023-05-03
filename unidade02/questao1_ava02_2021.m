clear;
% warning('off','all')
addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Compoentes Simétricas';

%% Gerador
% VAB = 380/0 V
VAN = convert_phasor(220,-30);
VBN = convert_phasor(0,0);
VCN = convert_phasor(220,90);

gerador = [VAN; VBN; VCN];
gerador_comp_simetricas = get_comp_simetricas(gerador);
'Gerador'
get_phasor_m(gerador_comp_simetricas);

%% Cargas Desequilibradas
% motor 3f - m1
Zm1 = 1.5404 + 1.1549i;
% motor 1f - m2
Zm2 = 2.1780 + 2.9040i;
% motor 1f - m3
Zm3 = 3.9529 + 4.0323i;
% motor 1f - m4
Zm4 = 8.7120 + 4.2194i;

Za = get_paralelo_Zs(Zm1,Zm2);
Zb = get_paralelo_Zs(Zm1,Zm4);
Zc = get_paralelo_Zs(Zm1,Zm3);
Zn = 0.5000 + 0.1000i;

%[Za,Zb,Zc] = Zdelta_to_Zestrela(Zab,Zbc,Zca);
[Z0,Z1,Z2,Zl_m] = calc_Z_comp_simetricas(Za,Zb,Zc);


%% Impedância de fio
Zfio = 0.1000 + 0.0200i;
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