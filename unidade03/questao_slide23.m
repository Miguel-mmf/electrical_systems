clear;
% warning('off','all')
% addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/curto_circuito")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Componentes Simétricas';

%% Gerador
'Gerador'
Vg = g_trifasico(13.8e3,30e6,13.8e3,30e6,0.5,0.2,0.15,'y','direta');

%% Trasnformador T1 - Núcleo Envolvente
'T1 - Base Original'
t1 = trans(13.8e3,69e3,30e6,0.1,0.1,0.1);

%% Linha de transmissão
'Linha de transmissão'
LT = LT_pu( ...
    'b', ...
    'c', ...
    47.61/t1.Zbs, ...
    15.87/t1.Zbs, ...
    15.87/t1.Zbs ...
);

%% Desenvolvimento
% Como o curto-circuito é monofásico à terra na fase 'a' da barra 'c'
% o circuito de cada sequência será ligado em série da seguinte forma:
% seq+ -> seq- -> seq0
% Apesar da fase "a” estar em contato com o solo, o bloqueio do transformador de núcleo envolvente não dá condições para que o relé de neutro atue corretamente 
% Dessa forma, a corrente Ia = Ib = Ic = 0 A, uma vez que o transformador
% de núcleo envolvente não permite a passagem da corrente de curto no
% circuito de sequência 0.

% Por outro lado, considerando o transformador de núcleo envolvido, é
% possível utilizar a mesma ideia apresentada anteriormente e ligar as 3
% redes de sequência em série. Devido a construção do transformador de
% núcleo envolvido, será possível a circulação de uma corrente na ligação
% série das redes de sequência. Dessa forma,

'Corrente em pu do curto na fase a'
Ia0 = (Vg.VAB/Vg.V)/(1i*(Vg.X1+Vg.X2 + (5*t1.X0)+t1.X1+t1.X2 + LT.x0+LT.x1+LT.x2));
Ia1 = Ia0;
Ia2 = Ia0;
get_phasor_m(Ia0);

Ilinha = get_comp_fase([Ia0; Ia1; Ia2]);

'Corrente real do curto na fase a'
IA = t1.Ibases*(sum(Ilinha)); % as correntes na fase b e c são nulas.
get_phasor_m(IA);


%% Conversão de Bases para o Transformador
% Vold,Vnew,Sold,Snew
% 'T1 - Nova Base'
% t1_new = trans( ...
%     13.8e3, ...
%     13.8e3/t1.a, ...
%     30e6, ...
%     convbases(t1.X0,15e3,13.8e3,30e6,30e6), ...
%     convbases(t1.X1,15e3,13.8e3,30e6,30e6), ...
%     convbases(t1.X2,15e3,13.8e3,30e6,30e6), ...
% );