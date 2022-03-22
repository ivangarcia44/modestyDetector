function modestyResults = getModestyForFolder(aFolderPath)
    jpgFiles = dir([aFolderPath, '/*.jpg']);
    jpegFiles = dir([aFolderPath, '/*.jpeg']);
    allFiles = {jpgFiles.name, jpegFiles.name};

    semSegFileName = 'maskrcnn_object_person_car.mat';
    poseNetFileName = 'posesNet.mat';
    if ~isfile(poseNetFileName)
        posesNet = getPosesNet('human-pose-estimation.onnx');
        save(poseNetFileName, 'posesNet');
    end
    assert(isfile(semSegFileName), [semSegFileName, ' file was not found']);
    assert(isfile(poseNetFileName), [poseNetFileName, ' file not found']);

    numFiles = numel(allFiles);
    tempResults = cell(1, numFiles);
    for i = 1:numFiles
        tempResults{i} = getModestyScore([aFolderPath, '/', allFiles{i}]);
    end

    modestyResults = tempResults;
end

