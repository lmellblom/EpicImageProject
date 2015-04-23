function [ THUMBNAILS, INTENSITY, HUE, RGB ] = createDatabase(nrFrom, nrTo)
nrFrom = 1;
nrTo = 10000;
numberOfPics = nrTo-nrFrom+1;

npim = 100;
l = 0;
for imno = 1:1
    imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
    bigImage = imread(imgName);
    %ims= uint8(zeros(32,npim,32,npim,3));
    imageReshape = reshape(bigImage, 32,npim,32,npim,3);
    for m = 1:npim %y, rad
        for n = 1:npim %x, kolumn
            l = l+1; %undex for the image. 
            %im = loadTinyImages(l);
            
            % read the small image
            smallImg = imageReshape(:,m,:,n,:);
            smallImg = reshape(smallImg, 32,32,3);
            THUMBNAILS{l,1} = smallImg;
        end
    end
    %jms = reshape(ims,32*npim,32*npim,3);
    %imshow(jms);
end




% create this many pics
for n=1:length(THUMBNAILS) % är antalet bilder som lästs in
   % position = n + nrFrom - 1; % the pics number in the data base
    
    % ladda ned de tio stora bilderna
    %imgName = ['imageDatabaseNew/',num2str(position), '.jpg'];
    
    % read the image from the database and store
    %image = imread(imgName); %image = double(image);
    image = THUMBNAILS{n,1};
    
    if (size(image,3) ~= 3)
        temp = image(:,:,1);
        image(:,:,2) = temp;
        image(:,:,3) = temp;
    end
   
    %image = imresize(image, [64,64]); % create a thumbnail, shrinks the image
    %THUMBNAILS{n,1} = image; 
    %THUMBNAILS{n,2} = 200;
    
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

