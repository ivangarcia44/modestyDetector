function bbox = pickLargestBoundingBox(aBboxes)
    sizes = aBboxes(:, 3) .* aBboxes(:, 4);

    [~, idxes] = sort(sizes, 'descend');

    bbox = aBboxes(idxes(1),:);
end