%  Lab 6  FIR Filters II
%  Written by Brian May and Clark Mallari  
%  March 17th 2017

[s, fs] = audioread('phonetones.wav');

freq = [697 770 852 941 1209 1339 1447];
freq_row = freq(1:4);
freq_col = freq(5:end);


wc = 2 * pi * ((max(freq_row) + min(freq_col))/2) / fs;
N = 73;
M = (N-1) / 2;
k = 0:M;
w = 2 * pi * k / N;
Ak = double(w < wc)';
C = cos(w' * k);
b = C \ Ak;
h = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)];


wtones = 2*pi*[697 770 852 941 1209 1339 1447] / fs;

%Rectangular-window filter 
rect_low = fir1(N-1, wc/pi, rectwin(N));
rect_high(M+1) = -rect_low(M+1) + 1;

hold all
magdb(rect_low);
title('Rectangular-Window lowpass filter');
figure;
magdb(rect_high);
title('Rectangular-Window highpass filter');

% Hamming-window filter
hamm_low = fir1(N-1, wc/pi, hamming(N));
hamm_high(M+1) =-h_low(M+1) + 1;

hold all
figure;
magdb(h_low);
title('Hamming-Window lowpass filter');
figure;
magdb(h_high);
title('Hamming-Window highpass filter');

%Kaiser filter
dw = 0.9 * (wtones(5) - wtones(4));
[num, beta] = kaiserparams(dw, 0.01);
k_low = fir1(N-1, wc/pi, kaiser(N, beta));
k_high(M+1) = -k_low(M+1) + 1;

hold all
figure;
magdb(k_low);
title('Kaiser-Window lowpass filter');
figure;
magdb(k_high);
title('Kaiser-Window Highpass filter');

% Spline filter
dw = 0.77 * (wtones(5) - wtones(4));
s_low = (wc/pi * sinc(wc/pi.*(-M:M)) .* sinc(dw/2/pi .* (-M:M)));
s_high(M+1) = -s_low(M+1) + 1;

hold all
figure;
magdb(s_low);
title('Spline lowpass filter');
figure;
magdb(s_high);
title('Spline highpass filter');

% Frequency-sampled filter
freq_low = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)]; 
freq_high = -freq_low;
freq_high(M+1) = freq_high(M+1) +1;

figure;
magdb(freq_low);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('FREQUENCY SAMPLE LOW PASS FILTER (UNIFORM)');
figure;
magdb(freq_high);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('FREQUENCY SAMPLE HIGH PASS FILTER (UNIFORM)');

w(7:10) = wtones(1:4);
w(12:14) = wtones(5:end);
Ak = double(w < wc)';
C = cos(w' * k);
b = C \ Ak;

freq_low = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)]; 
freq_high = -freq_low;
freq_high(M+1) = freq_high(M+1) +1;

figure;
magdb(freq_low);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('FREQUENCY SAMPLE LOW PASS FILTER (NONUNIFORM)');
figure;
magdb(freq_high);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('FREQUENCY SAMPLE HIGH PASS FILTER (NONUNIFORM)');

% Optimum filter
opt_low = firpm(N-1, [0 wtones([4 5])/pi 1], [1 1 0 0]);
opt_high(M+1) = -opt_low(M+1) + 1;

figure;
hold all
magdb(opt_low);
title('Optimum lowpass filter');
figure;
magdb(opt_high);
title('Optimum highpass filter');
