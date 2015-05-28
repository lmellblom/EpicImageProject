%% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

%% CLEAR everything
clear

%% Build up the database, calculate all the features

nrOfImages = 10; % 1 - 10. 1 images hold 10 000 pictures. 

tic
[thumbnails, histograms, featureW, lbphist] = createDatabase(nrOfImages);
[eigVectors, featureV, featureVsqrt] = calcFeatures(histograms);
[lbpeigVectors, lbpfeatureV, lbpfeatureVsqrt] = calcFeatures(lbphist);
toc

% clear some variables that we dont need any more
clear histograms;
clear lbphist;

%% Create mosaic from a given image, only do this when you want to do a new image when the database is already loaded. 
clear vector; clear minValue; clear index; clear similarPic;

% just clear warnings
warnStruct = warning('off','optim:fminunc:SwitchingMethod');
warnStruct = warning('off','images:initSize:adjustingMag');

% ==== the image to make mosaic from, some test images here ====
% tiger
%imgIn = imread('http://www.liveanimalslist.com/interesting-animals/images/bengal-tiger-gazzing.jpg', 'jpg');
%imgIn = imread('http://www.traffic.org/storage/images/tiger-vivek-sinha-wwf-canon.jpg', 'jpg');
%imgIn = imread( 'http://www.freevector.com/site_media/preview_images/FreeVector-Square-Patterns-Set.jpg','jpg');
% black&white
%imgIn = imread('https://s-media-cache-ak0.pinimg.com/originals/26/eb/32/26eb3228c89f4689afb9671540af5dac.jpg', 'jpg');
% circle
%imgIn = imread('https://www.colourbox.com/preview/6989137-stone-blocks-pavement-texture-for-background.jpg', 'jpg');
%imgIn = imread('http://cdn.cutestpaw.com/wp-content/uploads/2013/04/l-Guinea-pig-with-a-pepper-hat..jpg', 'jpg');
% mountain
%imgIn = imread('http://1.bp.blogspot.com/-hgiffCenp-Y/UQfV9YEfQFI/AAAAAAAAhH0/r6k_DmNeTiA/s600/mountains_snow2000.jpg', 'jpg');
imgIn = imread('http://www.davidpaulkirkpatrick.com/wp-content/uploads/2013/03/van-Gogh-Self-Potrait_1889_1890.jpg', 'jpg');
tic

% how big the small images should be
imgSize = size(imgIn);
minSize = min(imgSize(1), imgSize(2));

% nr of images in the min of x and y.
nrOfImg = 60;
partSize = floor(minSize/nrOfImg);

% need to remove pixels in order to get an even number
sX = mod(imgSize(1),partSize);
sY = mod(imgSize(2),partSize);

% shrink the image to be exactly the size of the parts..
imgIn = imgIn(1:imgSize(1)-sX,1:imgSize(2)-sY,:);
imgSize = size(imgIn); % the new size

% divide each image in a own cell. 
imgTest =  mat2cell(imgIn, ones(imgSize(1)/partSize,1)*partSize, ones(imgSize(2)/partSize,1)*partSize, 3);

% convert to LAB
imTrans = makecform('srgb2lab');
im = applycform(imgIn, imTrans);
imgTest2 =  mat2cell(im, ones(imgSize(1)/partSize,1)*partSize, ones(imgSize(2)/partSize,1)*partSize, 3);

% histogram for query images
queryHist = cellfun(@calcHist, imgTest2 ,'UniformOutput', false);
% calculate the query image
queryFeatureV = cellfun(@(x) x' * eigVectors, queryHist, 'UniformOutput', false);

% lbptexture for query images
queryLBP = cellfun(@lbp_texture, imgTest ,'UniformOutput', false);
% calculate the query image
LBPqueryFeatureV = cellfun(@(x) x' * lbpeigVectors, queryLBP, 'UniformOutput', false);

% calculate w for the query image
[z,zint] = cellfun(@rgb2cone, imgTest,'UniformOutput', false);
queryFeatureW0 = cellfun(@(x) umean(x(:)), z,'UniformOutput', false);
queryFeatureV0 = cellfun(@(x) mean(x(:)), zint,'UniformOutput', false);
queryFeatureW = cat(2,vertcat(queryFeatureW0{:}),vertcat(queryFeatureV0{:}));

% LAB calculate the difference and also the index for each image to get
difference = cellfun(@(x) calcDistance(x, featureV, featureVsqrt), queryFeatureV,'UniformOutput', false);
difference = cellfun(@(x) x/max(x), difference,'UniformOutput', false);

% LBP calculate the difference and also the index for each image to get
differenceLBP = cellfun(@(x) calcDistance(x, lbpfeatureV, lbpfeatureVsqrt), LBPqueryFeatureV,'UniformOutput', false);
differenceLBP = cellfun(@(x) x/max(x), differenceLBP,'UniformOutput', false);

% calc difference in w
featureWC = squeeze(featureW(:,1));
diffW = cellfun(@(x) HypDist(x,featureWC),queryFeatureW0 ,'UniformOutput', false);
diffW = cellfun(@(x) x/max(x), diffW,'UniformOutput', false);

% calc difference in v
featureWV = squeeze(featureW(:,2));
diffV = cellfun(@(x) calcL1Distance(x,featureWV),queryFeatureV0 ,'UniformOutput', false);
diffV = cellfun(@(x) x/max(x), diffV,'UniformOutput', false);

% Weight function
% a = procent CIELAB
a = 0.75;
% b = procent w
b = 0.12;
% c = procent value
c = 0;
% d = lbp
d = 1-a-b-c;

%a=0;b=0.2;c=.7;d=1-a-b-c;
newDiff = cellfun(@(x, y, u, v) a*x + b*y + c*u +d*v, difference, diffW, diffV, differenceLBP, 'UniformOutput', false);

%newDiff = cellfun(@(x, y, z) a*x + b*y + c*z, difference, diffW, differenceLBP, 'UniformOutput', false);
[~,indexNew] = cellfun(@min, newDiff,'UniformOutput', false);

% for the weighted component
similarPicNew = cellfun(@(x) thumbnails{1,x}, indexNew, 'UniformOutput', false); %råkat flippa mot förut hur cellen ligger...
similarPicNew = cell2mat(similarPicNew);

toc
%% Show the mosaic image
% Also using rgb histogram to compare the new image with the in image.
% Only for testing and see how good the result was. 

% calc difference
imgHist = calcHist(imgIn);
imgHistNew = calcHist(similarPicNew);
diff = sum(sum(pdist2(imgHist',imgHistNew', 'chisq')))

% show images, scale the original image up
scaleUp = size(similarPicNew,1)/size(imgIn,1);
imgIn = imresize(imgIn, scaleUp);

figure;
h = imshowpair(imgIn,similarPicNew, 'montage');
