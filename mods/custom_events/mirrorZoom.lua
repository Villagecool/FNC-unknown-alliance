function onEvent(name, value1, value2)
	if name == 'mirrorZoom' then
		zoom = tonumber(value1) --converts Zoom to number
		time = tonumber(value2) --converts Duration to number

		--tweenstuffs
		varNum = getProperty('mirrorZoom.x')
		if zoom == varNum then
			return
		else
			doTweenX('mirrorZoom', 'mirrorZoom', zoom, time, 'cubeOut')
			updateShader()
		end
	end
end