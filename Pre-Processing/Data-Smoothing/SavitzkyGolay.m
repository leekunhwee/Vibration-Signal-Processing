%滑动平均法消除趋势项
clear
clc
close all 

sf=200;%采样频率值

load y

x=y(1:100);
k=length(x);
noise = 0.03*randn(1,k);%服从正态分布的噪声信号
x0=x+noise;%添加噪声信号
n=length(x0);%取信号数据长度
t=(0:1/sf:(n-1)/sf);% 建立离散时间列向量

x1=SG_filter(x0,3,7);% 使用SavitzkyGolay滤波

plot(t,x0,'r',t,x1,'b');
xlabel('\fontsize{10}\fontname{Times New Roman}Time / s')
ylabel('\fontsize{10}\fontname{Times New Roman}Amplitude / mm')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
legend('\fontsize{10}\fontname{宋体}滤波前','\fontsize{10}\fontname{宋体}滤波后');
legend boxoff
grid on;
title('\fontsize{10}\fontname{宋体}滤波前后对比')
set(gcf,'unit','centimeters','position',[28 5 13.53 9.03],'color','white');%对应word（13.5,9）
