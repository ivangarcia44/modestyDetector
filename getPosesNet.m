function posesNet = getPosesNet(aModelFile)
    layers = importONNXLayers(aModelFile,"ImportWeights",true);
    layers = removeLayers(layers,layers.OutputNames);
    posesNet = dlnetwork(layers);
end