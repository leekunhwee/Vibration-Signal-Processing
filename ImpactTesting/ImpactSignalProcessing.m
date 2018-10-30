%--FRF Measurement with Impact Tests--%
clc
clear
close all
%% Time domain
load Point1_Channel1_CH1.txt            % load txt file

time=Point1_Channel1_CH1(:,1);          % time [s]
force=Point1_Channel1_CH1(:,2);         % input force (N)   
acc=Point1_Channel1_CH1(:,3);           % output acceleration (m/s^2) 
dT=time(2)-time(1);                     % time interval [s]
L=length(time);                         % Signal length 
fs=1/dT;                                % sampling frequency (Hz)

if mod(L,2)~=0
    time=time(1:end-1);
    force=force(1:end-1);
    acc=acc(1:end-1);
    L=L-1;
end

%% Time Domain
figure(1)
subplot(211); % Time domain signal
plot(time(1:1000),force(1:1000))
title('Time Domain Force & Acceleration')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itF \rm/ N')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212); % Time domain signal
plot(time(1:1000),acc(1:1000))
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itt \rm/ s')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \ita \rm/ m.s^{-2}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 15 13 9],'color','white');

%% Frequency Domain
% Force & Acceleration
f=fs*(0:(L/2))'/L;
w=2*pi*f;
Force=fft(force)/L;
F = Force(1:L/2+1);     % L must be even number
AbsF=abs(F);
F(2:end-1)=2*F(2:end-1);
AbsF(2:end-1)=2*AbsF(2:end-1);

Acc=fft(acc)/L;
A = Acc(1:L/2+1);       % L must be even number
AbsA=abs(A);
A(2:end-1)=2*A(2:end-1);
AbsA(2:end-1)=2*AbsA(2:end-1);

figure(2)
subplot(211); % Frequency domain signal
plot(f,AbsF);
xlim([0 5000])
title('Frequency Domain Force & Acceleration')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itF \rm/ N')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212); % Frequency domain signal
plot(f,AbsA);
xlim([0 5000])
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itacc \rm/ m.s^{-2}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[14 15 13 9],'color','white');

% Force & Displacement
X=A./(-w.^2);
AbsX=abs(X);
figure(3)
subplot(211); % Frequency domain signal
plot(f,AbsF);
xlim([0 5000])
title('Frequency Domain Force & Displacement')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itF \rm/ N')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212); % Frequency domain signal
plot(f,AbsX);
xlim([50 5000])
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itFRF \rm/ m')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 3 13 9],'color','white');

% Frequency Response Function
FRF=X./F;
figure(4)
subplot(211)
plot(f,real(FRF));
xlim([50 5000])
title('Frequency Responce Function')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itRe \rm/ m.N^{-1}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212)
plot(f,imag(FRF));
xlim([50 5000])
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itIm \rm/ m.N^{-1}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[14 3 13 9],'color','white');

% Cross-power Spectrum
SXF=X.*conj(F);

figure(5)
subplot(211)
plot(f,real(SXF));
xlim([50 5000])
title('Cross-power Spectrum')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itRe')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212)
plot(f,imag(SXF));
xlim([50 5000])
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itIm')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[20 3 13 9],'color','white');

% Autospectrum
SXX=X.*conj(X);

figure(6)
plot(f,SXX);
xlim([50 5000])
title('Autospectrum')
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itIm ')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[20 15 13 9],'color','white');

SFF=F.*conj(F);

figure(7)
plot(f,SFF);
xlim([50 5000])
title('Autospectrum')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itRe ')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
set(gcf,'unit','centimeters','position',[20 3 13 9],'color','white');


% Coherence
RXF=sqrt(abs(SXF.^2)./(SXX.*SFF));

figure(8)
plot(f,real(RXF));
xlim([50 20000])
title('Coherence')
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[20 3 13 9],'color','white');

% FRF

MFRF=SXF./SFF;
figure(9)
subplot(211)
plot(f,real(MFRF));
xlim([50 5000])
title('Frequency Responce Function')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itRe \rm/ m.N^{-1}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')

subplot(212)
plot(f,imag(MFRF));
xlim([50 5000])
xlabel('\fontsize{10.5}\fontname{Times New Roman} \itf \rm/ Hz')
ylabel('\fontsize{10.5}\fontname{Times New Roman} \itIm \rm/ m.N^{-1}')
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[14 3 13 9],'color','white');
