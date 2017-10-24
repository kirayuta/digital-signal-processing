function y = resamp(x, r)
% RESAMP Resample an input sequence x by a factor of r

% ratio of upsample to downsample
[up down] = rat(r);
 
 lx=length(x); 
 xe=zeros(1, up*lx);
 
% Up-sample and Det. Wc
 xe(1:up:end) = x; 
% Up-sampling 
if up>down
     wc= pi/up;
 else
     wc= pi/down;
 end
 
 fn = wc/pi; 
 n = round(1+20/fn); 
 h = fir1(n-1, fn, kaiser(n, 5));
 
% Take the up-sample signal and filter it
 yup=conv(xe,h);
 
% Down sample sequ.
 ydown = yup(1:down:end);
 
% Pull the correct length of the sequence
 seqlength=up/down*lx 
 
 f=round((length(ydown) - seqlength)/2)
 
 y=ydown(f+1:end -f )*up;

end