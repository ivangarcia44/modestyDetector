function regionPoly = getPartPolyRegionForLine(aLine, aAngleTwistRate, aNewSizeRate)

if nargin < 2
    aAngleTwistRate = 0.3;
    aNewSizeRate = 0.25;
end

s = sqrt((aLine(1) - aLine(3)).^2 + (aLine(2) - aLine(4)).^2);

angle = atan2((aLine(2) - aLine(4)), (aLine(1) - aLine(3)));

regionPoly = zeros(1, 10);

newAngle = angle - pi/2;
angleTwist = aAngleTwistRate * pi / 2;
newSize = aNewSizeRate * s / 2;

regionPoly(1) = newSize * cos(newAngle - angleTwist) + aLine(1);
regionPoly(2) = newSize * sin(newAngle - angleTwist) + aLine(2);
regionPoly(3) = aLine(1);
regionPoly(4) = aLine(2);
regionPoly(5) = -newSize * cos(newAngle + angleTwist) + aLine(1);
regionPoly(6) = -newSize * sin(newAngle + angleTwist) + aLine(2);
regionPoly(7) = -newSize * cos(newAngle - angleTwist) + aLine(3);
regionPoly(8) = -newSize * sin(newAngle - angleTwist) + aLine(4);
regionPoly(9) = aLine(3);
regionPoly(10) = aLine(4);
regionPoly(11) = newSize * cos(newAngle + angleTwist) + aLine(3);
regionPoly(12) = newSize * sin(newAngle + angleTwist) + aLine(4);

end