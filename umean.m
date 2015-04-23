function w = umean(z0,p0)
%umean mean of unit disk points
%   Detailed explanation goes here
persistent opts;

if isempty(opts) 
    opts = optimset;
    opts.Display = 'off';
end

if sum(isinf(z0))>0
    w = complex(inf,inf);
else
    z = 0.99*z0;
    if nargin < 2
        p = 2;
    else
        p = p0;
    end
    f = @(w)SumHypDist(w,z,p);
    
    x = rand(3,1);
    w0 = x(1)*complex(x(2),x(3));
    [w,fval] = fminunc(f,w0,opts);
end
return
end

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
end

return
end
