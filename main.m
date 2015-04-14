%% TNM025
% EpicImageProject

% read image
%img = imread('imageDatabase/1.JPG');

% CLEAR
clear

% Store image database
for n=1:5
    imgName = ['imagedataBase/',num2str(n), '.JPG'];
    
    imgArray{n, 1} = imread(imgName);
    
    % Calculate mean intensity value
    imgArray{n, 2} = sum(mean(mean(imgArray{n,1})));
    % Store square
    imgArray{n, 3} = imgArray{n, 2}*imgArray{n, 2};
    
    % Create histogram of HSV
    
end

% Image in
imgIn = imread('imageDatabase/3.JPG');

imgInIntens = sum(mean(mean(imgIn)))
imgInIntensSqrt = imgInIntens*imgInIntens;

vector = imgInIntens*cell2mat(imgArray(:, 2));

[max, index] = max(vector)
%figure;
%imshow(imgArray{2,1});

