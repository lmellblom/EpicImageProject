function [ out ] = calcMeanHue( image )
%CALCMEANINTENSITY Summary of this function goes here
%   Detailed explanation goes here
    HSVImg = rgb2hsv(image);
    hue = HSVImg(:,:,1);
    %figure;
    %imshow(hue);
    out = sum(mean(mean(hue)));
    if (out==0)
        out=100000000000000000;
    end
end


