function bboxesIntersect = doBboxesIntersect(aBbox1, aBbox2)
    bb1 = getBboxCoordPair(aBbox1);
    bb2 = getBboxCoordPair(aBbox2);

    minX = min(bb1(1), bb2(1));
    maxX = max(bb1(3), bb2(3));
    minY = min(bb1(2), bb2(2));
    maxY = max(bb1(4), bb2(4));

    mask1 = zeros(maxX - minX + 1, maxY - minY + 1) == 1;
    mask2 = zeros(maxX - minX + 1, maxY - minY + 1) == 1;

    mask1((bb1(1):bb1(3)) - minX + 1, (bb1(2):bb1(4)) - minY + 1) = true;
    mask2((bb2(1):bb2(3)) - minX + 1, (bb2(2):bb2(4)) - minY + 1) = true;

    bboxesIntersect = sum(mask1 & mask2, 'all') > 0;
end

function bboxOut = getBboxCoordPair(aBbox)
    bboxOut = [aBbox(1:2), aBbox(1) + aBbox(3), aBbox(2) + aBbox(4)];
end