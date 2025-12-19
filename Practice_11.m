%% Hough Transform (without OOTB function)
I = imread('L01 greatvalley.jpg');
I_gray = im2gray(I); % convert to gray
I = imresize(I,0.4); % smaller for computation
I_canny = edge(I_gray,'Canny'); % detect edges
%imshow(I_canny);
[h,w] = size(I_canny); % get height and width of image
diag = round(sqrt(h^2+w^2)); % diagonal
thetas = -90:1:89; % range of thetas
rhos = -diag:1:diag; % range of rho
% create accumulator array
houghs = zeros(length(rhos), length(thetas));
for x=1:w
    for y=1:h
        if I_canny(y,x)~=0
            for th=1:length(thetas)
                t = thetas(th)*pi/180;
                dist = x*cos(t)+y*sin(t); % from origin
                [d,rho] = min(abs(rhos-dist)); % closest rho value
                if d <=1
                    houghs(rho,th) = houghs(rho,th) + 1;
                end
            end
        end
    end
end

figure
imshow(imadjust(rescale(houghs)),'XData',thetas,'YData',rhos,...
   'InitialMagnification','fit');
title('Limited Theta Range Hough Transform of Image');
xlabel('\theta')
ylabel('\rho');
axis on, axis normal; hold on;
plot(x,y,'s','color','green');
colormap(gca,hot)

%% Hough Transforms using hough function

I = imread('L01 greatvalley.jpg');
I = imresize(I,0.4); % smaller for computation
I_gray = im2gray(I); % convert to gray
I_canny = edge(I_gray,'Canny'); % detect edges
numpeaks =25; clear hough;
[hough, theta, rho] = hough(I_canny);

figure % display Hough Transform
imshow(imadjust(rescale(hough)),'XData',theta,'YData',rho,...
   'InitialMagnification','fit');
title('Limited Theta Range Hough Transform of Image');
xlabel('\theta')
ylabel('\rho');
axis on, axis normal;
colormap(gca,hot); 

peaks = houghpeaks(hough, numpeaks);
lines = houghlines(I_gray, theta, rho, peaks, 'FillGap', 5, 'MinLength', 150);
 
figure % display detected edges
imshow(I_gray), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot (xy(:,1),xy(:,2),'Linewidth',1, 'Color', 'r');
end


%% Hough transform function
hough_t('L11_stripes_045.png');
hough_t('L11_stripes_135.png');
hough_t('L11_stripes_hor.png');
hough_t('L11_stripes_ver.png')

function hough_t(img)
    I = imread(img);
    I = imresize(I,0.4); % smaller for computation
    I_gray = im2gray(I); % convert to gray
    I_canny = edge(I_gray,'Canny'); % detect edges
    % numpeaks =25; 
    clear hough;
    [h, theta, rho] = hough(I_canny);
    
    figure % display Hough Transform
    imshow(imadjust(rescale(h)),'XData',theta,'YData',rho,...
       'InitialMagnification','fit');
    title('Limited Theta Range Hough Transform of Image');
    xlabel('\theta')
    ylabel('\rho');
    axis on, axis normal;
    colormap(gca,hot); 
end

