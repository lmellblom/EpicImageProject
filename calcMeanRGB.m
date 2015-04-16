function [ out ] = calcMeanRGB( image )
%CALCRGB Summary of this function goes here
%   Detailed explanation goes here

    %out = mean(mean(image));
    %image;
    if (size(image,3) ~=3)
        r = mean(mean(image(:,:,1)));
        g = mean(mean(image(:,:,1)));
        b = mean(mean(image(:,:,1)));
    else
    
    
        r = mean(mean(image(:,:,1)));
        g = mean(mean(image(:,:,2)));
        b = mean(mean(image(:,:,3)));
    end
    
    out = [r g b];


end

