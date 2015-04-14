%% TNM025
% EpicImageProject

% read image
%img = imread('imageDatabase/1.JPG');

%% CLEAR
clear

%% Store image database
imgArray = createDatabase(1,100, @calcMeanIntensity);

%% compare image
clear vector; clear minValue; clear index;

% the image to make mosaic from
imgIn = imread('imageDatabase/676.JPG');

partSize = 30; % will lose part of the image now

imgSize = size(imgIn);

for x=1 : partSize : imgSize(1)-partSize
    for y= 1 : partSize : imgSize(2)-partSize
        xStop = x+partSize;
        yStop = y+partSize;
        
        partImage = imgIn(x:xStop, y:yStop,:);
        figure;
        imshow(partImage);
        
    end
end

% Image to compare with
figure;
imshow(imgIn);

imgInIntens = calcMeanIntensity(imgIn);
vector = abs(cell2mat(imgArray(:, 3)) - imgInIntens*cell2mat(imgArray(:, 2))); %database^2-thisPic*database
[minValue, index] = min(vector); % want to find the min value

%figure;
%imshow(imgArray{index,1}); %show the most similar image! 

