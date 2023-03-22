function r = get_phasor(phasor)
    
    r = [abs(phasor) (angle(phasor)*180/pi)];
    fprintf(" %.4f/%.4f\n",abs(r(1)),r(2));
end

