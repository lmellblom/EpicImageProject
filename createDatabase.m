function [ images, hist] = createDatabase(dataBaseSize)

    switch nargin 
        case 0
            dataBaseSize = 1;
    end

    % pre-allocate%
    npim = 100; % 100 images/row

    THUMBNAILS = cell(dataBaseSize,1);  

    for imno = 1:dataBaseSize
        imgName = ['imageDatabaseNew/',num2str(imno), '.jpg']; % image name
        bigImage = imread(imgName);
        THUMBNAILS{imno} = mat2cell(bigImage, ones(npim,1)*32, ones(npim,1)*32, 3);
    end

    % rearange the cell from 100x100 to ex 1x100000 instead. 
    THUMBNAILS = vertcat(THUMBNAILS{:});
    HISTOGRAM = cellfun(@calcHist, THUMBNAILS,'UniformOutput', false);


    images = reshape(THUMBNAILS,1,[]);
    hist = reshape(HISTOGRAM,1,[]);

end
