local intensidad = 0
local intervalo = 0
function onEvent(n,v1,v2)


	if n == 'Camera_Zoom_Beat' then

	   intensidad = v1
	   intervalo = v2
	end



end

function onBeatHit()
   if curBeat % intervalo == 0 then
      triggerEvent('Add Camera Zoom',0.015 * intensidad, 0.03 * intensidad) 
   end
end
