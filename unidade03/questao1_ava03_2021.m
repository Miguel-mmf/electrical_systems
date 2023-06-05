clear;
% warning('off','all')
% addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/curto_circuito")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Componentes Simétricas';

%% Gerador 1
'Gerador 1'
Vg1 = g_trifasico(13.8e3,100e6,13.8e3,100e6,0.1,0.15,0.15,'y','direta');

%% Gerador 2
'Gerador 2'
Vg2 = g_trifasico(13.8e3,100e6,13.8e3,100e6,0.07,0.2,0.2,'y','direta');

%% Trasnformador T1 - Núcleo Envolvente
'T1 - Base Original'
t1 = trans(13.8e3,138e3,100e6,0.1,0.1,0.1);
t1.lig_p = 'd';
t1.lig_s = 'yt';

%% Trasnformador T2 - Núcleo Envolvente
'T2 - Base Original'
t2 = trans(13.8e3,138e3,100e6,0.15,0.15,0.15);
t1.lig_p = 'yt';
t1.lig_s = 'y';

%% Linhas de transmissão
'Linhas de transmissão'
LT1 = LT_pu( ...
    'b', ...
    'c', ...
    0.32*70, ...
    0.28*70, ...
    0.28*70 ...
);

LT2 = LT_pu( ...
    'b', ...
    'c', ...
    0.32*70, ...
    0.28*70, ...
    0.28*70 ...
);