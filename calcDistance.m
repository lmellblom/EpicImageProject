% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

function [ difference ] = calcDistance(queryFeatureV,featureV, featureVsqrt)  
    % calculate euclidean distance between two feature vectors. 
    queryFeatureVsqrt = sum(queryFeatureV.^2, 2);
    difference = featureVsqrt - 2*(featureV * queryFeatureV') + queryFeatureVsqrt;
   
end

