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
    pixelValuesCanon = CWhite1(:,:) .* uint8((Maskm(:,:)));
    pixelValuesHolga = HWhite1(:,:) .* uint8((Maskm(:,:)));
    
    %Sum of the pixels
    pixelSumCanon(m) = sum(sum(pixelValuesCanon));
    pixelSumHolga(m) = sum(sum(pixelValuesHolga));
    
    %Number of objectpoints in Mask m
    objpoints = sum(sum(Maskm));
    
    %Average of the pixel values
    pixelAveCanon(m) = sum(sum(pixelValuesCanon))/objpoints;
    pixelAveHolga(m) = sum(sum(pixelValuesHolga))/objpoints;
    
    %normPixelAveCanon(m) = pixelAveCanon(m)/max(pixelAveCanon(:))
   
end

normPixelAveCanon = pixelAveCanon / max(pixelAveCanon(:));
normPixelAveHolga = pixelAveHolga / max(pixelAveHolga(:));

%%
plot(pixelAveCanon);
hold on
plot(pixelAveHolga);

figure

plot(normPixelAveCanon);
hold on
plot(normPixelAveHolga);

