img = imread('BoldRedEye.JPG');
load ('RedEyeMask.mat');
redChannel = img(:,:,1);
redChannel = double(redChannel)/255;

filter = double(ones(64));

MFilterImage = imfilter(redChannel, filter);
EyeFilterImage = imfilter(redChannel, RedEyeMask);

ratio = EyeFilterImage./MFilterImage;

newMask = ones(46);

ratio(ratio < max(ratio(:)) - 0.01)= 0;
M = imregionalmax(ratio);
M = double(M);
M = imfilter(M, newMask);

%%

%To remove the red from the original image
reversedImg = 1-M;
image2 = im2double(img);

reversedImg(reversedImg < 1) = 0.1;

image2(:,:,1) = image2(:,:,1).*reversedImg(:,:);

imshow(img)
figure
imshow(image2);

