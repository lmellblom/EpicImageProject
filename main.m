%% TNM025
% EpicImageProject

%% CLEAR
clear

%% Store image database, deside how many images
%imgArray = createDatabase(1,200);
[thumbnails, intensity, hue, rgb] = createDatabase(1,5000);

%% Create mosaic from a given image
clear vector; clear minValue; clear index; clear similarPic;

%which function to use
compF = 'RGB';

if (strcmp(compF,'RGB'))
    DBFunction = rgb;
    compareFunction = @calcMeanRGB;
elseif(strcmp(compF,'HUE'))
    DBFunction = hue;
    compareFunction = @calcMeanHue;
else % 'INTENSITY'
    DBFunction = intensity;
    compareFunction = @calcMeanIntensity;
end

% the image to make mosaic from
%imgIn = imread('imageDatabase/780.JPG');
imgIn = imread('http://st.houzz.com/simgs/ad513d560237ce6f_4-9045/traditional-landscape.jpg', 'jpg');
%imgIn = double(imgIn);

figure;
imshow(imgIn);

% how big the small images should be
partSize = 31; % will lose part of the image now

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
        partImageMean = compareFunction(partImage);        
        partImageMean = repmat(partImageMean,length(thumbnails), 1); % for RGB
        
        % database^2-thisPic*database
        difference = calcDistance(partImageMean, DBFunction);
        
        if (strcmp(compF,'RGB'))
            difference = sum(difference'); % gör vi enbart för att vi har RGB-vektor och behöver summera ihop till ett tal. 
        end
        
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