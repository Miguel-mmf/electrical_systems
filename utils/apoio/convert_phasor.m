function c_num = convert_phasor(mod,ang_d)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    c_num = mod*(cosd(ang_d) + 1i*sind(ang_d));
end