function Zeq = get_paralelo_Zs(Z1,Z2)

    Zeq = (Z1*Z2)/(Z1+Z2);
%     fprintf('Impedância equivalente: %.4f/%.4f\n',abs(Zeq),angle(Zeq)*180/pi);
end