% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

function [ eigVectors, featureV, featureVsqrt ] = calcFeatures( histogram )

    % create correlation matrix
    if (iscell(histogram)==1)
        HMAT = cell2mat(histogram); % our histogram matrix from the database
    else
        HMAT = histogram;
    end
        CMat = HMAT * HMAT'; 
        
    % get the eigenvalues
    [eigVectors, ~] = eigs(CMat, 5); 

    % feature vectors
    featureV = HMAT' * eigVectors; 

    % feature vecor squared
    featureVsqrt = sum(featureV.^2, 2);

end

