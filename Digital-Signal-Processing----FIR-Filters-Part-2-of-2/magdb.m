  function ph = magdb_lab6(h)
        H = fft(h,1024);
        w = linspace(0, 2*pi, 1024);
        dB = mag2db(abs(H));
        ph = plot(w/pi, dB);
        set(ph,'LineWidth', 1.5, 'color', 'b');
        ax = gca;
        ax.XTick=[0 0.125 0.25 0.375 0.5];
        ax.XTickLabel={'0','','\pi/4','','\pi/2'};
        ax.GridLineStyle = '--';
        xlim([0 0.5]);
        ylim([-60 10]);
        % xlabel('\omega(rad/\pi)');
        ylabel('|\itH(\omega)|_d_B');
        grid on;
        return