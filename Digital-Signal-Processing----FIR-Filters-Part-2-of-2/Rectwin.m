[s,fs]=audioread('phonetones.wav'); 
% read the wave from file
N = 73; % set the length of filter
M = (N-1)/2;
        wc = 2 * (1075 / fs); % set the cut off frequency
        wtones = 2 *[697 770 852 941 1209 1339 1447] / 8000;
        hlp = fir1(N-1, wc, rectwin(N));
        figure;
        p = magdb_lab6(hlp);
        title('Rectangular-window lowpass filter');
        hold on; dots = sevendots(p);
        legend([dots(1) dots(2)], 'Row tones', 'Column tones');
        plot([0 wc], [0 0], [wc wc], [0 -60], 'color', [0,0.5,0]);
        hhp = - hlp;
        hhp(M+1) = hhp(M+1) + 1;
        figure;
        p = magdb_lab6(hhp);
        title('Rectangular-window highpass filter');
        hold on; sevendots(p);
        plot([wc 0.5], [0 0], [wc wc], [0 -60], 'color', [0,0.5,0]);