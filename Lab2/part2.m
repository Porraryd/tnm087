image = imread('BoldRedEye.JPG');
load ('RedEyeMask.mat');
redChannel = image(:,:,1);
redChannel = double(redChannel)/255;

filter = double(ones(64));

MFilterImage = imfilter(redChannel, filter);
EyeFilterImage = imfilter(redChannel, RedEyeMask);

ratio = EyeFilterImage./MFilterImage;

ratio(ratio < 0.95*max(quantile(ratio, 1))) = 0;
M = imregionalmax(ratio);
M = double(M);
M = imfilter(M, RedEyeMask);

%Q = quantile(ratio);   