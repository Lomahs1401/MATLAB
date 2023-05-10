function [localMaxPeakValue, localMaxPeakIndex] = calculate_F0_PeakSearching(frame, fs)
    N = 2.^nextpow2(length(frame));
    X = abs(fft(frame, N)); 
    X = X(1:N/2+1); 
    
    [localMaxPeakValue, localMaxPeakIndex] = findLocalMaxPeak(X);
end
