%% TNM025
% EpicImageProject

%% CLEAR
clear

%% Store image database, deside how many images
[thumbnails, histograms] = createDatabase(10);
%histograms = histograms';
%thumbnails = thumbnails';
%%
[eigVectors, featureV, featureVsqrt] = calcFeatures(histograms);

%% create the w component for each of the images.


%% Create mosaic from a given image
clear vector; clear minValue; clear index; clear similarPic;

% the image to make mosaic from
%tiger
%imgIn = imread('http://www.liveanimalslist.com/interesting-animals/images/bengal-tiger-gazzing.jpg', 'jpg');
imgIn = imread('http://www.freevector.com/site_media/preview_images/FreeVector-Square-Patterns-Set.jpg','jpg');
%imgIn = imread('http://1.bp.blogspot.com/-hgiffCenp-Y/UQfV9YEfQFI/AAAAAAAAhH0/r6k_DmNeTiA/s600/mountains_snow2000.jpg', 'jpg');

figure;
imshow(imgIn);

% how big the small images should be
partSize = 15;
imgSize = size(imgIn);

% behöver ta bort såhär många pixlar i regionen. 
sX = mod(imgSize(1),partSize);
sY = mod(imgSize(2),partSize);

%shrink the image to be exactly the size of the parts..
imgIn = imgIn(1:imgSize(1)-sX,1:imgSize(2)-sY,:);
imgSize = size(imgIn); % the new size

% divide each image in a own cell. 
imgTest =  mat2cell(imgIn, ones(imgSize(1)/partSize,1)*partSize, ones(imgSize(2)/partSize,1)*partSize, 3);

% histogram for query images
queryHist = cellfun(@calcHist, imgTest ,'UniformOutput', false);
% calculate the query image
queryFeatureV = cellfun(@(x) x' * eigVectors, queryHist, 'UniformOutput', false);

% calculate the difference and also the index for each image to get
difference = cellfun(@(x) calcDistance(x, featureV, featureVsqrt), queryFeatureV,'UniformOutput', false);
[~,index] = cellfun(@min, difference,'UniformOutput', false);

% get the thumbnail in each position. 
similarPic = cellfun(@(x) thumbnails{1,x}, index, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPic = cell2mat(similarPic);

figure;
imshow(similarPic);



%% old code
%[eigVectors, queryFeatureV, featureVsqrt] = calcFeatures(histograms);

% ceate histigram for query image
%        queryHist = calcHist(partImage)';
%        queryFeatureV = queryHist * eigVectors; %kommer ge 1*antal egenvärden.



%imgSize = size(imgIn);
% 
% outCoordx = 1;
% outCoordy = 1;
% %divide the input image in smaller parts
% for x=1 : partSize : imgSize(1)-partSize
%     for y= 1 : partSize : imgSize(2)-partSize
%         % x and y coords in the new image of one part
%         xStop = x+partSize;
%         yStop = y+partSize;
%         partImage = imgIn(x:xStop, y:yStop,:);
% 
%         % ceate histigram for query image
%        queryHist = calcHist(partImage)';
%        queryFeatureV = queryHist * eigVectors; %kommer ge 1*antal egenvärden.
%        
%        % calculate euclidean distance        
%        difference = calcDistance(queryFeatureV, featureV, featureVsqrt);
%        % calculate euclidean distance
%    
%         % find the most like image
%         [~, index] = min(difference); % want to find the min value
% 
%         % restriction in how many times an image can be used
%         % !TODO needs to be implemented in database or main
%         %while(thumbnails{index,2} <= 0)
%         %    difference(index) = [];
%         %    [~, index] = min(difference);
%         %end
%         
%         
%         % get the thumbnail 
%         img = thumbnails{index,1};
%         % for restriction
%         %thumbnails{index,2} = thumbnails{index,2} - 1;
% 
%         
%         % create the mosaic image, replace the incoming image with a database image
%         similarPic(outCoordx:outCoordx+size(img,1)-1, outCoordy:outCoordy+size(img,2)-1, :) = img; 
%         outCoordy = outCoordy + size(img,2);    
%     end
%     outCoordx=outCoordx+size(img,1);
%     outCoordy = 1;
% end
% 
% Show the mosaic image.
% figure;
% imshow(similarPic);