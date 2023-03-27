function [localMaxPeakValue, localMaxPeakIndex] = findLocalMaxPeak(acf)
    % Khởi tạo mảng localPeak để lưu giá trị của các biên độ cực đại cục bộ
    localPeak = zeros(1, length(acf) - 2);  
    
    % Khởi tạo mảng t để lưu giá trị miền thời gian
    % Duyệt acf bắt đầu sau vị trí biên đại cực bộ toàn cục (lag = 0) đến
    % (cuối - 1) => tìm ra các biên độ cực đại cục bộ
    for i = 2 : length(acf) - 1 
        if(acf(i) > acf(i - 1) && acf(i) > acf(i + 1))
            localPeak(i - 1) = acf(i);
        end
    end
    % Trả về giá trị biên độ cực đại cục bộ và index tại đó
    [localMaxPeakValue, localMaxPeakIndex] = max(localPeak);
end