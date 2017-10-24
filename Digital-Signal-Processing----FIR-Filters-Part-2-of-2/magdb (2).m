function ph = magdb(h) 
    % MAGDB Display magnitude of Fourier transform of h[n] on a dB scale. 
    % ph = magdb(h) 
    
%     % for lab 5
%     N = 1024;
%     H = fft(h,N);
%     mag = abs(H);
%     ph = plot(linspace(0,1,N/2+1),20*log10(mag(1:length(mag)/2+1)));
    
    %for lab 6
    N = 1024;
    H = fft(h,N);
    mag = abs(H);
    magHdb = 20*log10(mag);
    
    hold all;
    ph = plot(linspace(0,0.5,N/4+1), 20*log10(mag(1:length(mag)/4+1)));
    axis([0 0.5 -60 10])
    ylabel('|H(\omega)|_{db}');
    xlabel('\omega(rad/\pi)');
    grid on;
    
    [s, fs] = audioread('phonetones.wav');
    wtones = 2*pi*[697 770 852 941 1209 1339 1447] / fs;
    Atones = 1:7;
    for i = 1:7
        Atones(i) = magHdb(round(wtones(i)*N/(2*pi)));
        plot([wtones(i)/pi wtones(i)/pi], [-60 10], 'g')
    end
    
    scatter(wtones(1:4)/pi, Atones(1:4), 'filled', 'r');
    scatter(wtones(5:end)/pi, Atones(5:end), 'filled', 'b');
end