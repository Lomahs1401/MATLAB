%% step
%n = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
%x = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1];
n = -5:1:5;
x = (n>=0);

stem(n, x, 'r.-', 'MarkerSize', 15);
xlim([n(1)-1 n(end)+1]);
ylim([-0.1 1.1]);
xlabel('--> n');
ylabel('--> Amplitude');
title('Unit Step Sequence');