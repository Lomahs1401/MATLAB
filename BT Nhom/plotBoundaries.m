function plotBoundaries(x, fs, boundaries, overlappingDuration)
    % Tạo biên trên tín hiệu âm thanh
    t = (0:length(x)-1)/fs;
    subplot(2, 1, 2);
    plot(t, x);
    hold on;
    frame_shift_sample = round(fs * overlappingDuration);
    plot((boundaries*frame_shift_sample)/fs, zeros(length(boundaries),1), 'ro');

    % Vẽ đường dọc vuông góc với trục hoành tại các giá trị trong boundaries
    for i = 1:length(boundaries)
        line([boundaries(i)*frame_shift_sample/fs, boundaries(i)*frame_shift_sample/fs], ylim, 'Color', 'r');
    end
end

