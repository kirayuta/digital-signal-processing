function y = plot_magph(x, w)

X = dtft2(x,w);
R = mag_phase(X); 

plot(w,R.mag);
plot(w,R.phase);
end