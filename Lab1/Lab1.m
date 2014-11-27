%%
load ('gfun.mat');
plot (gfun);
figure();
plot (2.^gfun);

%test commit

%%
%Read the images
for i=1:14
    adress = strcat('img', num2str(i), '.tiff');
    images(:,:,:,i) = imread(adress);
    imagesgray(:,:,i) = rgb2gray(images(:,:,:,i));
end

%Find the x and y of the max intensity of the first image
[maxVal ind] = max(max(imagesgray(:,:,1)));
[x y] = ind2sub(size(imagesgray(:,:,1)), ind);
maxPos = [x y];

%Find the x and y of the min intensity of the last image
[minVal ind] = min(min(imagesgray(:,:,14)));
[x y] = ind2sub(size(imagesgray(:,:,14)), ind);
minPos = [x y];

%Find median value of image 9
I = find(imagesgray(:,:,9) == 128);
[x y] = ind2sub(size(imagesgray(:,:,9)), I);
medianPos =[x(2), y(2)];

maxValues = zeros(14,1);
minValues = zeros(14,1);
medianValues = zeros(14,1);
for i=1:14
    maxValues(i) = imagesgray(maxPos(1),maxPos(2),i);
    minValues(i) = imagesgray(minPos(1),minPos(2),i);
    medianValues(i) = imagesgray(medianPos(1),medianPos(2),i);
end

plot(maxValues)
hold on
plot(minValues)
plot(medianValues)

%%
%tj
t = zeros(14,1);
t(1) = 10;
for i=2:14
    t(i)= t(i-1) * 2;
end

E = double(images);
ffun = 2.^gfun;
for n=1:14
    intensity = images(:,:,:,n);
    E(:,:,:,n) = ffun(intensity+1)/(t(n));
end
    

%% Calculate weigthing picture
zmin = 0;
zmax = 255;

W=images;
W(W > zmax/2) = zmax - W(W > zmax/2);
W=double(W);
W = W/255;

%% Calculate the final image
weigthedImage = W(:,:,:,1) .* E(:,:,:,1);
finalImage = zeros(size(weigthedImage));
 for n=2:14
        weigthedImage = W(:,:,:,n) .* E(:,:,:,n);
        finalImage = imadd(finalImage, weigthedImage);

 end
    
 
%%
%Plot E
for n=1:14
   
    figure();
    imshow(E(:,:,:,n),[]);
  
end
%%
%Plot viktfunktion
for n=1:14
   
    figure();
    imshow(W(:,:,:,n));
  
end

