function [ imgArray ] = createDatabase( nrFrom, nrTo, func )
%CREATEDATABASE Summary of this function goes here
%   Detailed explanation goes here
for n=nrFrom:nrTo
    imgName = ['imagedataBase/',num2str(n), '.JPG'];
    
    % read the image
    image = imread(imgName);
    image = imresize(image, [64,64]); % create a thumbnail, shrinks the image
    
    % store the image in the vector, maybe thumbnail later? 
    imgArray{n, 1} = image;
    
    % Calculate mean intensity value
    meanIntensity = func(image); 
    imgArray{n, 2} = meanIntensity;
    
    % Store square
    imgArray{n, 3} = meanIntensity*meanIntensity;

    %imgArray{n, 4} = calcMeanHue(image);
    
    % Convert to HSV 
    %HSVImg = rgb2hsv(image);
    %hue = HSVImg(:,:,1);
    %saturation = HSVImg(:,:,2);
    %value = HSVImg(:,:,3);
    
    % Create histogram of HSV and store
   % reshapedim=reshape(saturation,[size(saturation,1)*size(saturation,2) 1]);
   % imhistogram=hist(reshapedim, 32)';
   % imhistogram=imhistogram./sum(imhistogram); %Normalization
    
   % imgArray{n, 4} = imhistogram;
    
end

end

