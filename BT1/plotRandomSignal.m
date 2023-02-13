function plotRandomSignal(mean, std, N)
    observations = mean + std * randn(1, N);
    plot(observations);
    xlabel('n');
    ylabel('x[n]');
    title('Random Signal');
    grid on;
    Fs = 44100;
    sound(observations, Fs)
    filename='sound.wav';
    audiowrite(filename, observations, Fs)
end