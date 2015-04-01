function [ret, fighandle]=dispclick(imindexarray,figh,medium)
% function [fh,ret]=dispclick(imindexarray,figh,medium)
% Display m x n images on the screen.
% imindexarray is m x n array of image indices in the database.
% medium = 'm' or 'M' then medium type else small type
% 
% Example:
%
% mylist= [1 5 19; 2 4 67];
% dispclick(imindexarray,figh,medium)
%
% March/2007

thumbsize=120;
nout = nargout;

pathname = 'S:\TN\M\TNM025\2012\ImageDatabase\imdbSMALL\';
%pathname = 'E:\imdb5000\imdbSMALL\';

switch nargin
    case 1
        fh = figure;
    case 2
        fh = figh;
    case 3
        if isempty(figh)
            fh = figure;
        else
            fh = figh;
        end
        if strcmp('m',lower(medium(1)))
            pathname = 'S:\TN\M\TNM025\2012\ImageDatabase\imdbMEDIUM\';
%            pathname = 'E:\imdb5000\imdbMEDIUM\';
        end
end


if nargin <1
    m=4; n=5;
    imindexarray=floor(4999*rand(m,n))+1;
    fh = figure;
end

m=size(imindexarray,1);
n=size(imindexarray,2);

k=0;
for i=1:n
    for j1=m:-1:1
        j = m-j1+1;
        k=k+1;
        % h(k)=subplot(n,m,k);
        ino(k) = imindexarray(j1,i);
        h(k)=subplot('position',[(i-1)/n (j-1)/m 1/n-0.05 1/m-0.05]);
        fstr = [pathname,num2str(imindexarray(j1,i)),'.jpg'];
        I=imread(fstr);
        I=imresize(I,thumbsize/max(size(I,1),size(I,2)));
        image(I); axis image; axis off;
        title([num2str(imindexarray(j1,i))]);
    end
end

figure(fh);
if (nout > 0)
% Wait for a mouse click and return the image index of selected image.
    kk = waitforbuttonpress;
    point1 = get(gcf);
    point1.CurrentAxes;
    ret=ino(find(h==point1.CurrentAxes));
    if (nout > 1)
        fighandle = fh;
    end
end
if nargout > 1
    fighandle=fh;
end
return
