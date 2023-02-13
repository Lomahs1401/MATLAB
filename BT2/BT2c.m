clear
close all
clc

% ------------------------------------------------------------
% b. Select every other sample in x which reduces the sampling rate
% by a factor of two. Now listen to the new sound array using the sound
% function at half the sampling rate

load handel;
x=y;
Fs = 8192;

for i=1:(length(x))/4
    w(i)=x((4*i)-3);
end
sound(w, Fs/4);
