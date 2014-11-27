%A
%Read in the images 
N = 512;

CWhite1 = imresize(imread('Cwhite1.jpg'), [N N]);
HWhite1 = imresize(imread('HWhite1.jpg'), [N N]);

%Create grid in xy plane
[X,Y] = meshgrid((1:N));

%Transform from cartesian to polar coordinates (Theta, rho)
[T,R] = cart2pol(X-N/2,Y-N/2);

%Plot rho
%plot(R(N/2, :))

%figure
%imshow(R, [])

%%
%B

%Scale all values in matris R, such that R(N/2 - 1 , 1) = 1
SR = R ./ R(N/2 - 1, 1); % ./255

%Quantize to array with values between 1-100
QR = uint8(round(100*(SR./max(SR(:)))));

%Calculate stuff for every m
for m = 1:100  
    %Create mask
    Maskm = (QR == m);
    
    %Pixel values where M is true
    pixelValuesCanon = sum(CWhite1(:,:) .* uint8((Maskm(:,:))));
    pixelValuesHolga = sum(HWhite1(:,:) .* uint8((Maskm(:,:))));
    
    %Sum of the pixels
    pixelSumCanon(m) = sum(pixelValuesCanon);
    pixelSumHolga(m) = sum(pixelValuesHolga);
    
    %Average of the pixel values
    pixelAveCanon(m) = mean(pixelValuesCanon);
    pixelAveHolga(m) = mean(pixelValuesHolga);
    
    %Number of objectpoints in Mask m
    objpoints(m) = sum(sum(Maskm));
    
    
end

%%
plot(pixelAveCanon);

