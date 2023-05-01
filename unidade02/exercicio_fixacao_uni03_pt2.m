clear;
addpath("../utils/pu")
addpath("../utils/apoio")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas PU';

%% Gerador
'Gerador'
Vg = g_trifasico(13.8e3,30e6,13.8e3,30e6,0.15,'y','direta');

%% Trasnformador T1
'T1 - Base Antiga'
t1 = trans(13.2e3,138e3,35e6,0.1);

'T1 - Nova Base'
t1_new = trans( ...
    13.8e3, ...
    13.8e3/t1.a, ...
    30e6, ...
    convbases(0.1,13.2e3,13.8e3,35e6,30e6) ...
);


%% Trasnformador T2
'T2 - Base Antiga'
t2 = trans(138e3,18e3,20e6,0.1);

'T2 - Nova Base'
t2_new = trans( ...
    t1_new.Vbs, ...
    t1_new.Vbs/t2.a, ...
    30e6, ...
    convbases(0.1,t2.Vp,t1_new.Vbs,t2.S,t1_new.S) ...
);


%% Trasnformador T3
'T3 - Base Antiga'
t3 = trans(138e3,13.2e3,15e6,0.12);

'T3 - Nova Base'
t3_new = trans( ...
    t1_new.Vbs, ...
    t1_new.Vbs/t3.a, ...
    30e6, ...
    convbases(0.12,t3.Vp,t1_new.Vbs,t3.S,t1_new.S) ...
);

%% Motor
'Motor'
motor = carga(13.8e3,10e6,0.12,0.9);