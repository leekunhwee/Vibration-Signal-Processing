clc
clear
close all

%% Start

Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling time period
L = 50000;             % Length of signal 
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t); % Sinusoids Signal
% X = S + 2*randn(size(t));  % Sinusoids + Noise
X = S; % Sinusoids 

S1=0.7*sin(2*pi*50*t);
S2=sin(2*pi*120*t);
figure(1)
subplot(211)
plot(t(1:1000),S1(1:1000))
title('Sinusoidal Signal')

subplot(212)
plot(t(1:1000),S2(1:1000))


%%
% Time domain signal
figure(2) 
plot(t(1:1000),X(1:1000))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t [s]')
ylabel('X [m]')

%% 
% Frequency domain signal
Y = fft(X); % defult same to fft(X,length(X))
P2 = abs(Y/L); % Divided by signal length L. Get the two-sided spectrum P2.
P1 = P2(1:L/2+1); % Get the first half of P2
P1(2:end-1) = 2*P1(2:end-1); 
% Compute the single-sided spectrum P1 based on P2 
% and the even-valued signal length L.
f = Fs*(0:(L/2))/L;
% Define the frequency domain f and 
% plot the single-sided amplitude spectrum P1.
figure(3)
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f [Hz]')
ylabel('|P1(f)| [m]')