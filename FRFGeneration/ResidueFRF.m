%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -------------Copyright--------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Jianhui Li                         %
% Time: 09/22/2019                           %
% University of British Columbia, BC, Canada %
% Affiliation:                               %
% Department of Mechanical Engineering       %
% Manufacturing Automation Laboratary        %
% E-mail: jianhui.li@alumni.ubc.ca           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reference£º
%Kai, C. (2009). Machining Dynamics. (K. Cheng, Ed.).
%London: Springer London. https://doi.org/10.1007/978-1-84628-368-0
%P210
% There are some parameters may not correspond with the figures in the book 
% some parameters was modified
% The unit of frequency:  rad¡¤s^{-1}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear

% Modal parameters in X direction of cutting tool
% 
wnX = [120.5 247.05 341.65 645.48 715.39 731.75 748.76 761.57 811.46 987.15 1030 1160 1200]*2*pi;               %   rad¡¤s^{-1}
zetaX = [4.21 3.54 0.93693 0.26558 0.41218 0.29715 0.16347 0.41044 1.01 3.67 0.789 0.94237 0.44894 ]*0.01;
resiX=[8.031267e-006+1j*1.830470e-006 3.442107e-006+1j*5.209837e-007 9.108225e-006+1j*(-1.908909e-006)...
   8.633025e-007+1j*(-7.830841e-007)  1.057337e-005+1j*(-7.500871e-006) 1.022476e-006+1j*(-1.673413e-006)...
   1.016291e-006+1j*(-2.033546e-007) 2.639827e-006+1j*2.095946e-007 4.304769e-006+1j*4.423204e-007...
   3.820509e-005+1j*3.567028e-006 9.331169e-007+1j*2.193275e-006 -2.194058e-006+1j*(-1.615678e-006)...
   -7.935642e-007+1j*2.950998e-007]; %m/N

% Modal parameters in Y direction of cutting tool
wnY = [49.21 94.72 160.38 187.55 238.66 344.69 439.92 488.25 586.86 684.19 751.8 894.23]*2*pi;               %   rad¡¤s^{-1}
zetaY = [0.20605 0.36509 2.44 1.97 2.58 1.72 1.6 0.218 0.46732 1.85 1.58 2.39]*0.01;
resiY=[-1.733888e-008+1j*1.712200e-008 2.465764e-008+1j*(-6.332934e-008) -4.392552e-007+1j*1.364358e-007...
    2.269027e-006+1j*(-1.301338e-006) 1.201795e-006+1j*(-7.724067e-007) 3.348905e-006+1j*(-5.251082e-006)...
    -7.110383e-007+1j*2.433423e-008 -2.326689e-008+1j*8.504934e-008 1.274008e-007+1j*1.548505e-007...
    2.273516e-005+1j*(-9.893721e-006) 1.434414e-005+1j*(-3.420460e-005) -3.932861e-006+1j*(-1.978372e-006)]; %m/N

% k = [1.2e7 1.3e7 3.7e6];                     % N/m
% zeta = [0.041 0.048 0.027];
% wn = [309.1 1389 1586]*2*pi;               %   rad¡¤s^{-1}

% Analysis frequency width and its resolution
f_start=0;
f_end=8000-0.5;
df=1;
w = (f_start:df:f_end)'*2*pi;   % frequency,   rad¡¤s^{-1}
f=w/2/pi;

% Define cells

FRFiX={1,length(resiX)};
FRFiY={1,length(resiY)};

% Initialization
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

% Supreposition of all the modes
for cnt = 1:length(resiX)

    wdX(cnt)=wnX(cnt)*sqrt(1-zetaX(cnt)^2);
    alphaX(cnt)=1j*(-zetaX(cnt)*wnX(cnt)*sigmaX(cnt)+wdX(cnt)*nuX(cnt));
    betaX(cnt)=1j*(-sigmaX(cnt));

    FRFiX{cnt} = (alphaX(cnt).*ones(length(w),1)+1j*betaX(cnt).*w)./(wnX(cnt)^2-w.^2 +1j* (2*zetaX(cnt)*wnX(cnt).*w));
    FRFX= FRFX + FRFiX{cnt};
end

for cnt = 1:length(resiY)

    wdY(cnt)=wnY(cnt)*sqrt(1-zetaY(cnt)^2);
    alphaY(cnt)=1j*(-zetaY(cnt)*wnY(cnt)*sigmaY(cnt)+wdY(cnt)*nuY(cnt));
    betaY(cnt)=1j*(-sigmaY(cnt));

    FRFiY{cnt} = (alphaY(cnt).*ones(length(w),1)+1j*betaY(cnt).*w)./(wnY(cnt)^2-w.^2 +1j* (2*zetaY(cnt)*wnY(cnt).*w));
    FRFY= FRFY + FRFiY{cnt};
end

figure(1)
subplot(211)
for cnt = 1:length(resiX)
    plot(f*2*pi,real(FRFiX{cnt}))
    hold on
end
plot(f*2*pi,real(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF X')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')
legend('1','2','3','4','5','6','7','8','9','10','11','12')
subplot(212)
for cnt = 1:length(resiX)
    plot(f*2*pi,imag(FRFiX{cnt}))
    hold on
end
plot(f*2*pi,imag(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');% word£¨13.5,9£©
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')

figure(2)

plot(f*2*pi,abs(FRFX),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF X')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')


figure(3)
subplot(211)
for cnt = 1:length(resiY)
    plot(f*2*pi,real(FRFiY{cnt}))
    hold on
end
plot(f*2*pi,real(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF Y')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')
legend('1','2','3','4','5','6','7','8','9','10','11','12')
subplot(212)
for cnt = 1:length(resiY)
    plot(f*2*pi,imag(FRFiY{cnt}))
    hold on
end
plot(f*2*pi,imag(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');% word£¨13.5,9£©
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')

figure(4)

plot(f*2*pi,abs(FRFY),'b','linewidth',2)
xlim([0,8000])
grid on  
title('\fontsize{10}FRF Y')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f  \rm/  rad¡¤s^{-1}')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRf  \rm/ m¡¤N^{-1}')


H21(:,1)=real(FRFX);
H21(:,2)=imag(FRFX);

H22(:,1)=real(FRFY);
H22(:,2)=imag(FRFY);

save('H2','H21','H22','f_start','f_end','df')
