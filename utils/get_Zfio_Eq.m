function Z_fio = get_Zfio_Eq()
    a = convert_phasor(1,120);
    dlgtitle = 'Sistemas Trifásicos';
    Z_fio = inputdlg( ...
        {'Parte Real das Impedâncias do Fio:','Parte Imaginária das Impedâncias do Fio:'}, ...
        dlgtitle, ...
        [1 70], ...
        {'0.2','0.5'} ...
    );

    Z_fio = str2num(Z_fio{1}) + 1i*str2num(Z_fio{2});

    fprintf('\n\nImpedância d: %.2f j%.2f Ω\n',real(Z_fio),imag(Z_fio));
    fprintf('Fasor da Impedância do Fio: %.2f/%.2f Ω\n',abs(Z_fio),angle(Z_fio)*180/pi);
end