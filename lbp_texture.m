% TNM025
% EpicImageProject, TNM025 2015.
% Anna Flisberg and Linnéa Mellblom
% found this implementation online in a forum. 

function [ LBP_Histograms_8 ] = lbp_texture( Image_RGB )
    I_GRAY = rgb2gray(Image_RGB);

    [xSize, ySize] = size(I_GRAY);
    I_GRAY = padarray(I_GRAY, [1,1]);
    
    I_1 = I_GRAY(1:xSize, 1:ySize) >= I_GRAY(2:xSize+1, 2:ySize+1);
    I_2 = I_GRAY(1:xSize, 2:ySize+1) >= I_GRAY(2:xSize+1, 2:ySize+1);
    I_3 = I_GRAY(1:xSize, 3:ySize+2) >= I_GRAY(2:xSize+1, 2:ySize+1);
    
    I_4 = I_GRAY(2:xSize+1, 3:ySize+2) >= I_GRAY(2:xSize+1, 2:ySize+1);
    
    I_5 = I_GRAY(3:xSize+2, 3:ySize+2) >= I_GRAY(2:xSize+1, 2:ySize+1);
    I_6 = I_GRAY(3:xSize+2, 2:ySize+1) >= I_GRAY(2:xSize+1, 2:ySize+1);
    I_7 = I_GRAY(3:xSize+2, 1:ySize) >= I_GRAY(2:xSize+1, 2:ySize+1);
    
    I_8 = I_GRAY(2:xSize+1, 1:ySize) >= I_GRAY(2:xSize+1, 2:ySize+1);
    
    hood = 64*I_1 + 128*I_2 + 1*I_3 + 2*I_4 + 4*I_5 + 8*I_6 + 16*I_7 + 32*I_8;
    
    LBP_Histograms_8 = hist(hood(:), (0:255));
    LBP_Histograms_8 = LBP_Histograms_8 / (xSize * ySize);
    
    LBP_Histograms_8 = LBP_Histograms_8';
end