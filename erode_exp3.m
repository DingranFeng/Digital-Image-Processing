function [ ] = erode_exp3( card,flag,dock3 )
%UNTITLED5 Summary of this function goes here
% Detailed explanation goes here
ele=strel('disk',card,8);
im=imerode(dock3,ele);
subplot(flag,3,(card+1)/2+3);
imshow(im);
title(sprintf('��ʴ: r=%d',card),'color','k');
hold on
end