function [ images, hist] = createDatabase(dataBaseSize)

switch nargin 
    case 0
        dataBaseSize = 1;
end

% pre-allocate%
npim = 100; % 100 images/row

THUMBNAILS = cell(dataBaseSize,1); 
%HISTOGRAM = cell(npim,npim); 

for imno = 1:dataBaseSize
    imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
    bigImage = imread(imgName);
    THUMBNAILS{imno} = mat2cell(bigImage, ones(npim,1)*32, ones(npim,1)*32, 3);
end

% rearange the cell from 100x100 to ex 1x100000 instead. 
THUMBNAILS = vertcat(THUMBNAILS{:});
HISTOGRAM = cellfun(@calcHist, THUMBNAILS,'UniformOutput', false);


images = reshape(THUMBNAILS,1,[]);
hist = reshape(HISTOGRAM,1,[]);

% npim = 100; % 100 images/row
% l = 0; % index for image
% for imno = 1:dataBaseSize
%     imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
%     bigImage = imread(imgName);
%     imageReshape = reshape(bigImage, 32,npim,32,npim,3);
%     for m = 1:npim %y, rad
%         for n = 1:npim %x, kolumn
%             l = l+1; % index for the image. 
%               
%             % read the small image
%             smallImg = imageReshape(:,m,:,n,:);
%             smallImg = reshape(smallImg, 32,32,3);
%             THUMBNAILS{l,1} = smallImg;
%                          
%             % calculate the histogram for RGB
%             %HISTOGRAM{l,1} = calcHist(smallImg);  % orietering på vektor lite oklar.. 
%         end
%     end
% end

% apply for each cell, the calcHist function
%HISTOGRAM = cellfun(@calcHist, THUMBNAILS,'UniformOutput', false);

end
