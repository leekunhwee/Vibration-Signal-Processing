%%%%%%%%%%%%%%%%%%%%%%%
%通过模态叠加法得到最终频响，考虑留数%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Copyright                        %
%     This code is developed by Jianhui Li    %
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%数据来源：
%Altintas, Y. (2012). Manufacturing Automation: 
%Metal Cutting Mechanics, Machine Tool Vibrations, and CNC Design. 
%Applied Mechanics Reviews (Vol. 54). https://doi.org/10.1115/1.1399383
%P162
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear

% 定义刀具X向模态参数
% 
wnX = [262.16 503.60 667.92 886.78 2201.5 2799.4 3837.7 4923.6 6038.7]*2*pi;               % rad/s
zetaX = [0.048 0.096 0.057 0.074 0.015 0.027 0.007 0.019 0.025];
resiX=[1.994606E-06-1j*3.779091E-06 1.932445E-06-1j*2.44616E-05 1.364547E-05-1j*4.128093E-05...
    8.632813E-07-1j*7.195716E-05 -5.011467E-06-1j*4.623555E-05 -1.394105E-05-1j*8.317728E-05...
    6.874543E-06-1j*6.560925E-05 -8.824935E-06-1j*6.54481E-05 2.564520E-06-1j*1.986276E-05]; %m/N

% 定义刀具Y向模态参数
wnY = [285.53 587.8 749.6 804.9 1573.7 2038.1 2303.3 2681.0 2870.5 3838.8 4928.9 6073.4]*2*pi;               % rad/s
zetaY = [0.021 0.089 0.027 0.075 0.027 0.016 0.220 0.019 0.014 0.006 0.017 0.016];
resiY=[9.797268E-07-1j*5.959362E-07 1.349004E-05-1j*4.544067E-06 -3.106831E-05-1j*3.816475E-05...
    3.033849E-05-1j*8.813244E-05 1.283945E-06-1j*8.678961E-06 1.298625E-06-1j*1.270846E-05...
    9.518897E-07-1j*3.750897E-05 1.190834E-05-1j*2.825781E-05 -1.912932E-05-1j*4.051860E-05...
    -1.119589E-05-1j*8.475725E-05 -1.859880E-05-1j*8.993226E-05 -7.608392E-06-1j*2.022991E-05]; %m/N

% k = [1.2e7 1.3e7 3.7e6];                     % N/m
% zeta = [0.041 0.048 0.027];
% wn = [309.1 1389 1586]*2*pi;               % rad/s

% 定义分析频带及分辨率
f_start=0;
f_end=8000-0.5;
df=1;
w = (f_start:df:f_end)'*2*pi;   % frequency, rad/s
f=w/2/pi;

% 定义元胞数组

FRFiX={1,length(resiX)};
FRFiY={1,length(resiY)};

%初始化
FRFX= zeros(length(w),1);
FRFY= zeros(length(w),1);

alphaX=zeros(1,length(resiX));
alphaY=zeros(1,length(resiY));

betaX=zeros(1,length(resiX));
betaY=zeros(1,length(resiY));

wdX=zeros(1,length(resiX));
wdY=zeros(1,length(resiY));

sigmaX=real(resiX);
sigmaY=real(resiY);

nuX=imag(resiX);
nuY=imag(resiY);

%实验发现这里的公式和ResidueFRF中不一样 幅值差一倍的关系 原因是两者所用的公式不同
%以这里的为准
for cnt = 1:length(resiX)

    wdX(cnt)=wnX(cnt)*sqrt(1-zetaX(cnt)^2);
    alphaX(cnt)=2*(zetaX(cnt)*wnX(cnt)*sigmaX(cnt)-wdX(cnt)*nuX(cnt));
    betaX(cnt)=2*sigmaX(cnt);

    FRFiX{cnt} = (alphaX(cnt).*ones(length(w),1)+1j*betaX(cnt).*w)./(wnX(cnt)^2-w.^2 +1j* (2*zetaX(cnt)*wnX(cnt).*w));
    FRFX= FRFX + FRFiX{cnt};
end

for cnt = 1:length(resiY)

    wdY(cnt)=wnY(cnt)*sqrt(1-zetaY(cnt)^2);
    
    alphaY(cnt)=2*(zetaY(cnt)*wnY(cnt)*sigmaY(cnt)-wdY(cnt)*nuY(cnt));
    betaY(cnt)=2*sigmaY(cnt);

    FRFiY{cnt} = (alphaY(cnt).*ones(length(w),1)+1j*betaY(cnt).*w)./(wnY(cnt)^2-w.^2 +1j* (2*zetaY(cnt)*wnY(cnt).*w));
    FRFY= FRFY + FRFiY{cnt};
end

figure(1)
subplot(211)
for cnt = 1:length(resiX)
    plot(f,real(FRFiX{cnt}))
    hold on
end
plot(f,real(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF X')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')
% legend('1','2','3','4','5','6','7','8','9','10','11','12')
subplot(212)
for cnt = 1:length(resiX)
    plot(f,imag(FRFiX{cnt}))
    hold on
end
plot(f,imag(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%对应word（13.5,9）
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')

figure(2)

plot(f,abs(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF X')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')


figure(3)
subplot(211)
for cnt = 1:length(resiY)
    plot(f,real(FRFiY{cnt}))
    hold on
end
plot(f,real(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF Y')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')
% legend('1','2','3','4','5','6','7','8','9','10','11','12')
subplot(212)
for cnt = 1:length(resiY)
    plot(f,imag(FRFiY{cnt}))
    hold on
end
plot(f,imag(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%对应word（13.5,9）
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')

figure(4)

plot(f,abs(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF Y')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m·N^{-1}')


H21(:,1)=real(FRFX);
H21(:,2)=imag(FRFX);

H22(:,1)=real(FRFY);
H22(:,2)=imag(FRFY);

save('H2','H21','H22','f_start','f_end','df')
