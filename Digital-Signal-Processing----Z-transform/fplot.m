function fplot(b, a)

% W = top two quadrants
   w = linspace(0,1,256);
% Discrete-Time Fourier Transform of the denominator/numerator
   bfft = fft(b,512);
   afft = fft(a,512);

% Divides b/a to get H and generate its magnitude + phase angle
   magH = abs(bfft./afft);
   phaseH = angle(bfft./afft);

% Plt Mag.
subplot(2,1,1);
plot(w,magH(1:256));
  ylim([0 1.1*max([magH])]);
  ylabel('|H(\omega)|');
  xlim([0 1]);

% the freq plot
subplot(2,1,2);
plot(w,phaseH(1:256)./pi,w,0,'k'); 
  xlim([ 0 1]);
  ylim([-1 1]);
  ylabel('\angleH (\omega) -- (Fraction of \pi)');
  xlabel('w (Fraction of \pi)');



