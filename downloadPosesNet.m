function posesNet = downloadPosesNet()

posesFileName = 'posesNet.mat';

if isfile(posesFileName) 
    posesNet = load(posesFileName);
    posesNet = posesNet.posesNet;
else
    try
        destination = fullfile(pwd,'OpenPose');
        url = 'https://ssd.mathworks.com/supportfiles/vision/data/human-pose-estimation.zip';
        
        filename = 'human-pose-estimation.zip';
        netDirFullPath = destination;
        netFileFullPath = fullfile(destination,filename);
        
        if ~exist(netFileFullPath,'file')
            fprintf('Downloading pretrained OpenPose network.\n');
            fprintf('This can take several minutes to download...\n');
            if ~exist(netDirFullPath,'dir')
                mkdir(netDirFullPath);
            end
            websave(netFileFullPath,url);
            fprintf('Done.\n\n');
        else
            fprintf('Pretrained OpenPose network already exists.\n\n');
        end
        
        unzip(fullfile(destination,'human-pose-estimation.zip'),destination);
        
        modelfile = fullfile(destination,'human-pose-estimation.onnx');
        layers = importONNXLayers(modelfile,"ImportWeights",true);

        layers = removeLayers(layers,layers.OutputNames);
        posesNet = dlnetwork(layers);
        
        save(posesFileName, 'posesNet');
    catch e
        assert(false, ['Could not get poses network: ', e.message]);
    end
end

end