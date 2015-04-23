function [ out ] = calcEigenvalues( image )
hist = calcHist(image);
corrMatrix = hist*hist';
ev = eigs(corrMatrix,10);
out=ev';
end

