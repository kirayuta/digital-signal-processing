%% Lab 7 - Resampling
% Farnam Adelkhani -- Ernesto Casillas 
% April 7, 2017

%% Testing resampling of a sin at (5/2)fs
x = sin(2 * pi * (0:32) / 8);
test_resamp(x, 2.5);

%% Testing resampling of a sin  at 2fs
test_resamp(x, 2);

%% Testing resampling of a sin  at (2/3)fs
test_resamp(x, 0.666667);

%% Testing resampling of a sin  at (1/2)fs
test_resamp(x, 0.5);

% Make sure that you have the file 'seashell.wav' in your directory
[x, fs] = audioread('seashell.wav');

%% Testing resampling of 'seashell' at (3/2)fs
test_resamp(x, 1.5, 5000, 5050);

%% Testing resampling of 'seashell' at (3/4s)fs
test_resamp(x, 0.75, 5000, 5050);

%% Print program
disp(' ')
disp('--- resamp.m --------------------------------')
type('resamp')