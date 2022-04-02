function semSegNet = downloadSemSegNet()

semSegFileName = 'maskrcnn_object_person_car.mat';

if isfile(semSegFileName) 
    semSegNet = load(semSegFileName);
    semSegNet = semSegNet.semSegNet;
else
    try
        dataFolder = fullfile(pwd,"coco");
        trainedMaskRCNN_url = "https://www.mathworks.com/supportfiles/vision/data/maskrcnn_object_person_car_v2.mat";

        filename = 'maskrcnn_pretrained_person_car.mat';
        netDirFullPath = dataFolder;
        netFileFullPath = fullfile(dataFolder,filename);

        if ~exist(netFileFullPath,'file')
            fprintf('Downloading pretrained MaskRCNN network.\n');
            fprintf('This can take several minutes to download...\n');
            if ~exist(netDirFullPath,'dir')
                mkdir(netDirFullPath);
            end
            websave(netFileFullPath,trainedMaskRCNN_url);
            fprintf('Done.\n\n');
        else
            fprintf('Pretrained MaskRCNN network already exists.\n\n');
        end
        pretrained = load(fullfile(dataFolder,"maskrcnn_pretrained_person_car.mat"));

        semSegNet = pretrained.net;
        
        save(semSegFileName, 'semSegNet');
    catch e
        assert(false, ['Could not get semantic segmentation network: ', e.message]);
    end
end

end