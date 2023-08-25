imageFiles = dir('/Users/noor/Library/CloudStorage/OneDrive-SharedLibraries-VirginiaTech/Embodied Brain Lab - Documents/dance_brain_summer22/interbrain_sync_analysis/data/danc012/danc012_postest/eyegaze/eyegaze_coherograms/*.png'); % Replace 'path_to_folder' with the actual folder containing your PNG images

numImages = length(imageFiles);
images = cell(1, numImages);

for i = 1:numImages
    images{i} = imread(fullfile('/Users/noor/Library/CloudStorage/OneDrive-SharedLibraries-VirginiaTech/Embodied Brain Lab - Documents/dance_brain_summer22/interbrain_sync_analysis/data/danc012/danc012_postest/eyegaze/eyegaze_coherograms', imageFiles(i).name));
end


gifFileName = 'output.gif';
delayTime = 2; % Adjust the delay time between frames as needed

for i = 1:numImages
    [A, map] = rgb2ind(images{i}, 256);
    if i == 1
        imwrite(A, map, gifFileName, 'gif', 'LoopCount', Inf, 'DelayTime', delayTime);
    else
        imwrite(A, map, gifFileName, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
    end
end

videoFileName = 'output.mp4';
frameRate = 5; % Adjust the frame rate as needed (frames per second)

videoObj = VideoWriter(videoFileName, 'MPEG-4');
videoObj.FrameRate = frameRate;
open(videoObj);

for i = 1:numImages
    writeVideo(videoObj, images{i});
end

close(videoObj);