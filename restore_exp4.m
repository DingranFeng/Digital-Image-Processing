function []=restore_exp4( p, card, original )
[par1,par3]=Hough(p);
subplot(2,3,card+3);
imshow(original);
viscircles(par1,par3);
if card==1
    op='roberts����';
elseif card==2
    op='sobel����';
else
    op='laplacian����';
end
title(['�ؽ�ͼ��:',op],'color','k');
end