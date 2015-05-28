% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom

function [ difference ] = calcL1Distance(v1, v2)  
    % calculate euclidean distance between two vectors. 
    
    V = v1 - v2;
    difference = sqrt(V' * V);
end
