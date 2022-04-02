function downloadNets()

semSegFileName = 'maskrcnn_object_person_car.mat';
poseNetFileName = 'posesNet.mat';
if ~isfile(poseNetFileName) 
    downloadPosesNet();
end
if ~isfile('maskrcnn_object_person_car.mat') 
    downloadSemSegNet();
end
assert(isfile(semSegFileName), [semSegFileName, ' file was not found']);
assert(isfile(poseNetFileName), [poseNetFileName, ' file not found']);

end

