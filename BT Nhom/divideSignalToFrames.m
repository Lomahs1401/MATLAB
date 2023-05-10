function [frames, totalFrames] = divideSignalToFrames(speechSignal, Fs, frameDuration, overlapingDuration)
    % Số mẫu của 1 frame (làm tròn gần nhất)
    frameSize = round(frameDuration * Fs); 
    overlapSize = round(overlapingDuration * Fs);
    speechSignalLength = length(speechSignal);
    totalFrames = floor((speechSignalLength - overlapSize) / (frameSize - overlapSize));
    frames = zeros(totalFrames, frameSize);

    for i = 1:totalFrames
        startIdx = (i - 1) * (frameSize - overlapSize) + 1;
        endIdx = startIdx + frameSize - 1;
        frames(i,:) = speechSignal(startIdx:endIdx);
    end
end