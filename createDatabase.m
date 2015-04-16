function [ imgArray ] = createDatabase( nrFrom, nrTo, func )
%CREATEDATABASE Summary of this function goes here
%   Detailed explanation goes here

numberOfPics = nrTo-nrFrom+1;

for n=1:numberOfPics
    position = n + nrFrom - 1;
    imgName = ['imagedataBase/',num2str(position), '.JPG'];
    
    % read the image
    image = imread(imgName);
    image = double(image);
    image = imresize(image, [64,64]); % create a thumbnail, shrinks the image
    
    % store the image in the vector, maybe thumbnail later? 
    imgArray{n, 1} = image;
    
    % Calculate the given function
    mean = func(image); 
    imgArray{n, 2} = mean;
    
    % Store square
    imgArray{n, 3} = mean.*mean;
    
    
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

