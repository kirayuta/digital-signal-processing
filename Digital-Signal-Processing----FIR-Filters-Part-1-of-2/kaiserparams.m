function [N, B] = kaiserparams(deltaOmega, delta) 
% Kaiserparams   Returns Kaiser design parameters N and beta.
A = -mag2db(delta); % Convert magnitude to decibels
% procedure to compute Beta and N ...
if A>50
    B = 0.1102 * (A-8.7);
elseif 21 <= A <= 50
    B = 0.5842 * (A-21)^0.4 + 0.07886 * (A-21);
else
    B = 0;
end

N = ceil((A-8)/(2.285*deltaOmega*pi));
end