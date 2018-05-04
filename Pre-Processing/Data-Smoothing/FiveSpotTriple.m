%五点三次法平滑处理（时域和频域）
clear
clc
close all

sf=200;%采样频率值
m=20;%平滑次数
load y
x=y(1:1000);
a=x;

n=length(x);
t=(0:1/sf:(n-1)/sf);
for k=1:m
    b(1)=(69*a(1)+4*(a(2)+a(4))-6*a(3)-a(5))/70;
    b(2)=(2*(a(1)+a(5))+27*a(2)+12*a(3)-8*a(4))/35;
    for j=3:n-2
        b(j)=(-3*(a(j-2)+a(j+2))+12*(a(j-1)+a(j+1))+17*a(j))/35;
    end
    b(n-1)=(2*(a(n)+a(n-4))+27*a(n-1)+12*a(n-2)-8*a(n-3))/35;
    b(n)=(69*a(n)+4*(a(n-1)+a(n-3))-6*a(n-2)-a(n-4))/70;
    a=b;
end

plot(t,x,'r:',t,a,'b');
xlabel('\fontsize{10}\fontname{Times New Roman}Time / s')
ylabel('\fontsize{10}\fontname{Times New Roman}Amplitude / mm')
legend('\fontsize{10}\fontname{宋体}平滑前','\fontsize{10}\fontname{宋体}平滑后');
grid on;
legend boxoff
title('\fontsize{10}\fontname{宋体}五点三次法平滑前后对比')
set(gcf,'unit','centimeters','position',[28 5 13.53 9.03],'color','white');%对应word（13.5,9）