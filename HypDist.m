function d = HypDist( z,w )
    %HYPDIST: d = HypDist( z,w )
    %   Hyperbolic or Lobachevsky distance between z and w
    %   z, w are complex in the unit disk
    if (iscell(w) == 1)
        w = cell2mat(w);
    end
    if (iscell(z) == 1)
        z = cell2mat(z);
    end

    d = real(2*atanh(abs((z-w)./(1-conj(z).*w))));
    return
end
