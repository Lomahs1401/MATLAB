clear; 
close all;

%%     ---------------     DE TAI BAO CAO     ---------------   
% Tim bien thoi gian giua nguyen am va khoang lang dung dac trung STE
% va tim F0 cua khung huu thanh dua tren pho bien do

%% Danh sach cai file audio huan luyen can duyet
listTrainingAudio = [
    "30FTN.wav";
    "42FQT.wav";
    "44MTT.wav";
    "45MDV.wav";
];

%% Danh sach cac file audio kiem duyet can duyet
listTestingAudio = [
    "01MDA.wav";
    "02FVA.wav";
    "03MAB.wav";
    "06FTB.wav";
];

%% Thiet lap cac thong so
threshold = 0.3;

FMin = 70; FMax = 400;
frameDuration = 0.025;
overlappingDuration = 0.01;

% --- Thu nghiem voi file kiem thu
for z = 1 : length(listTestingAudio)
    if z == 1    
        point= [0.00 0.45 0.81 1.53 1.85 2.69 2.86 3.78 4.15 4.84 5.14];
    end
    if z == 2
        point= [0.00 0.83 1.37 2.09 2.60 3.57 4.00 4.76 5.33 6.18 6.68];
    end
    if z == 3
        point= [0.00 1.03 1.42 2.46 2.80 4.21 4.52 6.81 7.14 8.22 8.50];
    end
    if z == 4
        point= [0.00 1.52 1.92 3.91 4.35 6.18 6.60 8.67 9.14 10.94 11.33];
    end

    %% Chia khung tin hieu
    [speechSignal, Fs] = audioread('TinHieuKiemThu/' + listTestingAudio(z));
    % Chia mien thoi gian cua tin hieu
    t = (1:length(speechSignal))/Fs;
    [frames, totalFrames] = divideSignalToFrames(speechSignal, Fs, frameDuration, overlappingDuration);

    %% Xuat do thi
    nameFigure = listTestingAudio(z);
    figure('Name', nameFigure);
    
    % ------------------- Ket qua kiem thu chuan ------------------
    subplot(3, 1, 1); 
    plot(t, speechSignal); 
    title('KET QUA KIEM THU CHUAN');
    xlabel('Time(s)'); 
    ylabel('Amplitude');

    for z = 1:length(point)
         x = [point(z) point(z)];
         y = [-1 1];
         if (z ~= 1)
            line(x, y, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
         end
    end
    
    for z = 1 : 2 : length(point)
        text(point(z) + 0.8, 0.8,'sil','Color','b','FontSize', 12);
        if z == 1
            text((point(z+1) + 0.1), 0.8, 'a', 'Color', 'r', 'FontSize', 12);
        end
        if z == 3
            text((point(z+1) + 0.1), 0.8, 'e', 'Color', 'r', 'FontSize', 12);
        end
        if z == 5
            text((point(z+1) + 0.1), 0.8, 'i', 'Color', 'r', 'FontSize', 12);
        end
        if z == 7
            text((point(z+1) + 0.1), 0.8, 'u', 'Color', 'r', 'FontSize', 12);
        end
        if z == 9
            text((point(z+1) + 0.1), 0.8, 'o', 'Color', 'r', 'FontSize', 12);
        end
        
    end

    legend('Tin hieu, bien thoi gian chuan')

    
    %% Tinh gia tri STE, ZCR
    ste = STE(frames);
    zcr = ZCR(frames);
    
    subplot(3, 1, 2);
    plot(t, ste);
    subplot(3, 1, 3);
    plot(t, zcr);

%      std_F2V= [45:81 153:185 269:286 378:415 484:514];
%      std_F2U= [1:44 82:152 186:268 287:377 416:483 515:558];

    % ------------------- Kết quả thực nghiệm ------------------
    % tim nguong cua ste = mot nua tong nang luong trung binh
%     ste_norm = normalize(ste,T_ste);
%     zcr_norm = normalize(zcr,T_zcr);    
%     T = findThreshold(ste_norm,zcr_norm);
%     vu = calVU(ste_norm,zcr_norm,T);
%     vu= filterVU(vu);
%     line_vu=[]; %danh dau nhung diem chuyen tu huu am sang vo am
%     index=1;
%     for i=1:length(vu)-1
%         if(vu(i)==0 && vu(i+1)==1 || vu(i)==1 && vu(i+1)==0)
%             line_vu(index)=i*frameDuration; %luu hoanh do cua nhung diem chuyen tiep
%             index=index+1;
%         end
%     end
% 
%     subplot(2,1,2);
%     plot(t,speechSignal,'linewidth',1); 
%     title('DO THI KET QUA THUC HIEN');
%     hold on;
%    
%     for i=1:length(line_vu)
%      a = [line_vu(i) line_vu(i)];
%      y = [-1 1];
%      line(a,y,'Color','b','LineStyle','-','linewidth',1);
%     end
%     for i=1:2:length(line_vu)
%         text((line_vu(i+1)-0.03),0.8,'v','Color','m');
%         text((line_vu(i)-0.03),-0.7,'u','Color','g');
%     end 
%     legend('Signal','Result')    

    % Ch�?n ngưỡng để phân biệt nguyên âm và khoảng lặng
%     threshold = 0.1 * max(ste);
%     % Tìm các biên giữa nguyên âm và khoảng lặng
%     boundaries = calBoundaries(ste, threshold);
%     
% %     plotBoundaries(x, fs, boundaries, frame_shift_sample);
% 
%     % Tạo biên trên tín hiệu âm thanh   nor
%     subplot(2, 1, 2);
%     plot(t, speechSignal);
%     hold on;
%     frame_shift_sample = round(Fs * overlappingDuration);
%     plot((boundaries*frame_shift_sample)/Fs, zeros(length(boundaries),1), 'ro');
% 
%     % Vẽ đư�?ng d�?c vuông góc với trục hoành tại các giá trị trong boundaries
%     for i = 1:length(boundaries)
%         line([boundaries(i)*frame_shift_sample/Fs, boundaries(i)*frame_shift_sample/Fs], ylim, 'Color', 'r');
%     end

end