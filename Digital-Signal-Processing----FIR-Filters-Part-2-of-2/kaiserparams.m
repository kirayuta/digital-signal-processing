function [N, beta] = kaiserparams(deltaOmega, delta)  
    % KAISERPARAMS      Returns Kaiser design parameters N and beta. 
    %                   [N, beta] = kaiserparams(deltaOmega, delta) 
    %                   returns Kaiser design parameters N and beta, 
    %                   given width of transition band, deltaOmega, and 
    %                   amplitude of the stop/passband, delta.
    % 
    %                   Note: dOmega is given as a fraction of pi. 
    %                   Test: [37, 5.6533] = kaiserparams(0.2, 0.001) 
    A = -20 * log10(delta);
    if (A > 50)
        beta = 0.1102 * (A - 8.7);
    elseif (A >= 21)
        beta = 0.5842 * (A-21)^0.4 + 0.07886 * (A-21);
    else
        beta = 0;
    end
    
    N = ceil((A-8) / (2.285*deltaOmega*pi));
    if (mod(N,2) == 0)
        N = N+1;
    end
end