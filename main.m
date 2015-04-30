%% TNM025
% EpicImageProject

%% CLEAR
clear

%% Store image database, deside how many images
%imgArray = createDatabase(1,200);
[thumbnails, featureV, eigVectors, featureVsqrt] = createDatabase(1,5000);

%% Create mosaic from a given image
clear vector; clear minValue; clear index; clear similarPic;

% %which function to use
% compF = 'RGB';
% 
% if (strcmp(compF,'RGB'))
%     DBFunction = feature;
%     compareFunction = @calcEigenvalues;
% elseif(strcmp(compF,'HUE'))
%     DBFunction = hue;
%     compareFunction = @calcMeanHue;
% else % 'INTENSITY'
%     DBFunction = intensity;
%     compareFunction = @calcMeanIntensity;
% end
%DBFunction = featureV; % den i databasen vi ska jämföra med. 
%compareFunction = @calcHist;

% the image to make mosaic from
%tiger
imgIn = imread('http://www.liveanimalslist.com/interesting-animals/images/bengal-tiger-gazzing.jpg', 'jpg');
% imgIn = imread('redigeradblomma.jpg');
%imgIn = imread('http://1.bp.blogspot.com/-hgiffCenp-Y/UQfV9YEfQFI/AAAAAAAAhH0/r6k_DmNeTiA/s600/mountains_snow2000.jpg', 'jpg');
%imgIn = double(imgIn);

figure;
imshow(imgIn);

% how big the small images should be
partSize = 5; % will lose part of the image now

imgSize = size(imgIn);

outCoordx = 1;
outCoordy = 1;


%divide the input image in smaller parts
for x=1 : partSize : imgSize(1)-partSize
    for y= 1 : partSize : imgSize(2)-partSize
        % x and y coords in the new image of one part
        xStop = x+partSize;
        yStop = y+partSize;
        partImage = imgIn(x:xStop, y:yStop,:);


        % calculate the functions that is given mean in the image
       % partImageMean = compareFunction(partImage);        
      % partImageMean = repmat(partImageMean,length(thumbnails), 1); % for RGB
       
       queryHist = calcHist(partImage)';
       queryFeatureV = queryHist * eigVectors; %kommer ge 1*antal egenvärden.
       %queryFeatureV = repmat(queryFeatureV,length(thumbnails), 1); % blir antal bilder * antal egenvärden
        
       %difference = abs(queryFeatureV - featureV);
       %difference = sum(difference'); 
       
       queryFeatureVsqrt = sum(queryFeatureV.^2, 2);
       difference = featureVsqrt - 2*(featureV * queryFeatureV') + queryFeatureVsqrt;
      
       % tar skillnaden bara mellan och sen summerar upp... 
       %difference = abs(bsxfun(@minus,queryFeatureV, featureV));
       %difference = sum(difference); 

 
        % database^2-thisPic*database
       % difference = calcDistance(partImageMean, DBFunction);
        
       % if (strcmp(compF,'RGB'))
            %difference = sum(difference'); % gör vi enbart för att vi har RGB-vektor och behöver summera ihop till ett tal. 
        %end
        
        % find the most like image
        [~, index] = min(difference); % want to find the min value

        %while(thumbnails{index,2} <= 0)
        %    difference(index) = [];
        %    [~, index] = min(difference);
        %end
        
        
        % get the thumbnail and resize it to fit. 
        img = thumbnails{index,1};
        %thumbnails{index,2} = thumbnails{index,2} - 1;
       % img = imresize( img, [partSize+1,partSize+1]);
              
        %coords in the new image
        
        % create the mosaic image, replace the incoming image with a
        % database image
        similarPic(outCoordx:outCoordx+size(img,1)-1, outCoordy:outCoordy+size(img,2)-1, :) = img; 
        outCoordy = outCoordy + size(img,2);    
    end
    outCoordx=outCoordx+size(img,1);
    outCoordy = 1;
end

% Show the mosaic image.
figure;
imshow(similarPic);