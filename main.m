%% TNM025
% EpicImageProject

% read image
%img = imread('imageDatabase/1.JPG');

%% CLEAR
clear

%% Store image database
imgArray = createDatabase(1,300,  @calcMeanHue);

%% compare image
clear vector; clear minValue; clear index;

% the image to make mosaic from
imgIn = imread('imageDatabase/3123.JPG');
figure;
imshow(imgIn);

partSize = 30; % will lose part of the image now

imgSize = size(imgIn);

for x=1 : partSize : imgSize(1)-partSize
    for y= 1 : partSize : imgSize(2)-partSize
        xStop = x+partSize;
        yStop = y+partSize;
        
        partImage = imgIn(x:xStop, y:yStop,:);
        
        imgInIntens = calcMeanHue(partImage);
        vector = abs(cell2mat(imgArray(:, 3)) - imgInIntens*cell2mat(imgArray(:, 2))); %database^2-thisPic*database
        [~, index] = min(vector); % want to find the min value
        
        img1 = imgArray{index,1};
        img2 = imresize( img1, [partSize+1,partSize+1]);
        
        
        % pic the index value, we want this instead
        similarPic(x:xStop, y:yStop, :) = img2; % the pic that is most similar
        
    end
end

% Image to compare with
figure;
imshow(similarPic);



%figure;
%imshow(imgArray{index,1}); %show the most similar image! 

