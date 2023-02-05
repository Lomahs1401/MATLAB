clear;

%% Tính giá tr? hàm s?
x = -5:0.5:5; % Gán các giá tr? cho bi?n x
y = 2 * x.^2; % Tính giá tr? hàm s?

%% V? ?? th? hàm s? y = 2x^2
figure;
plot(x, y);
xlabel('x');
ylabel('y');
title('Do thi ham so y = 2x^2');
grid on;