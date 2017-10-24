function h = rectfilt(N,w)

n = -((N-1)*(.5)) : ((N-1)*(.5));
N = ceil(N)+1-rem(ceil(N),2);
        % Ceil--> round to positive infinity

% Impulse Response
h = (w/pi) * sinc(w*n);
h = h/sum(h);
  % Returns the sum of the elements of A along the first array dimension
end