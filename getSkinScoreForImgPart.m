function [modestyPercentage, skImg] = getSkinScoreForImgPart(aImgPart, aFaceColor, aPartMask)
    bodyColorFilter = aFaceColor .* uint8(ones(size(aImgPart)));

    diffImg =  uint8(sqrt(sum((rgb2hsv(aImgPart) - rgb2hsv(bodyColorFilter)).^2 ,3)) < 0.5);
    diffImgMask =  repmat(diffImg, [1 1 3]);

    skImg =  diffImgMask .* aImgPart;
    
    imshow(skImg);

    modestyPercentage = 100 * sum(diffImg, 'all') / sum(aPartMask, 'all');
end