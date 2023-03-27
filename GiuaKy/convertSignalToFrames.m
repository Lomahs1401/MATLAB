function [frames, totalFrames] = convertSignalToFrames(speechSignal, Fs, frameDuration)
    % Số mẫu của 1 frame (làm tròn gần nhất)
    frameSize = round(frameDuration * Fs); 
    % Tổng số frame có thể split được từ tín hiệu (làm tròn dưới)
    totalFrames = floor(length(speechSignal) / frameSize); 
    
    %% Duyệt vòng lặp để bắt đầu chia khung tín hiệu
    temp = 1;
    frames = [];
    for i = 1 : totalFrames
        % Vòng lặp 1: duyệt khung 1: 1->400 samples
        % Vòng lặp 2: duyệt khung 2: 401->800 samples
        % ...
        % Vòng lặp thứ totalFrames: duyệt khung cuối cùng
        frames(i, :) = speechSignal(temp : temp + frameSize - 1);
        % Tính vị trí bắt đầu khung tiếp theo
        temp = temp + frameSize;
    end
end