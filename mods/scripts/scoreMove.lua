function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function goodNoteHit(id,dir,type,sus)
if dir == 0 then
setProperty('scoreTxt.angle',1.5)
doTweenAngle('scoreAngle','scoreTxt',0,0.2)
elseif dir == 1 then
setProperty('scoreTxt.angle',1.5)

doTweenAngle('scoreAngle','scoreTxt',0,0.2)
elseif dir == 2 then
setProperty('scoreTxt.angle',-1.5)
doTweenAngle('scoreAngle','scoreTxt',0,0.2)
elseif dir == 3 then
setProperty('scoreTxt.angle',-1.5)
doTweenAngle('scoreAngle','scoreTxt',0,0.2)

end
end 