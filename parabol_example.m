clear;

%% T�nh gi� tr? h�m s?
x = -5:0.5:5; % G�n c�c gi� tr? cho bi?n x
y = 2 * x.^2; % T�nh gi� tr? h�m s?

%% V? ?? th? h�m s? y = 2x^2
figure;
plot(x, y);
xlabel('x');
ylabel('y');
title('Do thi ham so y = 2x^2');
grid on;