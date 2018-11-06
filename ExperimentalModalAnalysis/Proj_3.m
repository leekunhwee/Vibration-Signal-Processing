clc
clear
close all

%% Data Load
% load Point1_Channel1_CH1.txt

a=dir(fullfile('E:\Work\UBC\Courses\MECH592_Vibration\Project_III\*.txt'));
for ii=1:length(a)
    load(fullfile('E:\Work\UBC\Courses\MECH592_Vibration\Project_III',a(ii).name));
end

% first mode real peak, valley and image valley
% second mode real peak, valley and image valley 
G11=[0.4049	-0.2891	-0.6433	0.1609	-0.0588	-0.2138	0.1084	-0.1173	-0.2180]*1e-6;
G12=[0.2244	-0.2384	-0.4380	0.0322	-0.0355	-0.0879	0.0009	-0.0451	-0.0491]*1e-6;
G13=[0.1470	-0.1814	-0.3077	-0.0108	-0.0274	-0.0228	-0.0240	0.0014	0.0154]*1e-6;
G14=[0.0994	-0.1344	-0.2158	-0.0252	-0.0016	0.0166	-0.0205	0.0091	0.0300]*1e-6;
G15=[0.0730	-0.0947	-0.1566	-0.0282	0.0037	0.0266	-0.0163	0.0143	0.0328]*1e-6;

w=(101:3500)*2*pi;
%% First modal
f1=1074;
w1=2*pi*f1;
zeta1=(1104-1031)/(2*f1);

k11=-1/(2*zeta1*G11(3));
m11=k11/(w1^2);
frf111=(w1^2/k11)./(w1^2 - w.^2 + 1i*2*zeta1*w1.*w);

k12=-1/(2*zeta1*G12(3));
m12=k12/(w1^2);
frf112=(w1^2/k12)./(w1^2 - w.^2 + 1i*2*zeta1*w1.*w);

k13=-1/(2*zeta1*G13(3));
m13=k13/(w1^2);
frf113=(w1^2/k13)./(w1^2 - w.^2 + 1i*2*zeta1*w1.*w);

k14=-1/(2*zeta1*G14(3));
m14=k14/(w1^2);
frf114=(w1^2/k14)./(w1^2 - w.^2 + 1i*2*zeta1*w1.*w);

k15=-1/(2*zeta1*G15(3));
m15=k15/(w1^2);
frf115=(w1^2/k15)./(w1^2 - w.^2 + 1i*2*zeta1*w1.*w);

%% Second modal
f2=1961;
w2=2*pi*f2;
zeta2=(2092-1914)/(2*f2);

k21=-1/(2*zeta2*G11(6));
m21=k21/(w2^2);
frf211=(w2^2/k21)./(w2^2 - w.^2 + 1i*2*zeta2*w2.*w);

k22=-1/(2*zeta2*G12(6));
m22=k22/(w2^2);
frf212=(w2^2/k22)./(w2^2 - w.^2 + 1i*2*zeta2*w2.*w);

k23=-1/(2*zeta2*G13(6));
m23=k23/(w2^2);
frf213=(w2^2/k23)./(w2^2 - w.^2 + 1i*2*zeta2*w2.*w);

k24=-1/(2*zeta2*G14(6));
m24=k24/(w2^2);
frf214=(w2^2/k24)./(w2^2 - w.^2 + 1i*2*zeta2*w2.*w);

k25=-1/(2*zeta2*G15(6));
m25=k25/(w2^2);
frf215=(w2^2/k25)./(w2^2 - w.^2 + 1i*2*zeta2*w2.*w);
%% Third modal
f3=2617;
w3=2*pi*f3;
zeta3=(2092-1914)/(2*f3);

k31=-1/(2*zeta3*G11(9));
m31=k31/(w3^2);
frf311=(w3^2/k31)./(w3^2 - w.^2 + 1i*2*zeta3*w3.*w);

k32=-1/(2*zeta3*G12(9));
m32=k32/(w3^2);
frf312=(w3^2/k32)./(w3^2 - w.^2 + 1i*2*zeta3*w3.*w);

k33=-1/(2*zeta3*G13(9));
m33=k33/(w3^2);
frf313=(w3^2/k33)./(w3^2 - w.^2 + 1i*2*zeta3*w3.*w);

k34=-1/(2*zeta3*G14(9));
m34=k34/(w3^2);
frf314=(w3^2/k34)./(w3^2 - w.^2 + 1i*2*zeta3*w3.*w);

k35=-1/(2*zeta3*G15(9));
m35=k35/(w3^2);
frf315=(w3^2/k35)./(w3^2 - w.^2 + 1i*2*zeta3*w3.*w);
%%
figure(1)
subplot(211)
plot(Point_1_Channel_1_CH1(101:3500,1),Point_1_Channel_1_CH1(101:3500,2),'b-','linewidth',2);

hold on
plot(w/2/pi,real(frf111),'r-','linewidth',2);
plot(w/2/pi,real(frf211),'r--','linewidth',2);
plot(w/2/pi,real(frf311),'r-.','linewidth',2);

legend('\fontsize{10}\fontname{Times New Roman}\itReal','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}FRF G11')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')
subplot(212)
plot(Point_1_Channel_1_CH1(101:3500,1),Point_1_Channel_1_CH1(101:3500,3),'b-','linewidth',2);
hold on
plot(w/2/pi,imag(frf111),'r-','linewidth',2);
plot(w/2/pi,imag(frf211),'r--','linewidth',2);
plot(w/2/pi,imag(frf311),'r-.','linewidth',2);

legend('\fontsize{10}\fontname{Times New Roman}\itImag','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%??word?13.5,9?
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')

figure(2)
subplot(211)
plot(Point_2_Channel_1_CH1(101:3500,1),Point_2_Channel_1_CH1(101:3500,2),'b-','linewidth',2);
hold on
plot(w/2/pi,real(frf112),'r-','linewidth',2);
plot(w/2/pi,real(frf212),'r--','linewidth',2);
plot(w/2/pi,real(frf312),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itReal','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}FRF G12')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')
subplot(212)
plot(Point_2_Channel_1_CH1(101:3500,1),Point_2_Channel_1_CH1(101:3500,3),'b-','linewidth',2);
hold on
plot(w/2/pi,imag(frf112),'r-','linewidth',2);
plot(w/2/pi,imag(frf212),'r--','linewidth',2);
plot(w/2/pi,imag(frf312),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itImag','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%??word?13.5,9?
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')

figure(3)
subplot(211)
plot(Point_3_Channel_1_CH1(101:3500,1),Point_3_Channel_1_CH1(101:3500,2),'b-','linewidth',2);
hold on
plot(w/2/pi,real(frf113),'r-','linewidth',2);
plot(w/2/pi,real(frf213),'r--','linewidth',2);
plot(w/2/pi,real(frf313),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itReal','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}FRF G13')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')
subplot(212)
plot(Point_3_Channel_1_CH1(101:3500,1),Point_3_Channel_1_CH1(101:3500,3),'b-','linewidth',2);
hold on
plot(w/2/pi,imag(frf113),'r-','linewidth',2);
plot(w/2/pi,imag(frf213),'r--','linewidth',2);
plot(w/2/pi,imag(frf313),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itImag','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%??word?13.5,9?
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')

figure(4)
subplot(211)
plot(Point_4_Channel_1_CH1(101:3500,1),Point_4_Channel_1_CH1(101:3500,2),'b-','linewidth',2);
hold on
plot(w/2/pi,real(frf114),'r-','linewidth',2);
plot(w/2/pi,real(frf214),'r--','linewidth',2);
plot(w/2/pi,real(frf314),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itReal','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}FRF G14')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')
subplot(212)
plot(Point_4_Channel_1_CH1(101:3500,1),Point_4_Channel_1_CH1(101:3500,3),'b-','linewidth',2);
hold on
plot(w/2/pi,imag(frf114),'r-','linewidth',2);
plot(w/2/pi,imag(frf214),'r--','linewidth',2);
plot(w/2/pi,imag(frf314),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itImag','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%??word?13.5,9?
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')

figure(5)
subplot(211)
plot(Point_5_Channel_1_CH1(101:3500,1),Point_5_Channel_1_CH1(101:3500,2),'b-','linewidth',2);
hold on
plot(w/2/pi,real(frf115),'r-','linewidth',2);
plot(w/2/pi,real(frf215),'r--','linewidth',2);
plot(w/2/pi,real(frf315),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itReal','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}FRF G15')
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')
subplot(212)
plot(Point_5_Channel_1_CH1(101:3500,1),Point_5_Channel_1_CH1(101:3500,3),'b-','linewidth',2);
hold on
plot(w/2/pi,imag(frf115),'r-','linewidth',2);
plot(w/2/pi,imag(frf215),'r--','linewidth',2);
plot(w/2/pi,imag(frf315),'r-.','linewidth',2);
legend('\fontsize{10}\fontname{Times New Roman}\itImag','location','northwest')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%??word?13.5,9?
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it FRF\rm/ m意^{-1}')

%% 
u11=sqrt(-2*zeta1*w1^2*G11(3));
u12=sqrt(-2*zeta2*w2^2*G11(6));
u13=sqrt(-2*zeta3*w3^2*G11(9));

u21=-2*zeta1*w1^2*G12(3)/u11;
u22=-2*zeta2*w2^2*G12(6)/u12;
u23=-2*zeta3*w3^2*G12(9)/u13;

u31=-2*zeta1*w1^2*G13(3)/u11;
u32=-2*zeta2*w2^2*G13(6)/u12;
u33=-2*zeta3*w3^2*G13(9)/u13;

u41=-2*zeta1*w1^2*G14(3)/u11;
u42=-2*zeta2*w2^2*G14(6)/u12;
u43=-2*zeta3*w3^2*G14(9)/u13;

u51=-2*zeta1*w1^2*G15(3)/u11;
u52=-2*zeta2*w2^2*G15(6)/u12;
u53=-2*zeta3*w3^2*G15(9)/u13;

p1=[u11 u21 u31 u41 u51]'
p2=[u12 u22 u32 u42 u52]'
p3=[u13 u23 u33 u43 u53]'

figure(10)
y=[0 55 90 130 165];
plot(p1,y,'r','linewidth',2)
hold on
plot(p2,y,'g','linewidth',2)
plot(p3,y,'b','linewidth',2)
plot([0,0],[0,165],'k','linewidth',2)
legend('mode1','mode2','mode3')