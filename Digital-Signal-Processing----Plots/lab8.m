function lab8
- Farnam Adelkhani - Ernie Casillas
    Lab 8 -- Engr 451 

% A (non-causal) bandstop filter
figure
fizplot([1 2 2], [0 1 .8]);
title('A (non-causal) bandstop filter');

% A rectangular window
figure
fizplot(ones(1, 10), 1);
title('A rectangular window');

% A notch filter
figure
fizplot([1 zeros(1, 8) -1], [1 zeros(1, 8), -.5]);
title('A notch filter');

% An unstable band-pass filter
figure
fizplot(1, [1 -2 2]);
title('An unstable band-pass filter');

% A non-causal oscillating response
figure
fizplot([0 1 1], [0 0 1 .5]);
title('A non-causal oscillating response');

% A delayed decaying response
figure
fizplot([0 0 1 1], [0 1 -.8]);
title('A delayed decaying response');

% Did you fix the phase? (It's O.K. if you didn't)
figure
fplot([1 1 1 1 1], [0 0 1]);
title('Did you fix the phase? (It''s O.K. if you didn''t)');