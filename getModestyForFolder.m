function modestyResults = getModestyForFolder(aFolderPath)
    jpgFiles = dir([aFolderPath, '/*.jpg']);
    jpegFiles = dir([aFolderPath, '/*.jpeg']);
    allFiles = {jpgFiles.name, jpegFiles.name};

    downloadNets();

    numFiles = numel(allFiles);
    tempResults = cell(1, numFiles);
    for i = 1:numFiles
        tempResults{i} = getModestyScore([aFolderPath, '/', allFiles{i}]);
    end

    modestyResults = tempResults;
end

