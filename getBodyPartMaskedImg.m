function [partImg, maskImg] = getBodyPartMaskedImg(aBodyPart, aImg, aPoses, aAngleTwistRate, aNewSizeRate)

line = getPoseLine(aPoses, 1, aBodyPart);
if isempty(line) || any(isnan(line))
    maskImg = uint8(zeros(size(aImg)));
    partImg = uint8(maskImg) .* aImg;
    maskImg = maskImg(:,:,1);
else
    regionPoly = getPartPolyRegionForLine(line, aAngleTwistRate, aNewSizeRate);
    
    img2 = insertShape(aImg, 'FilledPolygon', regionPoly, 'Color', 'white');
    imshow(insertShape(img2, 'Line', line, 'Color', 'yellow'));
    
    maskImg = uint8(zeros(size(aImg)));
    maskImg = insertShape(maskImg, 'FilledPolygon', regionPoly, 'Color', 'white') > 0;
    
    partImg = uint8(maskImg) .* aImg;
    
    maskImg = maskImg(:,:,1);
end

end