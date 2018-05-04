% Savitzky-Golay filter
%滤波，N取3，F取值需要为奇数
%调用格式为H = SG_filter(H(:), N_SG, F_SG);
function[SG] = SG_filter(FRF, N, F)
% 'N' is the order of polynomial fit 拟合多项式阶数
% 'F' is the window length 窗的长度
[~,g] = sgolay(N,F);   % Calculate S-G coefficients 计算S—G系数

HalfWin  = ((F+1)/2) -1;
SG = zeros(size(FRF));
for n = (F+1)/2:length(FRF)-(F+1)/2
  % Zero-th derivative (smoothing only)对本数据进行平滑，不涉及其微分的滤波
  SG(n) =   dot(g(:,1), FRF(n - HalfWin: n + HalfWin));
end