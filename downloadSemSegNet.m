function semSegNet = downloadSemSegNet()

semSegFileName = 'maskrcnn_object_person_car.mat';

if isfile(semSegFileName) 
    semSegNet = load(semSegFileName);
    semSegNet = semSegNet.semSegNet;
else
    try
        dataFolder = fullfile(pwd,"coco");
        trainedMaskRCNN_url = "https://www.mathworks.com/supportfiles/vision/data/maskrcnn_object_person_car_v2.mat";
        helper.downloadTrainedMaskRCNN(trainedMaskRCNN_url,dataFolder);
        pretrained = load(fullfile(dataFolder,"maskrcnn_object_person_car.mat"));
        semSegNet = pretrained.net;
        
        save(semSegFileName, 'semSegNet');
    catch e
        assert(false, ['Could not get semantic segmentation network: ', e.message]);
    end
end

end