function [ out ] = calcMeanIntensity( image )
%CALCMEANINTENSITY Summary of this function goes here
%   Detailed explanation goes here
    out = sum(mean(mean(image)));
end

