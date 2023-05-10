clear; 
close all;

%%     ---------------     ĐỀ TÀI BÁO CÁO     ---------------   
% 2a. Tim tan so co ban F0 cua tin hieu tieng noi
% su dung ham tu tuong quan (autocorrelation function)

%% Danh sách các file audio cần duyệt
% listAudio = [
%     "studio_M1.wav"; 
%     "studio_F1.wav"; 
%     "phone_M1.wav"; 
%     "phone_F1.wav"
% ];

listAudio = [
    "studio_M1.wav";
    "studio_F1.wav";
    "phone_M1.wav";
    "phone_F1.wav";
];

%% Thiết lập các thông số
% Theo luận văn, tác giả đã thực nghiệm khảo sát ngưỡng (threshold) 
% với các mốc 30%, 50%, 70% so với biên độ cực đại toàn cục (tại lag = 0)
% ==> Nhận thấy 30% là ngưỡng dự đoán U/V tốt nhất
% cho cả 3 giọng nam và 3 giọng nữ
threshold = 0.3;

% Giọng nam có F0 từ 70Hz->250Hz
% Giọng nữ có F0 từ 150Hz->400Hz
FMin = 70; FMax = 400;

% Tác giả đã thực nghiệm khảo sát kích thước bộ lọc 3, 5, 7
% và nhận thấy kích thước bộ lọc 7 là tốt nhất
filterSize = 7;

for i = 1 : length(listAudio)
    %% Chia khung tín hiệu
    [speechSignal, Fs] = audioread('TinHieuKiemThu/' + listAudio(i));
    % quy ước khoảng thời gian lý tưởng của frame là 25ms
    frameDuration = 0.025;
    % miền thời gian của tín hiệu tiếng nói
    t = (1:length(speechSignal))/Fs;
    [frames, totalFrames] = convertSignalToFrames(speechSignal, Fs, frameDuration);

    %% Khởi tạo mảng F để lưu giá trị F0 của mỗi frame
    F = zeros(1, totalFrames); 
    
    %% Khởi tạo mảng F_time để lưu các mốc tgian pitch contour của mỗi frame
    F_time = zeros(1, length(F));
    
    for ftime = 1:length(F_time)
        F_time(ftime) = (ftime)* frameDuration;
    end

    %% Khởi tạo mảng voiced và unvoiced để lưu các frame và các acf thuộc voiced hoặc unvoiced
    voiced = []; 
    voiced_time = [];
    acf_of_voiced = [];
    voiced_count = 1;
    
    unvoiced = []; 
    unvoiced_time = [];
    acf_of_unvoiced = [];
    unvoiced_count = 1;

    %% Xử lý các khung
    for x = 1 : totalFrames
        N = length(frames(x, :));
        % Khởi tạo mảng t_frame để lưu các mốc thời gian 
        % của từng mẫu theo miền thời gian trong 1 frame
        t_frame = linspace(frameDuration * x, frameDuration * (x + 1), N);

        % Lấy các khung làm đối số truyền vào hàm tính tự tương quan ACF
        acf = ACF(frames(x, :));

        % chuẩn hóa (normalized) để biên độ cực đại toàn cục luôn bằng 1
        % -> Thuận tiện cho việc so sánh ngưỡng
        acf = acf / max(acf);
        
        % Lấy acf của khung vừa tính được truyền vào hàm để tìm biên độ cực
        % đại cục bộ
        [localMaxPeakValue, localMaxPeakIndex] = findLocalMaxPeak(acf);
        
        % Giá trị độ trễ (lag) tại điểm cực đại có biên độ lớn nhất của
        % hàm tự tương quan chính là chu kỳ cơ bản T0 của khung tín hiệu
        F0 = Fs / (localMaxPeakIndex + 1);

        if(localMaxPeakValue >= threshold && F0 > FMin && F0 < FMax) 
            F(x) = F0;
            voiced(voiced_count, :) = frames(x, :);
            acf_of_voiced(voiced_count, :) = acf;
            voiced_time(voiced_count, :) = t_frame;
            voiced_count = voiced_count + 1;
        else
            F(x) = 0;
            unvoiced(unvoiced_count, :) = frames(x, :);
            acf_of_unvoiced(unvoiced_count, :) = acf;
            unvoiced_time(unvoiced_count, :) = t_frame;
            unvoiced_count = unvoiced_count + 1;
        end    
    end

    %% Lọc trung vị (Median smoothing)
    filtered_F0 = medianFilter(filterSize, F);

    %% Xuất đồ thị
    nameFigure = listAudio(i);
    figure('Name', nameFigure);
    
    % ------------------- Kết quả theo miền thời gian ------------------
    subplot(5, 2, 1); 
    plot(voiced_time(31, :), voiced(31, :)); 
    
    xlabel('Time(s)'); 
    ylabel('Amplitude'); 
    title('Voiced');

    subplot(5, 2, 2); 
    plot(unvoiced_time(31, :), unvoiced(31, :)); 
    xlabel('Time(s)'); 
    ylabel('Amplitude'); 
    title('Unvoiced');

    subplot(5, 2, 3); 
    plot(voiced_time(31, :), acf_of_voiced(31, :)); 
    xlabel('Time(s)'); 
    ylabel('Amplitude');
    yline(threshold, 'r-', 'Threshold')
    title('ACF of voiced');

    subplot(5, 2, 4); 
    plot(unvoiced_time(31, :), acf_of_unvoiced(31, :)); 
    xlabel('Time(s)'); 
    ylabel('Amplitude');
    yline(threshold, 'r-', 'Threshold')
    title('ACF of unvoiced');

    subplot(5, 2, [5, 6]);
    yplot = F;
    yplot(yplot==0)=nan;
    plot(F_time, yplot,  '.');
    xlabel('Time(s)'); 
    ylabel('F0(Hz)');
    meanF0 = mean(nonzeros(F));
    stdF0 = std(nonzeros(F));
    yline(meanF0, 'r-', 'Mean F0');
    yline(meanF0 + stdF0, 'k-', 'stdF0');
    yline(meanF0 - stdF0, 'k-', 'stdF0');
    nameTitle = "Pitch Contour, " + "Mean = " + num2str(meanF0) + ", Std = " + num2str(stdF0);
    title(nameTitle);

    subplot(5, 2, [7, 8]);
    yplot = filtered_F0;
    yplot(yplot==0)=nan;
    plot(F_time, yplot,  '.');
    xlabel('Time(s)'); 
    ylabel('F0(Hz)');
    title('Pitch Contour after using median filter');

    subplot(5, 2, [9, 10]); 
    plot(t, speechSignal); 
    xlabel('Times(s)'); 
    ylabel('Amplitude'); 
    title('Speech signal');

    subplot(5, 2, [7, 8]);
    plot(t, fftV);
    subplot(5, 2, [9, 10]);
    plot(t, fftU);
end