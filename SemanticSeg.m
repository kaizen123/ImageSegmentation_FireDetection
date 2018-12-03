% this program runs with matlab r2017b. it works but this is matlab 2017a,
% so this doesn't run.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use this link to download dataset and train set. or can config the
%pretrainedFolder with your link
pretrainedURL = 'https://www.mathworks.com/supportfiles/vision/data/segnetVGG16CamVid.mat';
pretrainedFolder = fullfile('Seg','pretrainedSegNet');
pretrainedSegNet = fullfile(pretrainedFolder,'segnetVGG16CamVid.mat');
if ~exist(pretrainedFolder,'dir')
     mkdir(pretrainedFolder);
     disp('Downloading pretrained SegNet (107 MB)...');
     websave(pretrainedSegNet,pretrainedURL);
end

imageURL = 'http://web4.cs.ucl.ac.uk/staff/g.brostow/MotionSegRecData/files/701_StillsRaw_full.zip';
labelURL = 'http://web4.cs.ucl.ac.uk/staff/g.brostow/MotionSegRecData/data/LabeledApproved_full.zip';

outputFolder = fullfile('Seg', 'CamVid');

%change outputFolder with your link
if ~exist(outputFolder, 'dir')
     disp('Downloading 557 MB CamVid dataset...');
 
     unzip(imageURL, fullfile(outputFolder,'images'));
     unzip(labelURL, fullfile(outputFolder,'labels'));
 end

imgDir = fullfile(outputFolder,'images','701_StillsRaw_full');
imds = imageDatastore(imgDir);

I = readimage(imds, 1);
I = histeq(I);
figure
imshow(I)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classes = [
    'Sky'
    'Building'
    'Pole'
    'Road'
    'Pavement'
    'Tree'
    'SignSymbol'
    'Fence'
    'Car'
    'Pedestrian'
    'Bicyclist'
    ];


labelIDs = camvidPixelLabelIDs();

labelDir = fullfile(outputFolder,'labels');
pxds = pixelLabelDatastore(labelDir,classes,labelIDs);

C = readimage(pxds, 1);

cmap = camvidColorMap;
B = labeloverlay(I,C,'ColorMap',cmap);

figure
imshow(B)
pixelLabelColorbar(cmap,classes);















