%最小二乘法消除多项式趋势项

clc
clear
close all

%fni=input('消除多项式趋势项－输入数据文件名','s');
%fid=fopen(fni,'r')
%sf=fscanf(fid,'%f',1);     %读入采样频率值
%m=fscanf(fid,'%d',1);      %读入拟合多项式阶数
%fno=fscanf(fid,'%d',1);    %读入输出数据文件名
%x=fscanf(fid,'%f',inf);    %读入时程数据存成列向量

sf=200;     %采样频率值
m=1;        %拟合多项式阶数，m=1为线性趋势项

load origin  %载入振动的时域信号

x0=origin'; %读入部分振动的时域信号成列量，x0为原始数据
%status=fclose(fid);
n=length(x0); %取信号数据长度
t=(0:1/sf:(n-1)/sf)'; % 建立离散时间列向量
a=polyfit(t,x0,m);    % 计算趋势项的多项式待定系数，多项式系数按降幂排序
x1=x0-polyval(a,t);  % 用原始数据减去用多项式系数a生成的趋势项
% x1为处理后的数据

figure(1)
%处理前的信号
subplot(2,1,1)
plot(t,x0,'r');
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
title('\fontsize{10}\fontname{宋体}信号趋势项去除前后对比')
ylabel('\fontsize{10}\fontname{Times New Roman}Amplitude')
kk1=legend('\fontsize{10}\fontname{宋体}处理前信号');
set(kk1,'Position',[0.668362020824375 0.864949257331002 0.213223790338901 0.0562060900538531]);
legend boxoff
grid on;

%处理后的信号
subplot(2,1,2);
plot(t,x1,'b');
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
xlabel('\fontsize{10}\fontname{Times New Roman}Time / s')
ylabel('\fontsize{10}\fontname{Times New Roman}Amplitude')
kk2=legend('\fontsize{10}\fontname{宋体}处理后信号');
set(kk2,'Position',[0.668362020824375 0.394223262014843 0.213223790338901 0.0562060900538532]);
legend boxoff
grid on;
set(gcf,'unit','centimeters','position',[28 5 13.53 9.03],'color','white');%对应word（13.5,9）

save x1;%将处理后的数据存为.mat文件

% fid=fopen(fno,'w');
% for k=1:n
%    fprintf(fid,'%f%f\n',t(k),y1(k));
% end
% status=fclose(fid);