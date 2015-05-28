% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom
% Got this code from Reiner Lenz. 

function d = SumHypDist(w,z,p )
%SumHYPDIST: d = HypDist( z,w,p )
%   p-norm Hyperbolic or Lobachevsky distance between z and w
%   z, w are complex in the unit disk

switch nargin 
    case 3
    case 2
        p = 2;
    case 1
        w = z(1);
        z = z(2:end);
    otherwise
        error('One or two input arguments')
end

d = real(2*atanh(abs((z-w)./(1-conj(z).*w))));
if p > 0
    d = (sum(d.^p))^(1/p);
else
    d = max(d);
    endc

return
end
