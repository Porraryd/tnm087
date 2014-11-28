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

A = CC\HC;

%%
fusedImage = Him;
%fusedImage(:,:) = Him(:,:) + A*Cim(:,:);

for x=1:500
    for y=1:512
        p = A * [x,y,1]';
        p = int8(p);
        p(p<=0) =1;
        fusedImage(x,y) = Him(p(1), p(2));
        %Him(x,y) = Him(p(1), p(2));
    end
end