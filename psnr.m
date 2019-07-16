function PSNR = psnr( figure1,figure2,bit)
figure1 = double(figure1);
figure2 = double(figure2);
MAX = 2^bit-1; % 图像灰度级数量
PMSE=sum(sum((figure1-figure2).^2))/(size(figure1,1)*size(figure1,2))/MAX^2; % 均方差
PSNR=-10*log10(PMSE); % 峰值信噪比
end