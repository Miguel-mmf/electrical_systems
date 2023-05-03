clear;
addpath("../utils/pu")
addpath("../utils/apoio")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas PU';

%% Gerador
'Gerador'
Vg = g_trifasico(15e3,60e6,15e3,60e6,0.15,'y','direta');

%% Trasnformador T1
'T1 - Base Antiga'
t1 = trans(15e3,115e3,70e6,0.1);

% Vold,Vnew,Sold,Snew
'T1 - Nova Base'
t1_new = trans( ...
    15e3, ...
    15e3/t1.a, ...
    60e6, ...
    convbases(t1.X,15e3,15e3,70e6,60e6) ...
);


%% Trasnformador T2
'T2 - Base Antiga'
t2 = trans(115e3,15e3,70e6,0.1);

'T2 - Nova Base'
t2_new = trans( ...
    t1_new.Vbs, ...
    t1_new.Vbs/t2.a, ...
    60e6, ...
    convbases(t2.X,t2.Vp,t1_new.Vbs,t2.S,t1_new.S) ...
);

%% Cargas

    %% Motor 1
'Motor'
motor1 = carga(12.5e3,15e6,0.12,0.9,0.9);

    %% Motor 2
'Motor'
motor2 = carga(12.5e3,25e6,0.12,0.9,0.85);

    %% Motor 3
'Motor'
motor3 = carga(12.5e3,12e6,0.12,0.9,0.9);