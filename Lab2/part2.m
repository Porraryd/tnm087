%Read the image
img = imread('BoldRedEye.JPG');

%Load the circular mask
load ('RedEyeMask.mat');

%Choose and normalize the red channel
redChannel = img(:,:,1);
redChannel = double(redChannel)/255;

%Create a square filter 64x64
filter = double(ones(64));

%Filter with both sqaure and circular filter
MFilterImage = imfilter(redChannel, filter);
EyeFilterImage = imfilter(redChannel, RedEyeMask);

%Calculate the ratio between the resulting images: will give high value
%where eyes may be
ratio = EyeFilterImage./MFilterImage;

newMask = ones(46);

%Find the points where the ratio is close to max 
ratio(ratio < max(ratio(:)) * 0.95)= 0;
M = imregionalmax(ratio);
M = double(M);
MS = imfilter(M, newMask);

%%

%To remove the red from the original image
reversedImg = 1-MS;
image2 = im2double(img);

reversedImg(reversedImg < 1) = 0.1;

image2(:,:,1) = image2(:,:,1).*reversedImg(:,:);

imshow(img)
figure
imshow(image2);

