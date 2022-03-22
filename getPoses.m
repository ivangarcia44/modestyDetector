function poseLines = getPoses(aPosesNet, aImg)

netInput = im2single(aImg)-0.5;
netInput = netInput(:,:,[3 2 1]);
netInput = dlarray(netInput,"SSC");

[heatmaps,pafs] = predict(aPosesNet, netInput);

heatmaps = extractdata(heatmaps);
displayHeatMap(heatmaps, aImg);

heatmaps = heatmaps(:,:,1:end-1);
pafs = extractdata(pafs);
displayPafs(pafs, aImg)

params = getBodyPoseParameters();

poses = getBodyPoses(heatmaps,pafs,params);

poseLines = renderBodyPoses(aImg,poses,size(heatmaps,1),size(heatmaps,2),params);

end


function displayHeatMap(aHeatMaps, aImg)
    montage(rescale(aHeatMaps),"BackgroundColor","b","BorderSize",3);

    idx = 1;
    hmap = aHeatMaps(:,:,idx);
    hmap = imresize(hmap,size(aImg,[1 2]));
    imshowpair(hmap,aImg);
end

function displayPafs(aPafs, aImg)
    montage(rescale(aPafs),"Size",[19 2],"BackgroundColor","b","BorderSize",3);
    idx = 1;
    impair = horzcat(aImg,aImg);
    pafpair = horzcat(aPafs(:,:,2*idx-1),aPafs(:,:,2*idx));
    pafpair = imresize(pafpair,size(impair,[1 2]));
    imshowpair(pafpair,impair);
end