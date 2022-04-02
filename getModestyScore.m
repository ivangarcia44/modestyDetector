function modestyResults = getModestyScore(aFilePath)
    persistent posesNet;
    if isempty(posesNet)
        posesNet = coder.loadDeepLearningNetwork(coder.const('posesNet.mat'));
    end
    persistent semSegNet;
    if isempty(semSegNet)
        temp = load('maskrcnn_object_person_car.mat', 'semSegNet');
        semSegNet = temp.semSegNet;
    end

    img = imread(aFilePath);

    imshow(img);
    [masks,labels,~,boxes] = segmentObjects(semSegNet,img);
    numOfPersons = numel(labels);
    modestyResults.FilePath = aFilePath;
    modestyResults.Data = repmat(struct('scoreAvg1', -1, 'scoreAvg2', -1, 'scoreMax', -1), 1, numOfPersons);

    if numOfPersons < 1
        return;
    end

    showShape("rectangle",gather(boxes),"Label",labels,"LineColor",'r');

    overlayedImage = insertObjectMask(img, masks);
    imshow(overlayedImage);

    strLabels = cell(size(labels));
    labelCoords = zeros(numOfPersons, 2);

    for i = 1:numOfPersons
        currBox = boxes(i,:);
        labelCoords(i, 1) = currBox(1); 
        labelCoords(i, 2) = currBox(2); 
    end
    
    for i = 1:numOfPersons
        bodyMask = masks(:,:,i);
        bdImg = img .* uint8(bodyMask);
        imshow(bdImg);
    
        [scoreAvg1, scoreAvg2, scoreMax, skImg] = getModestyForPerson(bdImg, posesNet, bodyMask);
        if scoreAvg1 > 0
            imshow(skImg);
            modestyResults.Data(i).scoreAvg1 = scoreAvg1;
            modestyResults.Data(i).scoreAvg2 = scoreAvg2;
            modestyResults.Data(i).scoreMax = scoreMax;
            strLabels{i} = sprintf('person\nAllAvg=%f\nTorsoAvg=%f\nTorsoMax=%f', ...
                                   scoreAvg1, ...
                                   scoreAvg2, ...
                                   scoreMax);
        else
            strLabels{i} = char(labels(i));
        end
    end

    labeldImg = insertText(img,labelCoords,strLabels,'FontSize',12,'BoxColor',...
                           'yellow','BoxOpacity',0.8,'TextColor','black');
    imshow(labeldImg);
end