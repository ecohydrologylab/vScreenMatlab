function[cYZ] = callWholePlume(cX)

cY = cat(2,flip(cX,2),cX(:,2:end,:));
cYZ = cat(3,flip(cY,3),cY(:,:,2:end)); % cYZ = cY;
