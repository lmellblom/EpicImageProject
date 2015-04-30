function [ THUMBNAILS, featureV, eigVectors, featureVsqrt] = createDatabase(dataBaseSize)

switch nargin 
    case 0
        dataBaseSize = 1;
end

npim = 100; % 100 images/row
l = 0; % index for image
for imno = 1:dataBaseSize
    imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
    bigImage = imread(imgName);
    imageReshape = reshape(bigImage, 32,npim,32,npim,3);
    for m = 1:npim %y, rad
        for n = 1:npim %x, kolumn
            l = l+1; % index for the image. 
              
            % read the small image
            smallImg = imageReshape(:,m,:,n,:);
            smallImg = reshape(smallImg, 32,32,3);
            THUMBNAILS{l,1} = smallImg;
            
            HIST{l,1} = calcHist(smallImg)';  % orietering på vektor lite oklar.. 
        end
    end
end

%create corrmatrix
HMAT = cell2mat(HIST(:,1)); %our histogram matrix from the database
CMat = HMAT' * HMAT; % correleation matrix
%eigenvalues
[eigVectors, eigValues] = eigs(CMat, 10); %10 eigenvalues

% ändrat negativa tal till positiva
%evec = sign(eigVectors).*eigVectors;

%feature vectors
featureV = HMAT * eigVectors; %eigValues är antalBins*antal egenvärden
                               %HMAT är antal bider * antal bins
                               
% feature vecor squared
featureVsqrt = sum(featureV.^2, 2);
end
