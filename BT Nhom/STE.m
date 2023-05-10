function ste = STE(frames)
    % hàm tính STE của mỗi khung
    % size(matrix): matrix có n hàng, m cột 
    % => Trả về hai giá trị n và m
    totalFrames = size(frames, 1);

    % Khởi tạo mảng zcr để lưu các giá trị zcr của mỗi frame
    ste = zeros(totalFrames, 1);

    for i = 1 : totalFrames
        ste(i)= sum(frames(i,:).^2);
    end

    % normalize data
    ste = ste / max(ste);
end