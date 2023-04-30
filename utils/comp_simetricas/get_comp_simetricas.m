function comp_simetricas = get_comp_simetricas(vetor)

    T = get_T();

    if length(vetor) == 3
        comp_simetricas = inv(T)*vetor;
    else
        fprintf('O vetor enviado não possui 3 compoentes de tensão ou corrente!')
    end
end