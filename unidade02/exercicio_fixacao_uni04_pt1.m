clear;
addpath("../utils/pu")
addpath("../utils/apoio")
a = convert_phasor(1,120);
dlgtitle = 'Sistemas Monofásico - PU';

%% Gerador
Vg = g_trifasico(18e3,40e6,13.8e3,50e6,0.09,'y','direta');

%% Transformador 1
t1 = trans(22e3,69e3,40e6,0.1);
% ajustando os parametros do transformador para a nova base no primario e
% secundário
t1_new = trans( ...
    13.8e3, ... %Vg.V
    13.8e3/t1.a, ...
    50e6, ...
    convbases(t1.X,22e3,13.8e3,40e6,50e6) ...
);

%% Impedância de Fio
Zfio = 0.0625 + 0.1875i;
Zfiobase = (t1_new.Vbs^2)/t1_new.S;
Zfiopu = Z_pu(Zfio,Zfiobase);

%% Transformador 2
t2 = trans(69e3,13.8e3,40e6,0.08);
% ajustando os parametros do transformador para a nova base no primario e
% secundário
t2_new = trans( ...
    t1_new.Vbs, ...
    t1_new.Vbs/t2.a, ...
    50e6, ...
    convbases(t2.X,t2.Vbp,t1_new.Vbs,40e6,50e6) ...
 );

t2_new.Ibase = t2_new.S/(sqrt(3)*t2_new.Vbs);

%% Tensão na barra 4
% Vbarra1 = t1_new.Vbp;
% Vbarra2 = t1_new.Vbs;
% Vbarra3 = t2_new.Vbp;
Vbarra4 = t2.Vbs;
Vbarra4pu = Vbarra4/t2_new.Vbs;
[Vbarra4A,Vbarra4B,Vbarra4C,Vbarra4AB,Vbarra4BC,Vbarra4CA] = get_V(Vbarra4pu,t2_new.Vbs,'y','positiva');

%% Corrente no Motor Trifásico
% a tensão do motor do transformador é de fase
motor = struct('Sn',15e6,'fp',0.8,'V',convert_phasor(13.8e3,0));
motor.S = convert_phasor(motor.Sn,acosd(motor.fp));
motor.I = conj(motor.S)/(sqrt(3)*motor.V);
% motor ligado no secundário do transformador t2 já sob nova base
motor.Ipu = motor.I/t2_new.Ibase;

%% Corrente na Carga Trifásica
carga = struct('Sn',20e6,'fp',0.9,'V',convert_phasor(13.8e3,0));
carga.S = convert_phasor(carga.Sn,acosd(carga.fp));
carga.I = conj(carga.S)/(sqrt(3)*carga.V);
% motor ligado no secundário do transformador t2 já sob nova base
carga.Ipu = carga.I/t2_new.Ibase;

%% Corrente total no secundário do transformador T2
t2_new.Itotalpu = carga.Ipu + motor.Ipu;

%% Tensão na barra 3
Vbarra3pu = Vbarra4pu + t2_new.Itotalpu*t2_new.X*1i;
Vbarra3pu = Vbarra3pu*convert_phasor(1,-30); % transição de y para delta (seq +)
[Vbarra3A,Vbarra3B,Vbarra3C,Vbarra3AB,Vbarra3BC,Vbarra3CA] = get_V(Vbarra3pu,t2_new.Vbp,'d','positiva');

%% Tensão na barra 2
Vbarra2pu = Vbarra3pu + t2_new.Itotalpu*Zfiopu*convert_phasor(1,-30);
[Vbarra2A,Vbarra2B,Vbarra2C,Vbarra2AB,Vbarra2BC,Vbarra2CA] = get_V(Vbarra2pu,t1_new.Vbs,'d','positiva');

%% Tensão na barra 1
Vbarra1pu = (Vbarra2pu + t2_new.Itotalpu*t1_new.X*1i*convert_phasor(1,-30))*convert_phasor(1,30);
% *convert_phasor(1,-30) e *convert_phasor(1,30)
    % Esse trecho representa a passagem Y-D (T2) e D-Y (T1)
[Vbarra1A,Vbarra1B,Vbarra1C,Vbarra1AB,Vbarra1BC,Vbarra1CA] = get_V(Vbarra1pu,t1_new.Vbp,'y','positiva');