function zplot(b,a)

% Generate the linearly spaced values
w = linspace(0, 2*pi, 64);
   plot(exp(j*w),'color','k');

hold all;
   line([-2; 2], [0;0],'color', 'K'); % K is color @ axis
   line([0;0], [-2;2], 'color', 'k');
% Set poles and zeros
Poles = roots(a);
zeros  = roots(b);

% Prepare to plot imaginary and real on coordinate axis
a_r= real(Poles);
b_r= real(zeros);
b_i= imag(zeros);
a_i= imag(Poles);

plot(a_r,a_i, 'rx');
plot(b_r,b_i, 'bo');
if (sum(Poles)==0)
	plot(0,0,'rx');
end
return