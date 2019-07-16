T = 5;
a = 1;
b = 1;
fig =imread('cameraman.bmp');
subplot(242);
imshow(fig);
title('‘≠Õº');
[numRow,numColumn] = size(fig);
H = zeros(numRow,numColumn);
j=sqrt(-1); % generate the model
for u = 1:numRow
    for v = 1:numColumn
        H(u,v) = T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
figFFT = fft2(fig);
fD = figFFT.*H;
figDegraded = real(ifft2(fD));
figDegraded = uint8(255.*mat2gray(figDegraded));
valPSNR = psnr(fig,figDegraded,8);
subplot(243);
imshow(figDegraded);
title(sprintf('Ωµ÷ ÕºœÒ, PSNR=%.4f dB',valPSNR));
