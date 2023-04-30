clear;
warning('off','all')
addpath("../utils/comp_simetricas")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Desequilibrados';

%% Gerador
VAN = convert_phasor(220,0);
VBN = convert_phasor(220,90);
VCN = convert_phasor(220,-90);

gerador = [VAN; VBN; VCN];
gerador_comp_simetricas = get_comp_simetricas(gerador);
'Gerador'
get_phasor_m(gerador_comp_simetricas);

%% Cargas Desequilibradas
Zab = 14 + 8i;
Zbc = 14.8 - 6.4i;
Zca = 16 + 28i;

[Za,Zb,Zc] = Zdelta_to_Zestrela(Zab,Zbc,Zca);
[Z0,Z1,Z2,Zl_m] = calc_Z_comp_simetricas(Za,Zb,Zc);

%% Impedância de fio
Zfio = 0.3 + 1i;
[abc,bca,cba,Zfio_m] = calc_Z_comp_simetricas(Zfio,Zfio,Zfio);

%% Associação de Impedâncias
'Impedância Total'
Ztotal = Zfio_m + Zl_m;
get_phasor_m(Ztotal);

%% IA0 = 0A enquanto IA1 e IA2 pode ser encontradas por
IA1_IA2 = Ztotal(2:3,2:3)\gerador_comp_simetricas(2:3,:);
% get_phasor_m(IA1_IA2);
I_seqs_m = [0; IA1_IA2(1); IA1_IA2(2)];
'Correntes de Sequencia'
get_phasor_m(I_seqs_m);

%% Correntes Reais
I_reais_m = get_comp_fase(I_seqs_m);
'Correntes Reais'
get_phasor_m(I_reais_m);

%% Cálculo de VNN
'Cálculo de VNN'
Vnn = sum(Ztotal(1,:)*I_seqs_m) - gerador_comp_simetricas(1);
get_phasor_m(Vnn);