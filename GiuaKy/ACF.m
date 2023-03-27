function acf = ACF(frame)
    % Kích thước của frame
    N = length(frame);
    
    % Khởi tạo mảng acf để lưu các giá trị tự tương quan
    acf = zeros(1, N);

    % i = n, j = m
    for i = 0 : N - 1
        sum = 0;
        % m=0 -> N-1-n
        % Chọn m = 1 vì cần access vào frame tại index bắt đầu từ 1
        % => m=1->N-n hay N-i
        for j = 1:N-i 
            s = frame(j) * frame(j+i); % s = frame(3) * frame(3 + 0)
            sum = sum + s;
        end
        acf(i+1) = sum;
    end
end