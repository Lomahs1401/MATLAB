clear
close all
clc

% ------------------------------------------------------------
% b. Select every other sample in x which reduces the sampling rate
% by a factor of two. Now listen to the new sound array using the sound
% function at half the sampling rate

load handel;
x = y;
Fs = 8192;

%n = 1:length(x);
%x_ds2_ind = mod(n,2)==1;
%sound(x(x_ds2_ind), Fs/2); 
%pause(1)

for i=1:length(x)/2
    w(i)=x((2*i)-1);
end

plot(w);
xlabel('n');
ylabel('x[n]');
title('Signal with sampling rate Fs/2');
grid on;
length(w)

sound(w, Fs/2);