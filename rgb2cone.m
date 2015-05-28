% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom
% Got this code from Reiner Lenz

function [z,v] = rgb2cone( ima )
%rgb2cone Convert rgb image to conical coordinate system via rgb2hsv
%   

[h,s,v] = rgb2hsv(ima);
v = v(:);
s = s(:);
h = h(:);

if max(s) == 0
    z = complex(inf*ones(size(s)),inf*ones(size(s)));
else
    h = 2*pi*h;
    z = complex(s.*cos(h),s.*sin(h));
end

return
end

