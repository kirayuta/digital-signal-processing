function h = kaiserfilt(N,w,beta)

n = -((N-1)*(.5)) : ((N-1)*(.5));

W = (besseli(0,(beta*(1-((2*n)/(N-1)).^(2)).^(1/2))))./(besseli(0,beta));
 % computes the modified Bessel function of the first kind for the above
h = (w/pi)*sinc(w*n).*W;
h = h / sum(h);

end