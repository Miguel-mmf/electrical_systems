% addpath("./utils/apoio")

function g = g_trifasico(V,S,Vbase,Sbase,X0,X1,X2,ligacao,sequencia)
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
            g.X0 = convbases(X0,V,Vbase,S,Sbase);
            g.X1 = convbases(X1,V,Vbase,S,Sbase);
            g.X2 = convbases(X2,V,Vbase,S,Sbase);
        else
            g.X0 = X0;
            g.X1 = X1;
            g.X2 = X2;
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
            g.X0 = convbases(X0,V,Vbase,S,Sbase);
            g.X1 = convbases(X1,V,Vbase,S,Sbase);
            g.X2 = convbases(X2,V,Vbase,S,Sbase);
        else
            g.X0 = X0;
            g.X1 = X1;
            g.X2 = X2;
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