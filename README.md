# modestyDetector

This code was made on MATLAB version '9.11.0.1769968 (R2021b)'. I am not sure if it works for previous versions.

This code detects if a person is dressed inmodestly; if they show too much skin. It uses deep neural networks for semantic segmentation, and pose detection. It uses the MATLAB computer vision toolbox for face detection. The skin color is taken from the face. Then using the poses it computes the percentage of skin shown in each body part.

The tool is used as follows:

% For a single image:

>> load('maskrcnn_object_person_car.mat', 'net');
>> posesNet = getPosesNet('human-pose-estimation.onnx');

>> fileName = 'C:\yourpath\image.jpg';

>> modestyResults = getModestyScore(net, posesNet, fileName)

modestyResults = 

  struct with fields:

    FilePath: 'D:\Fotos\Fotos 2007\IvanDianaHangeo\IM000034.jpg'
        Data: [1×1 struct]
        
>> modestyResults.Data

ans = 

  struct with fields:

    scoreAvg1: 44.2652
    scoreAvg2: 59.1407
     scoreMax: 83.5622
     
% Results above is in percentage, where 10%% is all skin and 0% is no skin. 
% * scoreAvg1 => Average skin in all parts
% * scoreAvg2 => Average skin thighs
% * scoreMax  => Part with maximum skin shown. This mean that a par is showing 83% skin. In this case is the left arm.

% To do this on a whole folder:

>> modestyResults = getModestyForFolder('C:\yourFolderPath')

