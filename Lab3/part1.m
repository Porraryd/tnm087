%%
%Read the images

imH = imread('HalfHolga.jpg');
imH = rgb2gray(double(imH)/255);

imS = imread('HalfSony.jpg');
imS = rgb2gray(double(imS)/255);

imC = imread('HalfCanon.jpg');
imC = rgb2gray(double(imC)/255);

imSc = imread('HalfScanner.jpg');
imSc = rgb2gray(double(imSc)/255);

%%
%part 1

%Define a 50x256 window
EdgeCanon = imC(1:50,:);
EdgeHolga = imH(1:50,:);
EdgeSony = imS(1:50,:);
EdgeScanner = imSc(1:50,:);

%Sum the lines together and add zeropadding
SumEdgeCanon = padarray(sum(EdgeCanon), [0 128]);
SumEdgeHolga = padarray(sum(EdgeHolga), [0 128]);
SumEdgeSony = padarray(sum(EdgeSony), [0 128]);
SumEdgeScanner = padarray(sum(EdgeScanner), [0 128]);

%FFT and FFTshift the vectors
FFT1EdgeCanon = fftshift(fft(SumEdgeCanon));
FFT1EdgeHolga = fftshift(fft(SumEdgeHolga));
FFT1EdgeSony = fftshift(fft(SumEdgeSony));
FFT1EdgeScanner = fftshift(fft(SumEdgeScanner));

%Normalize
NFFT1EdgeCanon = FFT1EdgeCanon/FFT1EdgeCanon(256);
NFFT1EdgeHolga = FFT1EdgeHolga/FFT1EdgeHolga(256);
NFFT1EdgeSony = FFT1EdgeSony/FFT1EdgeSony(256);
NFFT1EdgeScanner = FFT1EdgeScanner/FFT1EdgeScanner(256);

%Create a sharpness weight
SharpWeight = zeros ( 1, 512);
for i=1:255
    SharpWeight(256-i) = i/25;
    SharpWeight(257+i) = i/25;
end

%Calculate sharpness
CanonSharp = sum(abs(NFFT1EdgeCanon).*SharpWeight)
HolgaSharp = sum(abs(NFFT1EdgeHolga).*SharpWeight)
SonySharp = sum(abs(NFFT1EdgeSony).*SharpWeight)
ScannerSharp = sum(abs(NFFT1EdgeScanner).*SharpWeight)

%%
%Part 2 
EdgeCanon2 = padarray(imC, [128,128]);
EdgeHolga2 = padarray(imH, [128,128]);
EdgeSony2 = padarray(imS, [128,128]);
EdgeScanner2 = padarray(imSc, [128,128]);

FFT2EdgeCanon = fftshift(fft2(EdgeCanon2));
FFT2EdgeHolga = fftshift(fft2(EdgeHolga2));
FFT2EdgeSony = fftshift(fft2(EdgeSony2));
FFT2EdgeScanner = fftshift(fft2(EdgeScanner2));

FFT2EdgeCanon = FFT2EdgeCanon/abs(FFT2EdgeCanon(256,256));
FFT2EdgeHolga = FFT2EdgeHolga/abs(FFT2EdgeHolga(256,256));
FFT2EdgeSony = FFT2EdgeSony/abs(FFT2EdgeSony(256,256));
FFT2EdgeScanner = FFT2EdgeScanner/abs(FFT2EdgeScanner(256,256));
A = abs(FFT2EdgeScanner);

