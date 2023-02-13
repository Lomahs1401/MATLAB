clear
close
clc

%set the frequency
f=500;

%create the waveform
fs=32000; %sampling rate
d=4; %duration of sound
n=fs*d; %number of samples
t=(1:n)/fs; %total number of data points
y=sin(2*pi*f*t);

%generate sound
sound(y);
filename='sound.wav';
audiowrite(filename, y, fs)