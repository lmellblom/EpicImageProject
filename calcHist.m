% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

function [ out ] = calcHist(im) 
    
    % if you left of which feature, it will make it to LAB, else use RGB
%     switch nargin
%     case 2
%         if(feature == 'lab')
%             imTrans = makecform('srgb2lab');
%             im = applycform(im, imTrans);
%         end
%     otherwise
%         imTrans = makecform('srgb2lab');
%         im = applycform(im, imTrans);
%     end
    
    % set to 0 and 255 to always get right number of bins
    im = uint16(im); 
    r = im(:,:,1);
    r(1)=0;r(2)=255;
    g = im(:,:,2);
    g(1)=0;g(2)=255;
    b = im(:,:,3);
    b(1)=0;b(2)=255;

    % 8 bins, 8bits. shift 5. 1 for indexing, matlab start with 1. 
    rgb = bitshift(bitshift(r,-5),6) + bitshift(bitshift(g,-5),3) + bitshift(b,-5) + 1;

    % Make sure these are column vectors
    index = rgb(:);
    weights = ones(numel(index), 1);

    % Calculate histogram
    h = accumarray(index, weights);

    out = h/sum(h); %normalize with number of pixels in the image;

end

