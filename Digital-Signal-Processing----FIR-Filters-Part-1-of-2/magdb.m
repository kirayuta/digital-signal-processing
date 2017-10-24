function ph = magdb(h)
    % Convert magnitude to decibels
w = linspace(0,2,1024);
H = fft(h,1024);
ph = plot(w,20 * log10(abs(H))); 
xlim([0,1]);

end