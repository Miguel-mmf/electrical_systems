function Z_fio = get_Zfio_Eq()
    a = convert_phasor(1,120);
    dlgtitle = 'Sistemas Trifásicos';
    Z_fio = inputdlg( ...
        {'Valor da Impedância do Fio:'}, ...
        dlgtitle, ...
        [1 70], ...
        {'0.2+0.5i'} ...
    );

    Z_fio = str2num(Z_fio);
    'Impedância no Fio'
    fprintf('\n\nImpedância d: %.2f j%.2f Ω\n',real(Z_fio),imag(Z_fio));
    fprintf('Fasor da Impedância do Fio: %.2f/%.2f Ω\n',abs(Z_fio),angle(Z_fio)*180/pi);
end