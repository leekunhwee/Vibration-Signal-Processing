clear;clc
close all
%% FFT
Fs = 15e5;				    % Sampling frequency / Hz
T = 1/Fs;					% Sampling time / s
L0 = 1000;                  % Original signal length
L = 1000;                   % Data length 
t0 = (0:L0-1)*T;            % Original signal time sequence
x = cos(2*pi*1e6*t0) + cos(2*pi*1.05e6*t0); % Signal function
t = (0:L-1)*T;              % Data time sequence
%% Plot
plot(t*1e6,x,'b-','linewidth',1.5)
title('\fontsize{10}\fontname{Times New Roman}Time domain signal')
xlabel('\fontsize{10}\fontname{Times New Roman}\it t /\rm \mus')
ylabel('\fontsize{10}\fontname{Times New Roman}\it y\rm(\itt\rm)')
grid on;
axis([0 10 -2 2])
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[15 5 13.53 9.03],'color','white')
hold on
for cnt  =1:L
    x=[t(cnt)*1e6,t(cnt)*1e6];
    y=[-2,2];
    plot(x,y,'k')
end