function zcr= ZCR(frames)
    % hàm tính ZCR của mỗi khung
    % size(matrix): matrix có n hàng, m cột 
    % => Trả về hai giá trị n và m
    [totalFrames, frameSize] = size(frames);

    % Khởi tạo mảng zcr để lưu các giá trị zcr của mỗi frame
    zcr = zeros(frameSize, 1);

    for i = 1 : totalFrames
        x = frames(i,:);
        zcr(i) = sum(x(1:end-1) .* x(2:end) < 0) / frameSize;
    end

    % normalize data
    zcr = zcr / max(zcr);
end