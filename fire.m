% fire detection
%%%Fuction detects fire from the image in JPEG format
function [result, outImg] = fire(inImg)
%close all hidden;
delete('D:\workspace\matlab\ImageSegmentation_FireDetection\video\script\*')
Folder = 'D:\workspace\matlab\ImageSegmentation_FireDetection\video\script';
Im1 = inImg;
imwrite(Im1, fullfile(Folder, 'fire.jpg'));
%figure
%subplot (2,2,1)
%imshow(Im1);title('original image');colorbar;
%set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
rchannel =Im1( :,: ,1);
gchannel =Im1( :,: ,2);
bchannel =Im1( :,: ,3);

rr= (mean(mean(rchannel)))
gg= (mean(mean(gchannel)))
bb= (mean(mean(bchannel)))

%below lines for display the R, G and  B cloured  image
%
R = Im1;
R(:,:,2:3) = 0;
G = Im1;
G(:,:,[1 3]) = 0;
B = Im1;
B(:,:,1:2) = 0;
%subplot(2,2,2)
%image(R);
%imwrite(R,'R.jpg');
imwrite(R, fullfile(Folder, 'R.jpg'));
%red = R(:,:,1);
%pause(1);title('channels R');colorbar;

%subplot(2,2,3)
%image(G);
%imwrite(G,'G.jpg');
imwrite(G, fullfile(Folder, 'G.jpg'));
%green = G(:,:,2);
%pause(1);title('channels G');colorbar;

%subplot(2,2,4)
%image(B);
%imwrite(B,'B.jpg');
imwrite(B, fullfile(Folder, 'B.jpg'));
%blue = B(:,:,3);
%pause(1);title('channels B');colorbar;
%%

%Get histValues for each channel
%figure
[yRed, x] = imhist(rchannel);
[yGreen, x] = imhist(gchannel);
[yBlue, x] = imhist(bchannel);
%pl = plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

%%extracting chrominace , chrominace blue and red
Ydash = 16+(0.2567890625  * rchannel)+ (0.50412890625 * gchannel) +( 0.09790625 * bchannel);
Cb= 128+(-0.14822265625 * rchannel)-(0.2909921875 * gchannel) + (0.43921484375* bchannel);
Cr = 128+(0.43921484375  * rchannel)- (0.3677890625 * gchannel) -( 0.07142578125 * bchannel);
%% JPEg format
%Ydash= 0+( 0.299* rchannel)+ (0.587 *gchannel) +(0.114 * bchannel);
%Cb= 128+(-0.168736 * rchannel)-(0.331264 * gchannel) + (0.5* bchannel);
%Cr = 128+(0.5  * rchannel)- (0.418688 * gchannel) -( 0.081312 * bchannel);
%%
 Ymean=  (mean(mean(Ydash)))
 Cbmean= (mean(mean(Cb)))
 Crmean= (mean(mean(Cr)))
 Crstd= std2(Cr);
%figure
%set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

%subplot(2,2,1)
%imshow(Im1); title ('original image');
%pause(1);%colorbar;

%subplot(2,2,2)
%imshow(Ydash); title ('Ycomponent');
%imwrite(Ydash,'Y.jpg');
imwrite(Ydash, fullfile(Folder, 'Y.jpg'));
%pause(1);%colorbar;

%subplot(2,2,3)
%imshow(Cb); title ('Chrominance BLUE');
%imwrite(Cb,'Cb.jpg');
imwrite(Cb, fullfile(Folder, 'Cb.jpg'));
%pause(1);%colorbar;

%subplot(2,2,4)
%imshow(Cr); title ('Chrominance RED');
%imwrite(Cr,'Cr.jpg');
imwrite(Cr, fullfile(Folder, 'Cr.jpg'));
%pause(1);%colorbar;
%% one 
[R1r, R1c] = find(Ydash>Cb);
ruleIpixel=size(R1r);
Ir1= uint8(zeros(size(Im1)));
for i=1:ruleIpixel-1
    Ir1(R1r(i),R1c(i),1) =rchannel(R1r(i),R1c(i),1);
    Ir1(R1r(i),R1c(i),2) =gchannel(R1r(i),R1c(i),1);
    Ir1(R1r(i),R1c(i),3) =bchannel(R1r(i),R1c(i),1);
    i=i+1;
end
%figure
%subplot(3,2,1)
%set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
%imshow(Ir1)
%title('RULE ONE')
%%
%Rule 2
[R2r, R2c]= find((Ydash>Ymean) & (Cr > Crmean));
ruleIIpixel=size(R2r);
Ir2= uint8(zeros(size(Im1)));
for i2=1:ruleIIpixel-1
    Ir2(R2r(i2),R2c(i2),1) =rchannel(R2r(i2),R2c(i2));
    Ir2(R2r(i2),R2c(i2),2) =gchannel(R2r(i2),R2c(i2));
    Ir2(R2r(i2),R2c(i2),3) =bchannel(R2r(i2),R2c(i2));
    i2=i2+1;
end
%subplot(3,2,2)
%imshow(Ir2)
%title('RULE  TWO')
%%
% Rule I and Rule II
[R12r, R12c]= find((Ydash>Cb)&(Ydash>Ymean) &(Cr > Crmean));
ruleI_IIpixel=size(R12r);
Ir12= uint8(zeros(size(Im1)));
for i3=1:ruleI_IIpixel-1
    Ir12(R12r(i3),R12c(i3),1) =rchannel(R12r(i3),R12c(i3));
    Ir12(R12r(i3),R12c(i3),2) =gchannel(R12r(i3),R12c(i3));
    Ir12(R12r(i3),R12c(i3),3) =bchannel(R12r(i3),R12c(i3));
    i3=i3+1;
end
%subplot(3,2,3)
%imshow(Ir12)
%title('RULE ONE AND TWO')
%%
%%&rule three
[R3r, R3c]= find((Ydash>Cr) & (Cb>Cr) );
ruleIIIpixel=size(R3r);
Ir3= uint8(zeros(size(Im1)));
for i4=1:ruleIIIpixel-1
    Ir3(R3r(i4),R3c(i4),1) =rchannel(R3r(i4),R3c(i4));
    Ir3(R3r(i4),R3c(i4),2) =gchannel(R3r(i4),R3c(i4));
    Ir3(R3r(i4),R3c(i4),3) =bchannel(R3r(i4),R3c(i4));
    i4=i4+1;
end
%subplot(3,2,4)
%imshow(Ir3)
%title('RULE THREE')
%%
%%&rule four
[R4r, R4c]= find((Cr<(7.4*Crstd)));
ruleIVpixel=size(R4r);
Ir4= uint8(zeros(size(Im1)));
for i5=1:ruleIVpixel-1
    
    Ir4(R4r(i5),R4c(i5),1) =rchannel(R4r(i5),R4c(i5));
    Ir4(R4r(i5),R4c(i5),2) =gchannel(R4r(i5),R4c(i5));
    Ir4(R4r(i5),R4c(i5),3) =bchannel(R4r(i5),R4c(i5));
    i5=i5+1;
end
%subplot(3,2,5)
%imshow(Ir4)
%title('RULE Four')
%%
%RULE THREE AND FOUR 
[R6r, R6c]= find((Ydash>Cr) & (Cb> Cr) &(Cr<(7.4*Crstd)));
ruleVIpixel=size(R6r);
Ir6= uint8(zeros(size(Im1)));
for i6=1:ruleVIpixel-1
    
    Ir6(R6r(i6),R6c(i6),1) =rchannel(R6r(i6),R6c(i6));
    Ir6(R6r(i6),R6c(i6),2) =gchannel(R6r(i6),R6c(i6));
    Ir6(R6r(i6),R6c(i6),3) =bchannel(R6r(i6),R6c(i6));
    i6=i6+1;
end
%subplot(3,2,6)
%imshow(Ir6)
%title('RULE Four and Rule 3')
%%
f_f = imadd(Ir12,Ir6);
%imwrite(f_f, fullfile(Folder, 'firedetection.jpg'));
[R7r , ~] = find( (f_f(:,:,1)> f_f(:,:,3) )&( f_f(:,:,2) > f_f(:,:,3)) & (f_f(:,:,3 )< 100));
[rows, columns] = size(Im1(:,:,1));
[ff_r,~]= size(R7r);
if (ff_r>( rows*columns*4/100) )
    %figure
    imshow(f_f)
    outImg = f_f;
    imwrite(f_f, fullfile(Folder, 'firedetect.jpg'));
    %title('fire detected');
    result = 1;
    
else
     Ifinal= uint8(zeros(size(Im1)));
     %figure
     %imshow(Ifinal)
     outImg = Ifinal;
     imwrite(Ifinal, fullfile(Folder, 'firenotdetect.jpg'));
     %title('fire not detected');
     result = 0;
    
end
end
