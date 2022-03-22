function [scoreAvg1, scoreAvg2, scoreMax, skImg] = getModestyForPerson(aPersonImg, aPostNet, aBodyMask)

    poseLines = getPoses(aPostNet, aPersonImg);

    faceDetector = vision.CascadeObjectDetector();
    bbox = faceDetector.step(aPersonImg);
    if isempty(bbox) 
        scoreAvg1 = -1;
        scoreAvg2 = -1;
        scoreMax = -1;
        skImg = uint8(zeros(size(aPersonImg)));
        return;
    elseif size(bbox,1) > 1
        bbox = pickLargestBoundingBox(bbox);
    end
    imgOut = insertObjectAnnotation(aPersonImg,'rectangle',bbox,'Face');

    imshow(imgOut)

    minMaxCoords = bboxToMinMax(bbox);
    face = aPersonImg(minMaxCoords(2):minMaxCoords(4), minMaxCoords(1):minMaxCoords(3), :);
    imshow(face);

    [faceColor, imgMask] = getFaceColor(face);

    faceColors = faceColor .* uint8(ones(size(face)));

    imshow(faceColors);

    [leftShoulder, leftShoulderMask] = getBodyPartMaskedImg(BodyParts.LeftShoulder, aPersonImg, poseLines, 0, 1);
    [rightShoulder, rightShoulderMask] = getBodyPartMaskedImg(BodyParts.RightShoulder, aPersonImg, poseLines, 0, 1);
    [leftElbow, leftElbowMask] = getBodyPartMaskedImg(BodyParts.LeftElbow, aPersonImg, poseLines, 0.35, .3);
    [rightElbow, rightElbowMask] = getBodyPartMaskedImg(BodyParts.RightElbow, aPersonImg, poseLines, 0.35, .3);
    [leftHip, leftHipMask] = getBodyPartMaskedImg(BodyParts.LeftHip, aPersonImg, poseLines, 0.35, .3);
    [rightHip, rightHipMask] = getBodyPartMaskedImg(BodyParts.RightHip, aPersonImg, poseLines, 0.35, .3);
    [leftKnee, leftKneeMask] = getBodyPartMaskedImg(BodyParts.LeftKnee, aPersonImg, poseLines, 0.35, .3);
    [rightKnee, rightKneeMask] = getBodyPartMaskedImg(BodyParts.RightKnee, aPersonImg, poseLines, 0.35, .3);
        
    totalParts = leftShoulder + rightShoulder + leftElbow + rightElbow + leftHip + rightHip + ...
                 leftKnee + rightKnee;
    imshow(totalParts);
    
    skImg = uint8(zeros(size(aPersonImg)));
    [~, currSkImg] = getSkinScoreForImgPart(aPersonImg, faceColor, aBodyMask);
%     skImg = skImg + currSkImg;
    [leftShoulderRate, currSkImg] = getSkinScoreForImgPart(leftShoulder, faceColor, leftShoulderMask);
    skImg = skImg + currSkImg;
    [rightShoulderRate, currSkImg] = getSkinScoreForImgPart(rightShoulder, faceColor, rightShoulderMask);
    skImg = skImg + currSkImg;
    [leftElbowRate, currSkImg] = getSkinScoreForImgPart(leftElbow, faceColor, leftElbowMask);
    skImg = skImg + currSkImg;
    [rightElbowRate, currSkImg] = getSkinScoreForImgPart(rightElbow, faceColor, rightElbowMask);
    skImg = skImg + currSkImg;
    [leftHipRate, currSkImg] = getSkinScoreForImgPart(leftHip, faceColor, leftHipMask);
    skImg = skImg + currSkImg;
    [rightHipRate, currSkImg] = getSkinScoreForImgPart(rightHip, faceColor, rightHipMask);
    skImg = skImg + currSkImg;
    [leftKneeRate, currSkImg] = getSkinScoreForImgPart(leftKnee, faceColor, leftKneeMask);
    skImg = skImg + currSkImg;
    [rightKneeRate, currSkImg] = getSkinScoreForImgPart(rightKnee, faceColor, rightKneeMask);
    skImg = skImg + currSkImg;
    
    scoreAvg1 = (leftShoulderRate + rightShoulderRate + ...
        20*leftElbowRate + 20*rightElbowRate + 20*leftHipRate + 20*rightHipRate + ...
        50*leftKneeRate + 50*rightKneeRate) / 182;
    scoreAvg2 = (leftKneeRate + rightKneeRate) / 2;
    scoreMax = max([leftElbowRate, rightElbowRate, leftHipRate, rightHipRate, ...
        leftKneeRate, rightKneeRate], [], 'all');
end