function [ eigVectors, featureV, featureVsqrt ] = calcFeatures( histogram )

    %create corrmatrix
    if (iscell(histogram)==1)
        HMAT = cell2mat(histogram); %our histogram matrix from the database
    else
        HMAT = histogram;
    end
        CMat = HMAT * HMAT'; % correleation matrix, changed the way..
    %eigenvalues
    [eigVectors, eigValues] = eigs(CMat, 10); %10 eigenvalues

    % �ndrat negativa tal till positiva
    %eigVectors = sign(eigVectors).*eigVectors;

    %feature vectors
    featureV = HMAT' * eigVectors; %eigVectors �r antalBins*antal egenv�rden
                                   %HMAT �r antal bider * antal bins

    % feature vecor squared
    featureVsqrt = sum(featureV.^2, 2);

end

