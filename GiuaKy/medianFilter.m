 function filtered = medianFilter(filterSize, F0)
    % Tạo vector bộ lọc
    filterVector = ones(1, filterSize) / filterSize;

    % Áp dụng bộ lọc trung vị
    filtered = filter(filterVector, 1, F0);

    % Tính giá trị trung vị cho từng cửa sổ 7 phần tử
    for i = 1:length(F0)
        % Tính chỉ số đầu và cuối của cửa sổ
        start_idx = max(1, i - floor(filterSize/2));
        end_idx = min(length(F0), i + floor(filterSize/2));

        % Tính giá trị trung vị của cửa sổ
        filtered(i) = median(F0(start_idx:end_idx));
    end
end
