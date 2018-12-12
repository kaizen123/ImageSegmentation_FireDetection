Folder = 'D:\workspace\matlab\ImageSegmentation_FireDetection\dataset\fire\';
FileList = dir(fullfile(Folder, '*.jpg'));
length(FileList)
count = 0;
for iFile = 1:length(FileList)
    aFile = fullfile(Folder, FileList(iFile).name);
    inImg1 = imread(aFile);
    [re, outImg1] = test_fire(inImg1, count);
    count = count + re
end


