clear;
% warning('off','all')
% addpath('../utils/desequilibradas')
addpath("../utils/comp_simetricas")
addpath("../utils/curto_circuito")
addpath("../utils/apoio/")
a = convert_phasor(1,120);
dlgtitle = 'Fluxo de Carga';

% Considere a rede elétrica, ilustrada pelo seu diagrama unifilar abaixo.
% Os dados são dessa rede são:
% V1 = 1ej0°pu, P1 = 100 MW, Q1 = 24,7 Mvar, PG4 = 100 MW, QG4 = 40 Mvar
% Linha: xL = 0,43 Ω/km, L1 = L2 = 60 km, Vn = 150 kV
% Transformador:T3: Vn = 18 kV/150 kV, Sn = 340 MVA, xt = 9,8%
% Transformador: T2: Vn = 150 kV/220 kV, Sn = 150 MVA, xt = 7,2%
% Carga: PC2 = 200 MW, QC2 = 50 Mvar.
% Calcule as três tensões nos barramentos 2, 3 e 4. Considere Sb = 100 MVA.


%% Trasnformador T2
'T2 - Base Original'
t2 = trans(150e3,220e3,150e6,0.072,0.072,0.072);

'T2 - Nova Base'
t2_new = trans( ...
    150e3, ...
    150e3/t2.a, ...
    100e6, ...
    convbases(t2.X0,18e3,18e3,150e6,100e6), ...
    convbases(t2.X1,18e3,18e3,150e6,100e6), ...
    convbases(t2.X2,18e3,18e3,150e6,100e6) ...
);

%% Trasnformador T3
'T3 - Base Original'
t3 = trans(18e3,150e3,340e6,0.098,0.098,0.098);

'T3 - Nova Base'
t3_new = trans( ...
    18e3, ...
    18e3/t3.a, ...
    100e6, ...
    convbases(t3.X0,18e3,18e3,340e6,100e6), ...
    convbases(t3.X1,18e3,18e3,340e6,100e6), ...
    convbases(t3.X2,18e3,18e3,340e6,100e6) ...
);

%% Linha de transmissão
'Linha de transmissão'
LT = LT_pu( ...
    '3', ...
    '2', ...
    0.43*60/t3_new.Zbs, ...
    0.43*60/t3_new.Zbs, ...
    0.43*60/t3_new.Zbs ...
);

%% Carga
'Carga'
carga = struct();
carga.P = 200e6;
carga.Q = 50e6;
disp(struct2table(carga));

%% Potencias por barras
S1 = (100e6 + 1i*24.7e6)/100e6;
S2 = (-200e6 - 1i*50e6)/100e6;
S4 = (100e6 + 1i*40e6)/100e6;

%% Matriz de impedância 
Y_m = [
    -1i/t2_new.X0 1i/t2_new.X0 0 0;
    1i/t2_new.X0 -(1i/t2_new.X0 + 1i/LT.x0 + 1i/LT.x0) (1i/LT.x0 + 1i/LT.x0) 0;
    0 (1i/LT.x0 + 1i/LT.x0) -(1i/t3_new.X0 + 1i/LT.x0 + 1i/LT.x0) 1i/t3_new.X0;
    0 0 1i/t3_new.X0 -1i/t3_new.X0
];

Y_m

%% Tensões nas Barras
V1 = convert_phasor(1,0);
'Tensão na barra 1'
get_phasor(V1);
V2 = (conj(S1)-Y_m(1,1))/Y_m(1,2);
'Tensão na barra 2'
get_phasor(V2);
V3 = (conj(S2/V2)-Y_m(2,1)*V1 - Y_m(2,2)*V2)/Y_m(2,3);
'Tensão na barra 3'
get_phasor(V3);
V4 = (0 - Y_m(3,2)*V2 - Y_m(3,3)*V3)/Y_m(3,4);
'Tensão na barra 4'
get_phasor(V4);