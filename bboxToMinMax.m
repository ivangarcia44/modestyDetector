function minMaxCoords = bboxToMinMax(aBbox)

minMaxCoords = [aBbox(1:2), aBbox(1:2) + aBbox(3:4)];

end