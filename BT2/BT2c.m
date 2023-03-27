clear
close all
clc

% ------------------------------------------------------------
% c. Select every fourth sample in x which reduces the sampling rate
% by a factor of four. Listen to the resulting sound array using the sound
% function at quarter the sampling rate

load handel;
x = y;
Fs = 8192;

for i=1:length(x)/4
    w(i)=x((4*i)-3);
end

plot(w);
xlabel('n');
ylabel('x[n]');
title('Signal with sampling rate Fs/4');
grid on;
length(w)

sound(w, Fs/4);
