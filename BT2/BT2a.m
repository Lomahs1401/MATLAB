clear
close all
clc

% ------------------------------------------------------------
% a. Load the sound waveform "handel" in an array x and listen to it
% using the sound function at the full sampling rate

load handel;
x = y;
Fs = 8192;

sound(x, Fs)


