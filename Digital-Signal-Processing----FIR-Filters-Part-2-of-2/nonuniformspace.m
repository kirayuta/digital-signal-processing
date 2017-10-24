k = 0:M;
w = 2 * k / N;
index = zeros(1, 7);
for i=1:7
    [~, index(i)] = min(abs(wtones(i) - w));
    w(index(i)) = wtones(i);
end
Ak = double(w < wc)';
C = cos((w * pi)'* k);
b = C \ Ak;
hlp = [0.5*b(end:-1:2); b(1); 0.5*b(2:end)];
figure;
p = magdb_lab6(hlp);
title('Non-uniform spacing Frequency-sampled lowpass filter');
hold on; dots = sevendots(p);
legend([dots(1) dots(2)], 'Row tones', 'Column tones');
x = get(p, 'xdata');
y = get(p, 'ydata');
index = zeros(1, 37);
xx = zeros(1, 37);
yx = zeros(1, 37);
for i=1:37
    [~, index(i)] = min(abs(w(i) - x));
    xx(i) = x(index(i));
    yx(i) = y(index(i));
    if yx(i) < -60
yx(i) = -60;
end end
plot(xx,yx, 'X','color', 'k', 'LineWidth', 1)
plot([0 wc], [0 0], [wc wc], [0 -60], 'color', [0,0.5,0]);
hhp = - hlp;
hhp(M+1) = hhp(M+1) + 1;
figure;
p = magdb_lab6(hhp);
title('Non-uniform spacing Frequency-sampled highpass filter');
hold on; sevendots(p);
x = get(p, 'xdata');
y = get(p, 'ydata');
index = zeros(1, 37);
xx = zeros(1, 37);
yx = zeros(1, 37);
for i=1:37
    [~, index(i)] = min(abs(w(i) - x));
    xx(i) = x(index(i));
    yx(i) = y(index(i));
    if yx(i) < -60
yx(i) = -60;
end end
plot(xx,yx, 'X','color', 'k', 'LineWidth', 1)
plot([wc 0.5], [0 0], [wc wc], [0 -60], 'color', [0,0.5,0]);
