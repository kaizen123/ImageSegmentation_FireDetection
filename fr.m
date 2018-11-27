i=imread('nang.jpg');
C = makecform('srgb2Lab');
i_Lab = applycform(i,C);
x=i_Lab(:,:,1);
y=i_Lab(:,:,2);
z=i_Lab(:,:,3);
L=sum(x);
L=sum(L');
a=sum(y);
a=sum(a');
b=sum(z);
b=sum(b');
d=zeros(150,200);
L=L/(150*200);
a=a/(150*200);
b=b/(150*200);

for p=1:1:150
for q=1:1:200
if (x(p,q)>L)
d(p,q)=1;
else d(p,q)=0;
end;
end;
end;
e=zeros(150,200);
for p=1:1:150
for q=1:1:200
if (y(p,q)>a)
e(p,q)=1;
else e(p,q)=0;
end;
end;
end;
f=zeros(150,200);
for p=1:1:150
for q=1:1:200
if (z(p,q)>b)
f(p,q)=1;
else f(p,q)=0;
end;
end;
end;
g=zeros(150,200);
for p=1:1:150
for q=1:1:200
if (y(p,q)>z(p,q))
g(p,q)=1;
else g(p,q)=0;
end;
end;
end;
h=zeros(150,200);
for p=1:1:150
for q=1:1:200
if (d(p,q)&&e(p,q)&&f(p,q)&&g(p,q)==1)
h(p,q)=1;
else h(p,q)=0;
end;
end;
end;
h=sum(h);
h=sum(h');
if (h <10 )

rgbImage = imread('nang.jpg');
set(gcf, 'Position', get(0, 'ScreenSize'));

redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);

redthreshold = 68;
greenThreshold = 70;
blueThreshold = 72;
redMask = (redBand > redthreshold);
greenMask = (greenBand < greenThreshold);
blueMask = (blueBand < blueThreshold);

redObjectsMask = uint8(redMask & greenMask & blueMask);

imshow(redObjectsMask, []);
title('Red Objects Mask');
maskedrgbImage = uint8(zeros(size(redObjectsMask)));
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;

imshow(maskedrgbImage);
title('region of fire image');
else
rgbImage = imread('nang.jpg');
set(gcf, 'Position', get(0, 'ScreenSize'));

redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);

redthreshold = 68;
greenThreshold = 70;
blueThreshold = 72;
redMask = (redBand > redthreshold);
greenMask = (greenBand < greenThreshold);
blueMask = (blueBand < blueThreshold);

redObjectsMask = uint8(redMask & greenMask & blueMask);

imshow(redObjectsMask, []);
title('Red Objects Mask');
maskedrgbImage = uint8(zeros(size(redObjectsMask)));
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;

imshow(maskedrgbImage);
title('region of fire image');
end;