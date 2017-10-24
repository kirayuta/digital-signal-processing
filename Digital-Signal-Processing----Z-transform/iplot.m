function iplot(b, a)

N = 0 ; % Length of impulse response @ each case
  PLS = roots(a);
  ZRS  = roots(b);
% Beggining of Response
 offset= find(b,1)-find(a,1);
% Use this to drop the leading 0s
  ai = a(find(a,1):length(a));
  bi = b(find(b,1):length(b));

% All poles are zero @ the origin -- Checking for impulse response
if (PLS(1:end) == 0)
	N = length(ZRS);
       % Length of the Response

elseif(length(a)<length(b))
	impulse = filter(bi,ai,[1 zeros(1,999)]);
% Calculate and normalize tot. Energy
    cs = cumsum(impulse); % Get the cum sum of impulse
	cs = cs/cs(length(cs)-1);
     N = length(find(cs < 0.999));
else
		N = 20;	
end
d = [1 zeros(1, N-1)];	% Gen. Ring
	sysr = filter(bi,ai,d);
stem(sysr,'filled'); % Plot the stem
   xlabel('n')