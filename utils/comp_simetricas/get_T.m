function T = get_T()
    addpath("../apoio")
    a = convert_phasor(1,120);

    T = [1 1 1; 1 (a^2) a; 1 a (a^2)];
end