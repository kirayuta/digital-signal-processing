unction y = sevendots(p)
        % SEVENDOTS plots the seven dots corresponding to the row
        % and column frequency of phone tones for lab6, on the
        % frequency response dB scale plotting of the filters.
        % by Steven Bao & Zizhe Ren (Mar 2016)
        x = get(p, 'xdata');
        y = get(p, 'ydata');
        wtones = 2 *[697 770 852 941 1209 1339 1447] / 8000;
        index = zeros(1, 7);
        xdots = zeros(1, 7);
        ydots = zeros(1, 7);
        for i=1:7
            [~, index(i)] = min(abs(wtones(i) - x));
            xdots(i) = x(index(i));
            ydots(i) = y(index(i));
            if ydots(i) < -60
                ydots(i) = -60;
            end
end

dot1 = plot(xdots(1),ydots(1), 'ro', 'MarkerFaceColor',
'r','MarkerEdgeColor','k');
plot(xdots(2),ydots(2), 'ro', 'MarkerFaceColor',
'r','MarkerEdgeColor','k');
plot(xdots(3),ydots(3), 'ro', 'MarkerFaceColor',
 'r','MarkerEdgeColor','k');
plot(xdots(4),ydots(4), 'ro', 'MarkerFaceColor',
 'r','MarkerEdgeColor','k');
plot(xdots(5),ydots(5), 'ro', 'MarkerFaceColor',
 'b','MarkerEdgeColor','k');
plot(xdots(6),ydots(6), 'ro', 'MarkerFaceColor',
 'b','MarkerEdgeColor','k');
dot7 = plot(xdots(7),ydots(7), 'ro', 'MarkerFaceColor',
 'b','MarkerEdgeColor','k');
rlines = [1;1] * xdots(1:4);
plot(rlines, ylim, 'r', 'LineWidth',0.2);
blines = [1;1] * xdots(5:7);
plot(blines, ylim, 'b', 'LineWidth',0.2);
y = [dot1,dot7];
end