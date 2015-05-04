function [ out ] = calcHist( im ) 
% set to 0 and 255 to always get 512 bins, quick fix for now. 
im = uint16(im); 
r = im(:,:,1);
r(1)=0;r(2)=255;
g = im(:,:,2);
g(1)=0;g(2)=255;
b = im(:,:,3);
b(1)=0;b(2)=255;

% 8 bins, 8bits. shift 5. 1 for indexing, matlab start with 1. 
rg=bitshift(bitshift(g,-5),3) + bitshift(b,-5) + 1;
rgb = bitshift(bitshift(r,-5),6) + bitshift(bitshift(g,-5),3) + bitshift(b,-5) + 1;

% to get the histogram right.. http://stackoverflow.com/questions/24097286/rgb-histogram-using-bitshift-in-matlab

%// Make sure these are column vectors
index = rgb(:);
weights = ones(numel(index), 1);

%// Calculate histogram
h = accumarray(index, weights);

out = h/sum(h); %normalize;

%out = out; % transpose the result
end

