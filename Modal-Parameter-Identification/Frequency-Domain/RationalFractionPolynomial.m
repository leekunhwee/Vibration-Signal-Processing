%%%%%%%%%%%%%%%%%%
%有理分式多项式法模态参数识别%
%%%%%%%%%%%%%%%%%%
%Levy方法 %
%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Copyright                        %
%     This code is developed by Jianhui Li    %
%%%%%%%%%%%%%%%%%%%%%%%%%
% 
clc
clear
close all

mn=3;       %模态阶数

load H00   %导入频响数据

b=H00';     %转置 某方向实部和虚部组成的矩阵

nm=mn*2;            %定义幂多项式的阶数; N阶模态对应2N次有理多项式
n=length(b(1,:));   %取频响函数的长度
f=f_start:df:f_start+(n-1)*df;      %建立离散频率向量
w=2*pi*f;               %建立离散角频率向量

wi=w/max(w);        %建立归一化离散时间频率向量（在后面将还原）

H=b(1,:)+1i*b(2,:);  %建立实测预响函数复数行向量

[A,B]=invfreqs(H,wi,nm,nm,[],100); %计算拟合频响函数的分子和分母系数向量
% 这里 A为分子系数向量；B为分母系数向量
% 函数调用格式为 [b, a]=invfreqs(H, wi, nb, ba, wt, iter)
% 返回按降幂排序的传递函数分母系数向量a 和分子系数向量b，此处b2N=1
% H为指定系统的复频率响应
% wi为对应响应函数的频率值
% na、nb为传递函数的分母和分子的阶次
% wt为权函数，如果采用全为1的加权，可用空向量[]代替
% iter为迭代次数

P=roots(B);             %幂多项式方程求根（零点）
% 返回由系数向量B构成的幂多项式的根，其中系数向量B按降幂排序
% 其实P就是原频响函数的极点所组成的向量

F1=abs(P)*max(w)/(2*pi);    %计算模态频率向量
% 因为前面归一化，所以这里还原
% 复数与其共轭的乘积开根号=abs(该复数)
% 通过除以2*pi变为赫兹频率

D1=-real(P)./(abs(P));          %计算阻尼比向量
% 另一种计算方法，得到将是阻尼比，且由于上下抵消，不需要再考虑归一化还原

%初始化
S1 =zeros(1,nm);

%计算振型系数向量
for k=1:nm
    if k==1
        p(1:nm-1)=P(2:nm);
    else
        p(1:k-1)=P(1:k-1);
        p(k:nm-1)=P(k+1:nm);
    end
    y=poly(p);
    % 其中p是确定多项式的根向量，返回值为该多项式的系数向量。
    S1(k)=polyval(A,P(k))/polyval(y,P(k));
end

%计算拟合的频响函数
H1=freqs(A,B,wi);

%绘制频响函数拟合曲线
nn=1:n;

figure(1)
subplot(3,1,1);
plot(f,real(H(nn)),'b',f,real(H1(nn)),'r:');
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%对应word（13.5,9）
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it Real\rm/ m·N^{-1}')
legend('\fontsize{10}\fontname{宋体}实测','\fontsize{10}\fontname{宋体}拟合');
grid on;

subplot(3,1,2);
% plot(f,b(2,:),'b',f,imag(H1(nn)),'r:');
plot(f,imag(H(nn)),'b',f,imag(H1(nn)),'r:');
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%对应word（13.5,9）
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it Image\rm/ m·N^{-1}')
legend('\fontsize{10}\fontname{宋体}实测','\fontsize{10}\fontname{宋体}拟合');
grid on;

subplot(3,1,3);
plot(f,abs(H(nn)),'b',f,abs(H1(nn)),'r:');
set(gca,'FontSize', 10 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 10 13.53 9.03],'color','white');%对应word（13.5,9）
xlabel('\fontsize{10}\fontname{Times New Roman}\it f\rm/ Hz')
ylabel('\fontsize{10}\fontname{Times New Roman}\it Amplitude\rm/ m·N^{-1}')
legend('\fontsize{10}\fontname{宋体}实测','\fontsize{10}\fontname{宋体}拟合');
grid on;
%将模态频率从小到大排序
[F2,I]=sort(F1);

%剔除方程解中的非模态项（非共轭根）和共轭项（重复项）
m=0;

for k=1:nm-1
    
    if F2(k)~=F2(k+1)
        continue
    end
    
    %如果超出分析频段 则剔除
    l=I(k);    
    if F1(l)>f_end||F1(l)<f_start
        continue
    end    
    
    m=m+1;% 满足全部要求，添加到最后结果中

    F(m)=F1(l); %模态频率
    D(m)=D1(l);%阻尼比
    S(m)=S1(l);%振型系数
end

OF=F;
OD=D;

% 通过上式可以求得留数，由于上面的频率归一化
% 为了得到留数只需要还原频率即可
ORe=max(w)*S;% 留数矩阵
