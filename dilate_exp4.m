function [ ] = dilate_exp4( card,flag, dock3 )
%UNTITLED6 Summary of this function goes here
% Detailed explanation goes here
ele=strel('disk',card,8);
im=imdilate(dock3,ele);
if flag~=3
 subplot(flag,3,(card+1)/2+3);
 imshow(im);
 title(sprintf('����: r=%d',card),'color','k');
else
 subplot(flag,3,(card+1)/2+6);
 imshow(im);
 title(sprintf('����: r=%d',card),'color','k');
end
end