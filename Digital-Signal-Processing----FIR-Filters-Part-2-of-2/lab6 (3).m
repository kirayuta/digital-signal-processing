
% Lab 6 FIR filters II
% Ernesto Casillas & Farnam Adelkhani
% Engr 451 Section 3152 Fri 1:10 - 3:55
% 4/3/17 


close all

[s, fs] = audioread('Phonetones.wav');

freq = [697 770 852 941 1209 1339 1447];
freq_row = freq(1:4);
freq_col = freq(5:end);


wc = 2 * pi * ((max(freq_row) + min(freq_col))/2) / fs;
M = (N-1) / 2;
N = 73;
k = 0:M;
w = 2 * pi * k / N;
Ak = double(w < wc)';
C = cos(w' * k);
h = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)];
b = C \ Ak;



wtones = 2*pi*[697 770 852 941 1209 1339 1447] / fs;

%% Rectangular-window filter 

rect_lp = fir1(N-1, wc/pi, rectwin(N));
rect_hp = -rect_lp;
rect_hp(M+1) = rect_hp(M+1) + 1;

hold all
magdb(rect_lp);
title('Rectangular window low pass filter');
figure;
magdb(rect_hp);
title('Rectangular window high pass filter');

%% Hamming-window filter

ham_lp = fir1(N-1, wc/pi, hamming(N));
ham_hp = -ham_lp;
ham_hp(M+1) = ham_hp(M+1) + 1;

hold on
figure;
magdb(ham_lp);
title('Hamming low pass filter');
figure;
magdb(ham_hp);
title('Hamming high pass filter');
hold off

%% Kaiser filter

dw = 0.9 * (wtones(5) - wtones(4));
[num, beta] = kaiserparams(dw, 0.01);
kais_lp = fir1(N-1, wc/pi, kaiser(N, beta));
kais_hp = -kais_lp;
kais_hp(M+1) = kais_hp(M+1) + 1;

hold on
figure;
magdb(kais_lp);
title('Kaiser low pass filter');
figure;
magdb(kais_hp);
title('Kaiser high pass filter');
hold off

%% Spline filter

dw = 0.77 * (wtones(5) - wtones(4));
s_low = (wc/pi * sinc(wc/pi.*(-M:M)) .* sinc(dw/2/pi .* (-M:M)));
s_high = -s_low;
s_high(M+1) = s_high(M+1) + 1;

hold on
figure;
magdb(s_low);
title('Spline low pass filter');
figure;
magdb(s_high);
title('Spline high pass filter');
hold off


%% Frequency-sampled filter

freq_low = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)]; 
freq_high = -freq_low;
freq_high(M+1) = freq_high(M+1) +1;

figure;
magdb(freq_low);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('Uniform Frequency-sampled low pass filter');
figure;
magdb(freq_high);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('Uniform Frequency-sampled high pass filter');

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
title('Non-uniform Frequency-sampled low pass filter');
figure;
magdb(freq_high);
plot(w/pi, 10*ones(1, length(w)), 'bv')
title('Non-uniform Frequency-sampled high pass filter');

%% Optimum filter

opt_lp = firpm(N-1, [0 wtones([4 5])/pi 1], [1 1 0 0]);
opt_hp = -opt_lp;
opt_hp(M+1) = opt_hp(M+1) + 1;

figure;
hold on
magdb(opt_lp);
title('Optimum low pass filter');
figure;
magdb(opt_hp);
title('Optimum high pass filter');
hold off
