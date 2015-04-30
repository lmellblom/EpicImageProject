function [ difference ] = calcDistance(queryFeatureV,featureV, featureVsqrt)
           
    % calculate euclidean distance
    queryFeatureVsqrt = sum(queryFeatureV.^2, 2);
    difference = featureVsqrt - 2*(featureV * queryFeatureV') + queryFeatureVsqrt;
   
end

