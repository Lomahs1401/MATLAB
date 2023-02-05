clear
close all
clc

promptLengthSignal = 'Nhap so luong tin hieu mau L (mac dinh L = 100000) : ';
promptMean = 'Nhap GTTB (Mean): ';
promptStd = 'Nhap do lech chuan (Standard Deviation): ';
L = input(promptLengthSignal);
if isempty(L)
    L = 100000;
end

mean = input(promptMean);
if isempty(mean)
    mean = 5;
end

std = input(promptStd);
if isempty(std)
    std = 0.25;
end

plotRandomSignal(mean, std, L);




        