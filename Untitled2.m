I = imread('2.jpg');
I = rgb2gray(I);
imshow(I)
BW1 = edge(I,'sobel');
BW2 = edge(I,'canny');
imshow(BW1);
figure, imshow(BW2)
figure, imcontour(I)