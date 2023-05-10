clear all; close all;

%% Danh sach cac file audio kiem duyet can duyet
listTestingAudio = [
    "01MDA.wav";
    "02FVA.wav";
    "03MAB.wav";
    "06FTB.wav";
];

%% Thiet lap cac thong so
FMin = 70; FMax = 400;
frameDuration = 0.01;
overlappingDuration = 0.005;

% --- Thu nghiem voi file kiem thu
for z = 1 : length(listTestingAudio)
    if z == 1    
        point= [0.00 0.45 0.81 1.53 1.85 2.69 2.86 3.78 4.15 4.84 5.14];
        F0mean = 135.5;
        F0std = 5.4;
    end
    if z == 2
        point= [0.00 0.83 1.37 2.09 2.60 3.57 4.00 4.76 5.33 6.18 6.68];
        F0mean = 239.7;
        F0std = 5.6;
    end
    if z == 3
        point= [0.00 1.03 1.42 2.46 2.80 4.21 4.52 6.81 7.14 8.22 8.50];
        F0mean = 115.0;
        F0std = 4.5;
    end
    if z == 4
        point= [0.00 1.52 1.92 3.91 4.35 6.18 6.60 8.67 9.14 10.94 11.33];
        F0mean = 202.9;
        F0std = 15.5;
    end

    %% Chia khung tin hieu    
    % Load audio file
    [y, Fs] = audioread("TinHieuKiemThu/" + listTestingAudio(z));

    % Set frame size and overlap (in seconds)
    fd = 0.01;
    overlap = 0.005;

    t = (1:length(y))/Fs;

    % Calculate frame size and hop size (in samples)
    frame_size_samples = fd * Fs;
    hop_size_samples = floor(frame_size_samples * (1 - overlap));

    % Calculate number of frames
    num_frames = floor((length(y) - frame_size_samples) / hop_size_samples) + 1;

    % Chia mien thoi gian cua tin hieu
    %     [frames, totalFrames] = divideSignalToFrames(y, Fs, frameDuration, overlappingDuration);

    %% Xuat do thi
    nameFigure = listTestingAudio(z);
    figure('Name', nameFigure);

    % ------------------- Ket qua kiem thu chuan ------------------
    subplot(5, 1, 1); 
    plot(t, y); 
    title('KET QUA KIEM THU CHUAN');
    xlabel('Time(s)'); 
    ylabel('Amplitude');

    for i = 1:length(point)
        x1 = [point(i) point(i)];
        y1 = [-1 1];
        if (i ~= 1)
            line(x1, y1, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
        end
    end

    for i = 1 : 2 : length(point)
        text(point(i) + 0.8, 0.8,'sil','Color','b','FontSize', 12);
        if i == 1
            text((point(i+1) + 0.1), 0.8, 'a', 'Color', 'r', 'FontSize', 12);
        end
        if i == 3
            text((point(i+1) + 0.1), 0.8, 'e', 'Color', 'r', 'FontSize', 12);
        end
        if i == 5
            text((point(i+1) + 0.1), 0.8, 'i', 'Color', 'r', 'FontSize', 12);
        end
        if i == 7
            text((point(i+1) + 0.1), 0.8, 'u', 'Color', 'r', 'FontSize', 12);
        end
        if i == 9
            text((point(i+1) + 0.1), 0.8, 'o', 'Color', 'r', 'FontSize', 12);
        end
    end

    legend('Tin hieu, bien thoi gian chuan')


    %% Xu ly
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
    threshold_ste = 0.003;
    threshold_zcr = 0.7;
    vowel_frames = find(ste_norm > threshold_ste & zcr_norm < threshold_zcr);

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
    n = [];
    f0s = [];
    f0_peak_searching = [];

    for i = 1:length(vowel_frames)
        frame = y((vowel_frames(i)-1)*0.01*Fs:vowel_frames(i)*0.01*Fs);
        [f0,num] = calculate_F0_HPS_new(frame,Fs);
        f0s = vertcat(f0s,f0);
        n = cat(1,n,num);
    end

    for i = 1:length(vowel_frames)
        frame = y((vowel_frames(i)-1)*0.01*Fs:vowel_frames(i)*0.01*Fs);

        N = 2.^nextpow2(length(frame));
        %     N = length(frame);
        X = abs(fft(frame, N)); 
        X = X(1:N/2+1); 
    
        [localMaxPeakValue, localMaxPeakIndex] = findLocalMaxPeak(X);
        
        if z == 1 | z == 3 
            f0 = (localMaxPeakIndex) * Fs / 2048;
            if (f0 < FMin | f0 > FMax)
                f0 = 0; % không tìm th?y t?n s? h?p l?
            end
        else 
            f0 = (localMaxPeakIndex) * Fs / 4096;
            if (f0 < FMin | f0 > FMax)
                f0 = 0; % không tìm th?y t?n s? h?p l?
            end
        end
        
        f0_peak_searching = vertcat(f0_peak_searching,f0);
    end
    
    f0_time =  zeros(1, length(f0s));
    for i = 1:length(f0s) 
        f0_time(i) = vowel_frames(i)*0.01;
    end
    %Plot the signal, time boundaries, and F0 line
    t = (0:length(y)-1) / Fs;
    
    subplot(5, 1, 2); 
    plot(t, y);
    hold on;
    if ~isempty(boundary_times)
        plot(boundary_times, zeros(size(boundary_times)), 'ro', 'MarkerSize', 5, 'LineWidth', 2);
    end
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Audio signal with vowel/silence boundaries');

    subplot(5, 1, 3);
    plot(f0_time, f0s, ".");
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title("Pitch Contour, " + "Delta Mean = " + abs(F0mean - mean(nonzeros(f0s))) + ", Delta Std = " + abs(F0std - std(nonzeros(f0s))));

    subplot(5, 1, 4); 
    plot(f0_peak_searching, ".");
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title("Pitch Contour, " + "Delta Mean = " + abs(F0mean - mean(nonzeros(f0s))) + ", Delta Std = " + abs(F0std - std(nonzeros(f0s))));

    subplot(5, 1, 5); 
    plot(X);
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title("FFT cua frame cuoi");
end



 
 