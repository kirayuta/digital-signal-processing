function test_resamp(x, r, first, last)
% TEST_RESAMP test_resamp(x, r, [first], [last])
%             Test resample of sequence x at resample rate r
%             Optional parameters first and last determine where in
%             input sequence to start amd stop the display
%
%     (c) 2000 T. Holton
%     All rights reserved.

ss = get(0, 'ScreenSize');
set(clf, 'Position', [200 100 0.5 * ss(3:4)], ...
   'Name', 'test_resamp', ...
   'Color', 'w', ...
   'NumberTitle', 'off');

if (nargin < 4)
   last = length(x);
end
if (nargin < 3)
   first = 1;
end
   
n = last - first + 1; % don't take too many

subplot(2, 1, 1);
h = stem(first:last, x(first:last),'filled', ...
    'MarkerSize', 8, ...
    'LineWidth', 2);
hold on;
plot([first last], [0 0], 'k');
axis tight;
set(gca, 'Box', 'on');
title('Original sequence');

subplot(2, 1, 2);
set(gca, 'Box', 'on');
hold on;

rf = fix(1 + (first - 1) * r);
rl = fix(1 + (last - 1) * r);

if (exist('resamp'))
   y = resamp(x, r);
   h = stem(rf:rl, y(rf:rl), 'filled', ...
       'MarkerSize', 8, ...
       'LineWidth', 2);
   plot([rf rl], [0 0], 'k');
   axis tight
   xl = xlim;
   yl = ylim;
   yt = yl(2) - 0.05 * diff(yl);
   xt = xl(2) - 0.15 * diff(xl);
   dx = 0.02 * diff(xlim);
   title(['Interpolated sequence with r = ' num2str(r)])
   h = plot(xt, yt, 'bo');
   set(h, 'MarkerFaceColor', 'b');
   text(xt+dx, yt, 'Resamp');
else
   error('Can''t find RESAMP function');
end
yt = yt - .15;
if (exist('resample'))
   [U, D] = rat(r);
   y = resample(x, U, D);
   stem(rf:rl, y(rf:rl), 'xr');
   plot([rf rl], [0 0], 'k');
   plot(xt, yt, 'rx');
   text(xt+dx, yt, 'Resample');
else
   error('Can''t find Matlab''s RESAMPLE function');
end
return