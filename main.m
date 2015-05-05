%% TNM025
% EpicImageProject

%% CLEAR
clear

%% Store image database, deside how many images
tic
[thumbnails, histograms, featureW] = createDatabase(1);
[eigVectors, featureV, featureVsqrt] = calcFeatures(histograms);
toc
%% create the w component for each of the images.

%% Create mosaic from a given image
tic
clear vector; clear minValue; clear index; clear similarPic;

% the image to make mosaic from
%tiger
%imgIn = imread('http://www.liveanimalslist.com/interesting-animals/images/bengal-tiger-gazzing.jpg', 'jpg');
%imgIn = imread( 'http://www.freevector.com/site_media/preview_images/FreeVector-Square-Patterns-Set.jpg','jpg');
%imgIn = imread('http://a-z-animals.com/media/animals/images/original/guinea_pig1.jpg', 'jpg');
imgIn = imread('http://cdn.cutestpaw.com/wp-content/uploads/2013/04/l-Guinea-pig-with-a-pepper-hat..jpg', 'jpg');
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

% calculate w for the query image
[z,~] = cellfun(@rgb2cone, imgTest,'UniformOutput', false);
queryFeatureW = cellfun(@(x) umean(x(:)), z,'UniformOutput', false);

% calculate the difference and also the index for each image to get
difference = cellfun(@(x) calcDistance(x, featureV, featureVsqrt), queryFeatureV,'UniformOutput', false);
[~,index] = cellfun(@min, difference,'UniformOutput', false);

% calc difference in w
diffW = cellfun(@(x) HypDist(x,featureW),queryFeatureW ,'UniformOutput', false);
[~,indexW] = cellfun(@min, diffW,'UniformOutput', false);

% Leker lite
% a = procent RGB
a = 1;
newDiff = cellfun(@(x, y) a*x + (1-a)*y, difference, diffW, 'UniformOutput', false);
[~,indexNew] = cellfun(@min, newDiff,'UniformOutput', false);

% get the thumbnail in each position. 
similarPic = cellfun(@(x) thumbnails{1,x}, index, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPic = cell2mat(similarPic);

% for the w component
similarPicW = cellfun(@(x) thumbnails{1,x}, indexW, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPicW = cell2mat(similarPicW);

% for the weighted component
similarPicNew = cellfun(@(x) thumbnails{1,x}, indexNew, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPicNew = cell2mat(similarPicNew);


%figure;
%imshow(similarPic);
%figure;
%imshow(similarPicW);
figure;
imshow(similarPicNew);
toc