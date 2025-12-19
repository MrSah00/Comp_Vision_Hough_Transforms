%% Circular Hough Transform
clear; clc; close all;
I = imread('L06 sunflower.png'); % reading original image
I_gray = im2gray(I); % converting to grayscale image for edge detection
I_gauss = imgaussfilt(I_gray, 2); % using gaussian filter to remove noise
I_canny = edge(I_gray, 'canny'); % edge detection on grayscale image
I_gauss_canny = edge(I_gauss, 'canny'); % edge detection on smoothened image

% Display circles using original Image as input
hough_CHT(I, 'original', I);
% Display circles using grayscale Image as input
hough_CHT(I_gray, 'grayscale', I_gray);
% Display circles using guassian filtered Image as input
hough_CHT(I_gauss, 'gaussian smoothened', I_gray);
% Display circles using Canny edge-detected Image as input
hough_CHT(I_canny, 'canny edge-detected', I_gray);
% Display circles using Canny edge-detected Gaussian filtered Image as input
hough_CHT(I_gauss_canny, 'gaussian canny edge-detected', I_gray);

function hough_CHT(img, type, disp_img)
    figure;
    imshow(disp_img); hold on;
    % finding circles and their centers using imfindcircles
    [centers, radii] = imfindcircles(img, [15 50], 'ObjectPolarity', 'dark', 'Sensitivity', 0.85);
    viscircles(centers, radii, 'EdgeColor', 'r');
    num = length(centers);
    title(sprintf(['Detected ', num2str(num),' Circles on ', type, ' image']));
    saveas(gcf, [type,'.png']); hold off;
end
