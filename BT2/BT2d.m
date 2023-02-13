clear
close all
clc

% ------------------------------------------------------------
% d. Save the generated sound in part(c) using the wavwrite function

load handel;
x=y;
Fs = 8192;

for i=1:(length(x))/4
    w(i)=x((4*i)-3);
end

audiowrite('BT2c.wav', y, Fs/4);
