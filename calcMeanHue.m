function [ out ] = calcMeanHue( image )
%CALCMEANINTENSITY Summary of this function goes here
%   Detailed explanation goes here
if(size(size(image),2) ==2) % if a image is grayscale, no hue!
    out = 0;
else
    HSVImg = rgb2hsv(image);
    hue = HSVImg(:,:,1);
    out = sum(mean(mean(hue)));
end
end


