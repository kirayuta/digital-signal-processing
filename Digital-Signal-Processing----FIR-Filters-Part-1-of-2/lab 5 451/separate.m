function [sr, sc] =separate(s, fs)
% Separate row and column tone for a DTMF tone

 [N , beta] = kaiserparams(0.05, 0.005);
 N = N + 1 - mod(N,2);
 Hlp = kaiserfilt(N, 2 * 1050/fs, beta);
 hhp = -Hlp; % flip the low-pass filter
 
 hhp(ceil(end/2)+1) = 1 + hhp(ceil(end/2)+1); 
 
 sr = conv(s,Hlp);
 sc = conv(s,hhp);
end




