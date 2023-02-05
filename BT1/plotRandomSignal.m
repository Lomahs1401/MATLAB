function plotRandomSignal(mean, std, N)
    observations = mean + std * randn(1, N);
    plot(observations);
    xlabel('n');
    ylabel('x[n]');
    title('Random Signal');
    grid on;
    sound(observations)
end