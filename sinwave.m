t = 0:0.01:10;

xt = sin(2*pi*t );
yt = cos(4*pi*t);

z = xt + yt;

plot(t, xt, 'go:');
hold on
plot(t, yt, 'kx-.');
plot(t, z);
legend('sin', 'cos', 'sum');
xlabel('x');
ylabel('y');
title('Signals');
axis([t(1) t(end) -3 3]);
hold off