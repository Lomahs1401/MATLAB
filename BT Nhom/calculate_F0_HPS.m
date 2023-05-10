function F0 = calculate_F0_HPS(x, fs)
% Tính toán tần số cơ bản (F0) của một khung hữu thanh sử dụng phương pháp HPS
% x: khung tín hiệu âm thanh
% fs: tần số mẫu của tín hiệu âm thanh
min_f0 = 70;
max_f0 = 400;

CorrectFactor = 0.986;
threshold = 0.2;

N = length(x); % số mẫu trong khung
X = abs(fft(x)); % tính phổ biên độ của khung
X = X(1:N/2+1); % chỉ giữ các giá trị tần số dương

% Tính HPS
X_2 = downsample(X,2);
X_3 = downsample(X,3);
X_4 = downsample(X,4);
X_5 = downsample(X,5);

X_hps = zeros(size(X_5));


for i=1:length(X_5)

      Product =   X(i)  * X_2(i) * X_3(i) * X_4(i) * X_5(i);
      X_hps(i) = [Product];
end
[max_val, max_idx] = max(X_hps);

% Tính tần số cơ bản
 
 F0 = (max_idx - 1) * fs / N;

 if (F0 < min_f0 || F0 > max_f0)
     F0 = 0;
    
 plot(X)
% [m,n] = findpeaks(X_hps, 'SORTSTR', 'descend');
% 
% Maximum = n(1);

 %try fix octave error
% if (X_hps(n(1)) * 0.5) > (X_hps(n(2))) %& ( ( m(2) / m(1) ) > threshold )
% 
%     Maximum  = n(length(n));
% 
% end

% F0 =  ( (Maximum / 4096) * fs ) * CorrectFactor 

end

