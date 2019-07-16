function [ ] = wiener_filter( card, ki, W_k, Q0, lena )
Q_k=Q0.*W_k;
q_k=real(ifft2(Q_k));
peaksnr=psnr(lena,uint8(q_k),8); % PSNR
subplot(2,4,card+2);
imshow(uint8(255.*mat2gray(q_k)));
title(sprintf('lg(K) = %.1f , PSNR=%.4f dB',log(ki)/log(10),peaksnr));
end