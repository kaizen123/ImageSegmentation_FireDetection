try
cam = webcam;
preview(cam)
delete('D:\workspace\matlab\ImageSegmentation\video\image\*')
Folder = 'D:\workspace\matlab\ImageSegmentation\video\image';
vidWriter = VideoWriter('D:\workspace\matlab\ImageSegmentation\video\realtime');
open(vidWriter);
re = 0;
for index = 1:10000000
    frame = index
    % Acquire frame for processing
    img = snapshot(cam);
    % Write frame to video
    writeVideo(vidWriter,img);
    imwrite(img, fullfile(Folder, sprintf('%06d.jpg', index)));
    re = fire(img);
    if re == 1
      msgbox('fire detected!');
      break;
    end
end
if re == 0
    msgbox('fire not detected!');
end
close(vidWriter);
clear cam
catch
end