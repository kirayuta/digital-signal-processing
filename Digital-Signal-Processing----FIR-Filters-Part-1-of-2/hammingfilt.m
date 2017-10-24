function h = hammingfilt(N,w)

N = ceil(N) + 1 - rem(ceil(N),2);
% Ceil--> round to positive infinity
% r = rem(a,b) returns the remainder after division of a by b
n = -((N-1)*(.5)) : ((N-1)*(.5));

W=0.54+0.46*cos((2*pi*n)/(N-1));
 % Equation for Hamming Window
h=(w/pi)*sinc(w*n).*W;
h=h/sum(h);

end