% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

function [ images, hist, w, lbphist] = createDatabase(dataBaseSize)

    switch nargin 
        case 0
            dataBaseSize = 1;
    end

    % pre-allocate 
    npim = 100; % 100 images/row
    THUMBNAILS = cell(dataBaseSize,1);
    thumbnailsLAB = cell(dataBaseSize,1);
    
    imTrans = makecform('srgb2lab');

    % read in the number of images
    for imno = 1:dataBaseSize
        imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
        bigImage = imread(imgName);
        labBigImage = applycform(bigImage, imTrans); 
        THUMBNAILS{imno} = mat2cell(bigImage, ones(npim,1)*32, ones(npim,1)*32, 3);
        % create the lab image
        thumbnailsLAB{imno} = mat2cell(labBigImage, ones(npim,1)*32, ones(npim,1)*32, 3);
    end

    % rearange the cell from 100x100 to ex 1x100000 instead. 
    % calculate the histogram and LBP for every image in the database
    THUMBNAILS = vertcat(THUMBNAILS{:});
    thumbnailsLAB = vertcat(thumbnailsLAB{:}); % lab
    HISTOGRAM = cellfun(@calcHist, thumbnailsLAB,'UniformOutput', false);
    
    %imTrans = makecform('srgb2lab');
    %im = applycform(imgIn, imTrans);
    
    LBPHIST = cellfun(@lbp_texture, THUMBNAILS,'UniformOutput', false);

    % calculate w for each image
    [z,zInt] = cellfun(@rgb2cone, THUMBNAILS,'UniformOutput', false);
    w = cellfun(@(x) umean(x(:)), z,'UniformOutput', false);
    v = cellfun(@(x) mean(x(:)), zInt,'UniformOutput', false);
    w = cat(2,vertcat(w{:}), vertcat(v{:}));
    
    % store in right format. 
    images = reshape(THUMBNAILS,1,[]);
    hist = reshape(HISTOGRAM,1,[]);
    lbphist = reshape(LBPHIST,1,[]);

end
