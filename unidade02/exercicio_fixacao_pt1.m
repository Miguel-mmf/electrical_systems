clear;
addpath("../utils/pu")
addpath("../utils/apoio")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Monofásico - PU';

%% Gerador
Vg = convert_phasor(480,0);

%% Transformador 1
t1 = trans(480,4.8e3,10e3,0.05,'-');

%% Transformador 2
t2 = trans(4.8e3,240,10e3,0.05,'-');

%% Impedância de Fio
Zfio = 20 + 60i;

%% Impedância de Carga
Zl = convert_phasor(10,30);

%% Gerador em PU
Vgpu = Vg/t1.Vbp;

%% Impedância de Fio em PU
Zfiopu = Z_pu(Zfio,t1.Zbs);

%% Impedância de Carga em PU
Zlpu = Z_pu(Zl,t2.Zbs);

%% Corrente no Circuito Monofásico em PU
Ipu = Vgpu/(Zfiopu+Zlpu+t1.X+t2.X);
get_phasor(Ipu);

%% Potencia dissipada na impedância de linha
Pfiopu = real(Zfiopu)*(abs(Ipu)^2);
Pfio = Pfiopu*t1.S;

%% Potencia dissipada na impedância de carga
Plpu = real(Zlpu)*(abs(Ipu)^2);
Pl = Plpu*t1.S;

%% Corrente no Circuito Monofásico
I = Ipu*(t2.S/t2.Vs);
get_phasor(I);