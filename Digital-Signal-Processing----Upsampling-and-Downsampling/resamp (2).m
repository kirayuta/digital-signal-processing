function y = resamp(x, r)
% RESAMP Resample an input sequence x by a factor of r
%          to produce an output sequence y by a combination
%          of upsampling and downsampling.
%          For example,
%             y=resamp(x,1.5);
%          will upsample x by 3 and downsample by 2.

[up down] = rat(r); %  upsample and downsample ratio
 
 lx=length(x); 
 xe=zeros(1, up*lx);
 
 xe(1:up:end) = x; %upsample 
 % determine wc
 if up>down %be upsampling
     wc= pi/up;
 else
     wc= pi/down;
 end
 
 fn = wc/pi; 
 n = round(1+20/fn); 
 h = fir1(n-1, fn, kaiser(n, 5));
 
 yup=conv(xe,h); %filter the upsampled signal
 
 %downsample
 
 ydown = yup(1:down:end);
 
 seqlength=up/down*lx % get the seq the correct length
 
 f=round((length(ydown) - seqlength)/2)
 
 y=ydown(f+1:end -f )*up;

end