clear;clc
close all
%% FFT
Fs = 100e6;				    % Sampling frequency / Hz
T = 1/Fs;					% Sampling time / s
L0 = 1000;                  % Original signal length
L = 7000;                   % Data length 
t0 = (0:L0-1)*T;            % Original signal time sequence
x = cos(2*pi*1e6*t0) + cos(2*pi*1.05e6*t0); % Signal function
t = (0:L-1)*T;              % Data time sequence
y = zeros(1,L);
y(1:L0) = x;
%% Plot
figure(1)
plot(t*1e6,y,'b-','linewidth',1.5)
title('\fontsize{10}\fontname{Times New Roman}Time domain signal with Zero Padding')
xlabel('\fontsize{10}\fontname{Times New Roman}\it t /\rm \mus')
ylabel('\fontsize{10}\fontname{Times New Roman}\it y\rm(\itt\rm)')
grid on;
axis([0 70 -2 2])
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[15 10 13.53 9.03],'color','white')
%% FFT
Y = fft(y);                   % FFT
% Calculate double sides spectrum P2, and then calculate single side
% spectrum P1 based on P2 and even data length
P2 = abs(Y/L0);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;% Rfft
figure(2)
plot(f, P1,'r-','Marker','.','markersize',10,'linewidth',1.5)
axis([0.5e6 1.5e6 0 1.5])
title('\fontsize{10}\fontname{Times New Roman}Power Spectrum')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f /\rm Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it y\rm(\itf\rm)')
grid on;
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[15 10 13.53 9.03],'color','white')