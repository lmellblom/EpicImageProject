%% TNM025
% EpicImageProject

%% CLEAR
clear

%% Store image database, deside how many images
tic
[thumbnails, histograms, lbphist] = createDatabase(10);
[eigVectors, featureV, featureVsqrt] = calcFeatures(histograms);
[lbpeigVectors, lbpfeatureV, lbpfeatureVsqrt] = calcFeatures(lbphist);

toc

% behöver inte dessa längre i koden. 
clear histograms;
clear lbphist;
%% create the w component for each of the images.

%% Create mosaic from a given image
tic
clear vector; clear minValue; clear index; clear similarPic;

warnStruct = warning('off','optim:fminunc:SwitchingMethod');
warnStruct = warning('off','images:initSize:adjustingMag');
% the image to make mosaic from
% tiger
%imgIn = imread('http://media1.santabanta.com/full1/Animals/Tigers/tigers-40a.jpg', 'jpg');
% freeman
%imgIn = imread( 'http://www.cbc.ca/strombo/content/images/Morgan-Freeman-The-Hour.jpg','jpg');
% guinea pig
%imgIn = imread('http://cdn.cutestpaw.com/wp-content/uploads/2013/04/l-Guinea-pig-with-a-pepper-hat..jpg', 'jpg');
% mountain
%imgIn = imread('http://1.bp.blogspot.com/-hgiffCenp-Y/UQfV9YEfQFI/AAAAAAAAhH0/r6k_DmNeTiA/s600/mountains_snow2000.jpg', 'jpg');
% dolphins
imgIn = imread('http://images4.alphacoders.com/249/249578.jpg', 'jpg');
% red house
%imgIn = imread('http://ad009cdnb.archdaily.net/wp-content/uploads/2011/03/1300470451-dscf9116.jpg', 'jpg');


%figure;
%imshow(imgIn);

% how big the small images should be

imgSize = size(imgIn);
minSize = min(imgSize(1), imgSize(2));
% antal bilder i min(x-led,y-led)
nrOfImg = 40;
partSize = floor(minSize/nrOfImg);

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

% lbptexture for query images
queryLBP = cellfun(@lbp_texture, imgTest ,'UniformOutput', false);
% calculate the query image
LBPqueryFeatureV = cellfun(@(x) x' * lbpeigVectors, queryLBP, 'UniformOutput', false);

% calculate w for the query image
%[z,~] = cellfun(@rgb2cone, imgTest,'UniformOutput', false);
%queryFeatureW = cellfun(@(x) umean(x(:)), z,'UniformOutput', false);

% calculate the difference and also the index for each image to get
difference = cellfun(@(x) calcDistance(x, featureV, featureVsqrt), queryFeatureV,'UniformOutput', false);
difference = cellfun(@(x) x/max(x), difference,'UniformOutput', false);

% LBP calculate the difference and also the index for each image to get
differenceLBP = cellfun(@(x) calcDistance(x, lbpfeatureV, lbpfeatureVsqrt), LBPqueryFeatureV,'UniformOutput', false);
differenceLBP = cellfun(@(x) x/max(x), differenceLBP,'UniformOutput', false);

% calc difference in w
%diffW = cellfun(@(x) HypDist(x,featureW),queryFeatureW ,'UniformOutput', false);
%diffW = cellfun(@(x) x/max(x), diffW,'UniformOutput', false);

% Leker lite
% a = procent hist
a = 1;
% b = procent w
b = 1-a;
% c = procent lbp
%c = 1-a-b;

newDiff = cellfun(@(x, y, z) a*x + b*y, difference, differenceLBP, 'UniformOutput', false);
[~,indexNew] = cellfun(@min, newDiff,'UniformOutput', false);

% for the weighted component
similarPicNew = cellfun(@(x) thumbnails{1,x}, indexNew, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPicNew = cell2mat(similarPicNew);

toc

%calc difference
imgHist = calcHist(imgIn,'rgb');
imgHistNew = calcHist(similarPicNew, 'rgb');
diff = sum(sum(pdist2(imgHist',imgHistNew', 'chisq')))

%show images, scale the original image up
scaleUp = size(similarPicNew,1)/size(imgIn,1);
imgIn = imresize(imgIn, scaleUp);

figure;
h = imshowpair(imgIn,similarPicNew, 'montage');
