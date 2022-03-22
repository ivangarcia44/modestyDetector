function [faceColor, imgMask] = getFaceColor(faceImg)

imgSize = size(faceImg);
diameter = min(imgSize(1:2));

imgMask = zeros(imgSize, 'uint8');
for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        if sqrt((i - imgSize(1)/2)^2 + (j - imgSize(2)/2)^2) <= (diameter / 2)
            imgMask(i,j,:) = uint8(1);
        end
    end
end
colorSum = sum(imgMask .* faceImg, [1,2]);
totalPixels = sum(imgMask, [1,2]);

faceColor = uint8(colorSum ./ totalPixels);

end