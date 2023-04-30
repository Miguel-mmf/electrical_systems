function S = calc_S(vetor_tensao, vetor_corrente,ref)
    
    V_size = size(vetor_tensao);
    I_size = size(vetor_corrente);

    if (V_size(1) ~= 1) && (V_size(2) ~= 3)
        vetor_tensao = vetor_tensao';
    else
        fprint('O vetor de tensao enviado não possui 3 compoentes!')
    end

    if (I_size(1) ~= 1) && (I_size(2) ~= 3)
        vetor_corrente = vetor_corrente';
    else
        fprint('O vetor de corrente enviado não possui 3 compoentes!')
    end

    conj_correntes = arrayfun(@(x) conj(x),vetor_corrente);
    
    if lower(ref) == 'simetricas'
        S = 3*conj_correntes.*vetor_tensao;
    else
        S = conj_correntes.*vetor_tensao;
    end
end