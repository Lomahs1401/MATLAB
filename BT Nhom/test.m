clear all; close all;

% Load audio file
[y, Fs] = audioread("TinHieuKiemThu/01MDA.wav");

% Set frame size and overlap (in seconds)
fd = 0.02; % 20ms
overlap = 0.01; % 10ms

% Calculate frame size and hop size (in samples)
frame_size_samples = fd * Fs;
hop_size_samples = floor(frame_size_samples * (1 - overlap));

% Calculate number of frames
num_frames = floor((length(y) - frame_size_samples) / hop_size_samples) + 1;

% Calculate STE and ZCR for each frame
for i = 1:num_frames
    % Get current frame
    frame_start = (i-1)*hop_size_samples + 1;
    frame_end = min(frame_start + frame_size_samples - 1, length(y));
    frame = y(frame_start:frame_end);

    % Calculate STE and ZCR for current frame
    ste(i) = sum(frame.^2);
    zcr(i) = sum(abs(diff(frame > 0))) / length(frame);
end

% Normalize STE and ZCR
ste_norm = (ste - min(ste)) / (max(ste) - min(ste));
zcr_norm = (zcr - min(zcr)) / (max(zcr) - min(zcr));

% Find time boundaries between vowels and silences
threshold_ste = 0.001;
threshold_zcr = 0.7;
vowel_frames = find(ste_norm > threshold_ste & zcr_norm < threshold_zcr);

plot(vowel_frames);

% Find vowel/silence boundaries
vowel_boundaries = [];
if ~isempty(vowel_frames)
    prev_frame = vowel_frames(1);
    for i = 2:length(vowel_frames)
        if vowel_frames(i) - prev_frame > 1
            vowel_boundaries = [vowel_boundaries; prev_frame, vowel_frames(i-1)];
            prev_frame = vowel_frames(i);
        end
    end
    vowel_boundaries = [vowel_boundaries; prev_frame, vowel_frames(end)];
end

% Find the corresponding time values for the boundaries
boundary_times = vowel_boundaries * hop_size_samples / Fs;

 f0s = [];
 for i = 1:length(boundary_times)
     frame = y(boundary_times(i,1)*Fs:boundary_times(i,2)*Fs);
     f0 = calculate_F0_HPS(frame, Fs);
     f0s = vertcat(f0s,f0);
 end

 f0_peak_searching = [];
 for i=1:length(boundary_times)
    frame = y(boundary_times(i,1)*Fs:boundary_times(i,2)*Fs);
    [localMaxPeakValue, localMaxPeakIndex] = findLocalMaxPeak(frame);
    
    F0 = (localMaxPeakIndex + 1) * Fs / (N*2);
%     
%     if (F0 < 70 || F0 > 400)
%         F0 = NaN; % không tìm th?y t?n s? h?p l?
%     end
%     f0 = Fs / (localMaxPeakIndex);
%     [pks, locs] = findpeaks(X);
%     [pks, locs] = findpeaks(X, 'MinPeakDistance', 50);
%     f0 = calculate_F0_PeakSearching(frame, Fs);
    f0_peak_searching = vertcat(f0_peak_searching, F0);
 end

 plot(X);

 f0_time =  zeros(1, length(f0s));
 for i = 1:length(f0s) 
    f0_time(i) = boundary_times(i,1);
 end
 
 %% Xuat do thi
 %Plot the signal, time boundaries, and F0 line
 t = (0:length(y)-1) / Fs;

 figure('Name', path);
 subplot(3, 1, 1); 
 plot(t, y);
 hold on;
 if ~isempty(boundary_times)
    plot(boundary_times, zeros(size(boundary_times)), 'ro', 'MarkerSize', 5, 'LineWidth', 2);
 end
 hold off;
 xlabel('Time (s)');
 ylabel('Amplitude');
 title('Audio signal with vowel/silence boundaries');
 legend('Signal', 'Vowel Frames');

%  subplot(3, 1, 2); 
%  plot(f0_time, f0s, ".");
%  hold off;
%  xlabel('Time (s)');
%  ylabel('Amplitude');
%  title('Fundamental frequency (F0) detection');
%  legend('Signal', 'Boundaries', 'F0');

 subplot(3, 1, 2);
 plot(f0_time, f0_peak_searching, ".");
 hold off;
 xlabel('Time (s)');
 ylabel('Amplitude');
 title('Fundamental frequency (F0) detection');
 legend('Signal', 'Boundaries', 'F0');

 