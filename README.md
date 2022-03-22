# Modesty Detector

This code detects if a person is dressed inmodestly; if they show too much skin. It uses deep neural networks for semantic segmentation, and pose detection. It uses the MATLAB computer vision toolbox for face detection. The skin color is taken from the face. Then using the poses it computes the percentage of skin shown in each body part.

This code was made on MATLAB version '9.11.0.1769968 (R2021b)'.

The tool is used as follows:

For a single image:

>> modestyResults = getModestyScore('TestImage1.jpg')

>> modestyResults = getModestyScore('TestImage1.jpg')

modestyResults = 

  struct with fields:

    FilePath: 'TestImage1.jpg'
        Data: [1×6 struct]

>> modestyResults.Data(2)

ans = 

  struct with fields:

    scoreAvg1: 78.5358
    scoreAvg2: 78.1526
     scoreMax: 84.0483
                     
Results above is in percentage, where 10%% is all skin and 0% is no skin. 
* scoreAvg1 (AllAvg in image) => Average skin percentage in all parts. 
* scoreAvg2 (TorsoAvg in image) => Average skin percentage in torso and 4 limbs adjacent to the torso. 
* scoreMax (TorsoMax in image)  => Maximum skin percentage in torso and 4 limbs adjacent to the torso.

This also displays the results in the image:

![alt text](http://url/to/modestyResults.png)

To do this on a whole folder:

>> modestyResults = getModestyForFolder('C:\yourFolderPath')

