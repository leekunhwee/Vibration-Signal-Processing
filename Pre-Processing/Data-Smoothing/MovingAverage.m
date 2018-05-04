%滑动平均法消除趋势项
clear
clc
close all 
%fni=input('滑动平均法平滑处理－输入数据文件名','s');
%fid=fopen(fni,'r')
%sf=fscanf(fid,'%f',1);     %读入采样频率值
%l=fscanf(fid,'%d',1);      %读入滑动阶次
%m=fscanf(fid,'%d',1);      %读入平滑次数
%fno=fscanf(fid,'%d',1);    %读入输出数据文件名
%x=fscanf(fid,'%f',inf);    %读入时程数据存成列向量
sf=200;%采样频率值
l=30;%数据延伸量
m=300;
% fno='out4_3.mat';
load y
x=y(1:1000);
%status=fclose(fid);
n=length(x);%取信号数据长度
t=(0:1/sf:(n-1)/sf);% 建立离散时间列向量
b=ones(1,l);%生成一个元素 1 的行向量
a=[b*x(1),x,b*x(n)];%信号两端分别向外延伸l个数据
b=a;

for k=1:m
    for j=l+1:n-1
        b(j)=mean(a(j-1:j+1));
    end
    a=b;
end
y=x(1:n)-a(l+1:n+l);

plot(t,x,'r',t,y,'g',t,a(l+1:n+l),'b-.');

xlabel('\fontsize{10}\fontname{Times New Roman}Time / s')
ylabel('\fontsize{10}\fontname{Times New Roman}Amplitude / mm')
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
legend('\fontsize{10}\fontname{宋体}滤波前','\fontsize{10}\fontname{宋体}滤波后','\fontsize{10}\fontname{宋体}趋势项');
legend boxoff
grid on;
set(gcf,'unit','centimeters','position',[28 5 13.53 9.03],'color','white');%对应word（13.5,9）

% fid=fopen(fno,'w');
% for k=1:n
%    fprintf(fid,'%f%f\n',t(k),y(k));
% end
% status=fclose(fid);