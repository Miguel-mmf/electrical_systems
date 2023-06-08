clear
clc
close all

%--- Potências ---%
Sbase = 100e6;
Vbase1 = 13.8e3;
Vbase2 = 138e3;
Vbase3 = 13.8e3;

S1 = ((20e6 - 0) + j*(8.4e6 - 0))/Sbase;
S2 = ((0 - 10e6) + j*(0 - 4e6))/Sbase;
S3 = ((0 - 20e6) + j*(0 - 10.8e6))/Sbase;
S4 = ((0 - 0) + j*(0 - 0))/Sbase;
S5 = ((15e6 - 0) + j*(6e6 - 0))/Sbase;

%--- Impedâncias ---%
T1 = j*0.2286;
T2 = j*0.4;
LTbc = j*0.0788;
LTcd = j*0.06301;

%--- Admitâncias ---%
y11 = 1/T1;
y12 = (1/T1);
y13 = 0;
y14 = 0;
y15 = 0;

y21 = (y12);
y22 = (1/T1 + 1/LTbc);
y23 = (1/LTbc);
y24 = 0;
y25 = 0;

y31 = 0;
y32 = y23;
y33 = 1/LTbc + 1/LTcd;
y34 = (1/LTcd);
y35 = 0;

y41 = 0;
y42 = 0;
y43 = y34;
y44 = 1/LTcd + 1/T2;
y45 = (1/T2);

y51 = 0;
y52 = 0;
y53 = 0;
y54 = y45;
y55 = 1/T2;

%--- Matriz de admitância ---%
Ybus = [y11, -y12, -y13, -y14, -y15;
       -y21,  y22, -y23, -y24, -y25;
       -y31, -y32,  y33, -y34, -y35;
       -y41, -y42, -y43,  y44, -y45;
       -y51, -y52, -y53, -y54,  y55];


%--- Tensões ---%
V1_mod = 1.05;
V1_angle = 0;
V1 = V1_mod*exp(j*V1_angle);

V2 = ((conj(S1)/conj(V1))-(Ybus(1,1)*V1))/(Ybus(1,2));
V2_mod = abs(V2)
V2_angle = angle(V2)

V3 = ((conj(S2)/conj(V2))-(Ybus(2,1)*V1 + Ybus(2,2)*V2))/(Ybus(2,3));
V3_mod = abs(V3)
V3_angle = angle(V3)

V4 = ((conj(S3)/conj(V3))-(Ybus(3,2)*V2 + Ybus(3,3)*V3))/(Ybus(3,4));
V4_mod = abs(V4)
V4_angle = angle(V4)

V5 = ((conj(S4)/conj(V4))-(Ybus(4,3)*V3 + Ybus(4,4)*V4))/(Ybus(4,5));
V5_mod = abs(V5)
V5_angle = angle(V5)

%--- Corrente em LTbc ---%
Ibc = (V2 - V3)/LTbc;
Ibc_mod = abs(Ibc)
Ibc_angle = angle(Ibc)

Ibca = Ibc*(Sbase/(sqrt(3)*Vbase2));
Ibca_mod = abs(Ibca)
Ibca_angle = angle(Ibca)

Ibcb_angle = rad2deg(Ibca_angle) - 120
Ibcc_angle = rad2deg(Ibca_angle) + 120

