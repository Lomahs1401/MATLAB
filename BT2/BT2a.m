clear
close all
clc

% ------------------------------------------------------------
% a. Load the sound waveform "handel" in an array x and listen to it
% using the sound function at the full sampling rate

load handel x;
Fs = 8192;

plot(x);
xlabel('n');
ylabel('x[n]');
title('Signal with sampling rate Fs');
grid on;
length(x)

sound(x, Fs)




