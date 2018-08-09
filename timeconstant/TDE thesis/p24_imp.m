% input delay signal
function p24_imp(signal)
    a = fft(signal);
    a = abs(real(a));
    a = log(a);
    b = ifft(a);
    plot(b)

end