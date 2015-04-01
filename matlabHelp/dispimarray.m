function fho = dispimarray(imindexarray,figh,medium)
% function dispimarray(imindexarray,figh,medium)
% Display m x n images on the screen.
% imindexarray is m x n array of image indices in the database
% smtype = 'm' or 'M' then medium type else small type
% Example:
%
% mylist= [1 5 19; 2 4 67];
% dispimages(mylist);
%
% March/2007

%%
pathname = 'S:\TN\M\TNM025\2012\ImageDatabase\imdbSMALL\';
%pathname = 'E:\imdb5000\imdbSMALL\';

%%
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
            %pathname = 'E:\imdb5000\imdbMEDIUM\';
        end
end

%%
m=size(imindexarray,1);
n=size(imindexarray,2);
k=0;

for i=1:m
    for j=1:n
        k=k+1;
        subplot(m,n,k);
        fstr = [pathname,num2str(imindexarray(i,j)),'.jpg'];
        I=imread(fstr);
        if size(I,3) < 3
            I = cat(3,I,I,I);
        end
        image(I);
        if(n*m<2)
            truesize;
        end
        axis image;axis off;
        title(num2str(imindexarray(i,j)))
    end
end

%%
if nargout > 0
    fho = fh;
end
return
