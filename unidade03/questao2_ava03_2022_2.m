clear;
% warning('off','all')
% addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/curto_circuito")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Fluxo de Carga';

%% Gerador 1
'Gerador 1'
Vg1 = g_trifasico(13.8e3,30e6,13.8e3,30e6,0.1,0.1,0.1,'y','direta');
Vg1.P = 20e6;
Vg1.Q = 8.4e6;

%% Gerador 2
'Gerador 2'
Vg2 = g_trifasico(13.8e3,20e6,13.8e3,20e6,0.07,0.2,0.2,'y','direta');
Vg2.P = 15e6;
Vg2.Q = 6e6;

%% Trasnformador T1
'T1 - Base Original'
t1 = trans(13.8e3,138e3,35e6,0.08,0.08,0.08);

'T1 - Nova Base'
t1_new = trans( ...
    13.8e3, ...
    13.8e3/t1.a, ...
    100e6, ...
    convbases(t1.X0,13.8e3,13.8e3,35e6,100e6), ...
    convbases(t1.X1,13.8e3,13.8e3,35e6,100e6), ...
    convbases(t1.X2,13.8e3,13.8e3,35e6,100e6) ...
);

%% Trasnformador T2
'T2 - Base Original'
t2 = trans(13.8e3,138e3,25e6,0.1,0.1,0.1);

'T2 - Nova Base'
t2_new = trans( ...
    13.8e3, ...
    13.8e3/t2.a, ...
    100e6, ...
    convbases(t2.X0,13.8e3,13.8e3,25e6,100e6), ...
    convbases(t2.X1,13.8e3,13.8e3,25e6,100e6), ...
    convbases(t2.X2,13.8e3,13.8e3,25e6,100e6) ...
);

%% Linhas de transmissão
'Linhas de transmissão'
LTbc = LT_pu( ...
    'b', ...
    'c', ...
    0.25*60/t1_new.Zbs, ...
    0.25*60/t1_new.Zbs, ...
    0.25*60/t1_new.Zbs ...
);

LTcd = LT_pu( ...
    'c', ...
    'd', ...
    0.3*40/t1_new.Zbs, ...
    0.3*40/t1_new.Zbs, ...
    0.3*40/t1_new.Zbs ...
);

%% Carga na barra B
'Carga na barra B'
carga1 = struct();
carga1.P = 10e6;
carga1.Q = 4e6;
disp(struct2table(carga1));

%% Carga na barra C
'Carga na barra C'
carga2 = struct();
carga2.P = 20e6;
carga2.Q = 10.8e6;
disp(struct2table(carga2));

%% Potencias por barras
SA = (20e6 + 1i*8.4e6)/100e6;
SB = (-10e6 - 1i*4e6)/100e6;
SC = (-20e6 - 1i*10.8e6)/100e6;
SD = 0;
SE = (15e6 + 1i*6e6)/100e6;

%% Admitâncias

y11 = 1/(1i*t1_new.X0);
y12 = -1/(1i*t1_new.X0);
y13 = 0;
y14 = 0;
y15 = 0;

y21 = -1/(1i*t1_new.X0);
y22 = 1/(1i*t1_new.X0) + 1/(1i*LTbc.X0);
y23 = -1/(1i*LTbc.X0);
y24 = 0;
y25 = 0;

y31 = 0;
y32 = y23;
y33 = 1/(1i*LTcd.X0) + 1/(1i*LTbc.X0);
y34 = -1/(1i*LTcd.X0);
y35 = 0;

y41 = 0;
y42 = 0;
y43 = y34;
y44 = 1/(1i*t2_new.X0) + 1/(1i*LTcd.X0);
y45 = -1/(1i*t2_new.X0);

y51 = 0;
y52 = 0;
y53 = 0;
y54 = y45;
y55 = 1/(1i*t2_new.X0);


%% Matriz de impedância 
Y_m = [y11, y12, y13, y14, y15;
       y21,  y22, y23, y24, y25;
       y31, y32, y33, y34, y35;
       y41, y42, y43,  y44, y45;
       y51, y52, y53, y54,  y55];
get_phasor_m(Y_m);


%% Tensão na barra B
Va = convert_phasor(1.05,0);

Vb = (conj(SA) - y11*conj(Va)*Va)/(y12*conj(Va));
get_phasor(Vb);

Vc = (conj(SB) - y21*conj(Vb)*Va - y22*conj(Vb)*Vb)/(y23*conj(Vb));
get_phasor(Vc);

Vd = (conj(SC) - y32*conj(Vc)*Vb - y33*conj(Vc)*Vc)/(y34*conj(Vc));
get_phasor(Vd);

Ve = (conj(SD) - y43*conj(Vd)*Vc - y44*conj(Vd)*Vd)/(y45*conj(Vd));
get_phasor(Ve);


%% Corrente na linha BC

Ibc = (Vb-Va)/(1i*LTbc.X0);
get_phasor(Ibc);

Ibc_real = Ibc*t1_new.Ibases;
get_phasor(Ibc_real);

get_phasor(Ibc_real*(a^2));
get_phasor(Ibc_real*(a));