function line = getPoseLine(aPoses, aPose, aBodyPart)

line = [];

if isempty(aPoses)
    return;
end

switch(aBodyPart)
    case BodyParts.LeftShoulder
        line = squeeze(aPoses(aPose, 1, :));
    case BodyParts.RightShoulder
        line = squeeze(aPoses(aPose, 2, :));
    case BodyParts.RightElbow
        line = squeeze(aPoses(aPose, 3, :));
    case BodyParts.RightHand
        line = squeeze(aPoses(aPose, 4, :));
    case BodyParts.LeftElbow
        line = squeeze(aPoses(aPose, 5, :));
    case BodyParts.LeftHand
        line = squeeze(aPoses(aPose, 6, :));
    case BodyParts.RightHip
        line = squeeze(aPoses(aPose, 7, :));
    case BodyParts.RightKnee
        line = squeeze(aPoses(aPose, 8, :));
    case BodyParts.RightFoot
        line = squeeze(aPoses(aPose, 9, :));
    case BodyParts.LeftHip
        line = squeeze(aPoses(aPose, 10, :));
    case BodyParts.LeftKnee
        line = squeeze(aPoses(aPose, 11, :));
    case BodyParts.LeftFoot
        line = squeeze(aPoses(aPose, 12, :));
    case BodyParts.Neck
        line = squeeze(aPoses(aPose, 13, :));
    case BodyParts.Nose
        line = squeeze(aPoses(aPose, 14, :));
    case BodyParts.RightEye
        line = squeeze(aPoses(aPose, 15, :));
    case BodyParts.LeftEye
        line = squeeze(aPoses(aPose, 16, :));
    case BodyParts.LeftEar
        line = squeeze(aPoses(aPose, 17, :));
    case BodyParts.RightEar
        line = squeeze(aPoses(aPose, 18, :));
    otherwise
        assert(false, 'Bad body part!');
end

line = line';

end