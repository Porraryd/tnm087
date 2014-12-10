clear all
load ('winsuint8.mat');

for n=1:192
    padIm = padarray(winsuint8(:,:,n), [16,16]);
    FFT = fftshift(fft2(padIm));
    
    %Compensate mean intensity shifts dividing with the dc-component.
    FFTA = FFT/abs(FFT(33,33));
    FFTA = abs(FFTA);
    
    N= 64;
    %Create grid in xy plane
    [X,Y] = meshgrid((1:N));

    %Transform from cartesian to polar coordinates (Theta, rho)
    [T,R] = cart2pol(X-N/2,Y-N/2);

    %Scale all values in matris R, such that R(N/2 - 1 , 1) = 1
    SR = R ./ R(N/2 - 1, 1); % ./255
    
    Sharpness(n) = sum(sum(SR.*FFTA));
end
