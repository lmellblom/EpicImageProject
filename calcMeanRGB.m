function [ out ] = calcMeanRGB( image )
%CALCRGB Summary of this function goes here
%   Detailed explanation goes here

    % image = rgb2lab(image); %uncomment if use Lab instead

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

