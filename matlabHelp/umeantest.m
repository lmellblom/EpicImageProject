clear all
close all
%%
ims = imread('imageDatabaseNew/8.jpg');
ims32 = reshape(ims,32,100,32,100,3);
wmeans = complex(zeros(100,100),zeros(100,100));
for k = 1:100
    for l = 1:100
        im = squeeze(ims32(:,k,:,l,:));
        [z,v] = rgb2cone(im);
        w = umean(z(:),2);
        wmeans(k,l) = w;
    end
end
