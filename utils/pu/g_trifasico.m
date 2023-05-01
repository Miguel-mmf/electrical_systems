% addpath("./utils/apoio")

function g = g_trifasico(V,S,Vbase,Sbase,X,ligacao,sequencia)
    a = convert_phasor(1,120);
    VAB = convert_phasor(V,0);
    g = struct();
    g.lig = ligacao;
    g.seq = sequencia;

    if ligacao == 'y'

        if sequencia == 'direta'
            VBC = VAB*(a^2);
            VCA = VAB*a;
        else
            VBC = VAB*a;
            VCA = VAB*(a^2);
        end

        if S ~= Sbase || V ~= Vbase
            g.X = convbases(X,V,Vbase,S,Sbase);
        else
            g.X = X;
        end

    elseif ligacao == 'd'

        if sequencia == 'direta'
            VBC = VAB*(a^2);
            VCA = VAB*a;
        else
            VBC = VAB*a;
            VCA = VAB*(a^2);
        end

        if S ~= Sbase || V ~= Vbase
            g.X = convbases(X,V,Vbase,S,Sbase);
        else
            g.X = X;
        end
    else
        error('Ligacao precisa ser delta (d) ou estrela (y)!s')
    end
    
    g.S = Sbase;
    g.V = Vbase;
    g.VAB = VAB;
    g.VBC = VBC;
    g.VCA = VCA;

    disp(struct2table(g));
end