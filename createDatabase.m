function [ THUMBNAILS, INTENSITY, HUE, RGB ] = createDatabase(nrFrom, nrTo)
numberOfPics = nrTo-nrFrom+1;

% create this many pics
for n=1:numberOfPics
    position = n + nrFrom - 1; % the pics number in the data base
    imgName = ['imagedataBase/',num2str(position), '.JPG'];
    
    % read the image from the database and store
    image = imread(imgName); %image = double(image);
    
    if (size(image,3) ~= 3)
        temp = image(:,:,1);
        image(:,:,2) = temp;
        image(:,:,3) = temp;
    end
   
    image = imresize(image, [64,64]); % create a thumbnail, shrinks the image
    THUMBNAILS{n,1} = image; 
    THUMBNAILS{n,2} = 200;
    
    % calculate intensty and intensity^2
    in = calcMeanIntensity(image);
    INTENSITY{n,1} = in;
    INTENSITY{n,2} = in.*in;

   % calculate hue and hue^2
    in = calcMeanHue(image);
    HUE{n,1} = in;
    HUE{n,2} = in.*in;
    
    % calculate RGB and RGB^2
    in = calcMeanRGB(image);
    RGB{n,1} = in;
    RGB{n,2} = in.*in;

   % Create histogram of HSV and store
   % reshapedim=reshape(saturation,[size(saturation,1)*size(saturation,2) 1]);
   % imhistogram=hist(reshapedim, 32)';
   % imhistogram=imhistogram./sum(imhistogram); %Normalization    
end

end

