function comp_fase = get_comp_fase(vetor_comp_simetricas)

    T = get_T();

    if length(vetor_comp_simetricas) == 3
        comp_fase = T*vetor_comp_simetricas;
    else
        fprintf('O vetor com componentes simétricas enviado não possui 3 compoentes de tensão ou corrente!')
    end
end