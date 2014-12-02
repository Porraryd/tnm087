Cim = imread('GCPins512.jpg');
Him = imread('GHPins512.jpg');
imshow(Cim);
hold on;

M = 4
[CX, CY] = ginput(M)
hold off
imshow(Him);
hold on;

[HX, HY] = ginput(M)

CC = [CX CY ones(M,1)];

HC = [HX HY ones(M,1)];

%%
A = CC\HC;
A(1,3) = 0;
A(2,3) = 0;
A(3,3) = 1;
A = affine2d(A);

warpedImage = imwarp(Cim, A, 'OutputView', imref2d(size(Cim)));
fusedImage = uint8(zeros(500, 512, 3));
fusedImage(:,:,1) = warpedImage(:,:);
fusedImage(:,:,2) = Him(:,:);
fusedImage(:,:,3) = 0;


imshow(fusedImage);
