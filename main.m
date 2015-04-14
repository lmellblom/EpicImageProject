%% TNM025
% EpicImageProject

% read image
%img = imread('imageDatabase/1.JPG');

% CLEAR
clear

% Store image database
for n=1:5
    imgName = ['imagedataBase/',num2str(n), '.JPG'];
    
    % read the image
    image = imread(imgName);
    
    % store the image in the vector, maybe thumbnail later? 
    imgArray{n, 1} = image;
    
    % Calculate mean intensity value
    imgArray{n, 2} = sum(mean(mean(imgArray{n,1})));
    
    % Store square
    imgArray{n, 3} = imgArray{n, 2}*imgArray{n, 2};
    
    % Convert to HSV 
    HSVImg = rgb2hsv(image);
    hue = HSVImg(:,:,1);
    saturation = HSVImg(:,:,2);
    value = HSVImg(:,:,3);
    
    % Create histogram of HSV and store
    reshapedim=reshape(saturation,[size(saturation,1)*size(saturation,2) 1]);
    imhistogram=hist(reshapedim, 32)';
    imhistogram=imhistogram./sum(imhistogram); %Normalization
    
    imgArray{n, 4} = imhistogram;
    
end

% Image in
imgIn = imread('imageDatabase/3.JPG');

imgInIntens = sum(mean(mean(imgIn)))

vector = abs(cell2mat(imgArray(:, 3)) - imgInIntens*cell2mat(imgArray(:, 2))); %database^2-thisPic*database
%cell2mat verkar göra om till ints

% Convert to HSV 
HSVImg = rgb2hsv(imgIn);
hue = HSVImg(:,:,1);
saturation = HSVImg(:,:,2);
value = HSVImg(:,:,3);
    
%compare histogram
reshapedim=reshape(saturation,[size(saturation,1)*size(saturation,2) 1]);
imhistogram=hist(reshapedim, 32)';
imhistogram=imhistogram./sum(imhistogram); %Normalization

saturationComp = cell2mat(imgArray(:, 4)); % does not work!!

[min, index] = min(vector) % want to find the min value
%figure;
%imshow(imgArray{2,1});

