function [ out ] = calcHist( im ) 
%First reshape to one column
%reshapedim=reshape(im(:,:,2),[size(im,1)*size(im,2) 1]);
%imhistogram=hist(reshapedim,[0:1:255])';
%imhistogram=imhistogram./sum(imhistogram); %Normalization
%out = imhistogram;
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

% 8 bins, 8bits. shift 5. 1 for indexing, matlab start with 1. 
rg=bitshift(bitshift(g,-5),3) + bitshift(b,-5) + 1;
rgb = bitshift(bitshift(r,-5),6) + bitshift(bitshift(g,-5),3) + bitshift(b,-5) + 1

max(max(rgb))


% to get the histogram right.. http://stackoverflow.com/questions/24097286/rgb-histogram-using-bitshift-in-matlab

%// Make sure these are column vectors
index = rgb(:);
weights = ones(numel(index), 1);
numel(index)

%// Calculate histogram
h = accumarray(index, weights);

out = h/sum(h); %normalize;
end

