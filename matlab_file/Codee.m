clc;
clear;
close all;
[y, fs] = audioread('Recording.WAV.WAV');
y = y(:,1);
t = (0:length(y)-1)/fs;
figure;
plot(t, y);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Voice Signal in Time Domain');
grid on;
sound(y, fs);
back = flipud(y);

figure;
plot(t, back);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Backward Voice Signal');
grid on;

sound(back, fs);

audiowrite('backward_voice.wav', back, fs);
f = 1000 + 0958;

tone = 0.1*sin(2*pi*f*t');

voice_with_tone = y + tone;

figure;
plot(t, voice_with_tone);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Voice Signal with Tone');
grid on;

sound(voice_with_tone, fs);

audiowrite('voice_with_tone.wav', voice_with_tone, fs);
delay = 0.5;

D = round(delay * fs);

echo = [zeros(D,1); y];

y_extended = [y; zeros(D,1)];

echo_voice = y_extended + 0.5*echo;

t_echo = (0:length(echo_voice)-1)/fs;

figure;
plot(t_echo, echo_voice);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Voice Signal with Echo');
grid on;

sound(echo_voice, fs);

audiowrite('voice_with_echo.wav', echo_voice, fs);
N = length(y);

Y = fft(y);

f_axis = (0:N-1)*(fs/N);

magnitude = abs(Y);

figure;
plot(f_axis, magnitude);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Original Voice Signal in Frequency Domain');
grid on;
xlim([0 fs/2]);
N_back = length(back);

Y_back = fft(back);

f_back = (0:N_back-1)*(fs/N_back);

mag_back = abs(Y_back);

figure;
plot(f_back, mag_back);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Backward Voice in Frequency Domain');
grid on;
xlim([0 fs/2]);
N_tone = length(voice_with_tone);

Y_tone = fft(voice_with_tone);

f_tone = (0:N_tone-1)*(fs/N_tone);

mag_tone = abs(Y_tone);

figure;
plot(f_tone, mag_tone);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Voice with Tone in Frequency Domain');
grid on;
xlim([0 fs/2]);
N_echo = length(echo_voice);

Y_echo = fft(echo_voice);

f_echo = (0:N_echo-1)*(fs/N_echo);

mag_echo = abs(Y_echo);

figure;
plot(f_echo, mag_echo);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Voice with Echo in Frequency Domain');
grid on;
xlim([0 fs/2]);